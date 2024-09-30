const ExtractCredentialsMsg =
  """This command extracts credentials from command lines in Sysmon and Security event logs."""

type
  ExtractCredentialsCmd* = ref object of AbstractCmd
    seqOfResultsTables*: seq[Table[string, string]]

method filter*(self: ExtractCredentialsCmd, x: HayabusaJson): bool =
  let eidMatched = (x.EventID == 1 and x.Channel == "Sysmon") or (x.EventID == 4688 and x.Channel == "Sec")
  if not eidMatched:
    return false
  let cmdline = x.Details["Cmdline"].getStr().toLower()
  let commands = ["net user", "schtasks", "wmic", "psexec"]
  let cmdMatched = any(commands, proc(x: string): bool = x in cmdline)
  if "net user" in cmdline:
    return true # net user does not have password parameter
  let passwordPram = ["-p", "-password", "-passwd", "–password", "–passwd", "/p", "/password", "/passwd"]
  let passwordMatched = any(passwordPram, proc(x: string): bool = x in cmdline)
  return cmdMatched and passwordMatched

proc extractUserPass(cmd: string): (string, string) =
    let patterns = [
      (re(r".*/user:([^\s/]+).*"), re(r".*/password:([^\s/]+).*")),  # for wmic
      (re(r".*/U ([^\s/]+).*"), re(r".*/P ([^\s/]+).*")),  # for schtasks
      (re(r".*net user ([^\s/]+)"), re(r".*?([^\s/]+) /add.*")),  # for net user
      (re(r".*-u ([^\s/]+).*"), re(r".*-p ([^\s/]+).*"))  # for psexec
    ]

    for (userPattern, passwordPattern) in patterns:
      var username = ""
      var password = ""

      if cmd =~ userPattern:
        username = matches[0]

      if cmd =~ passwordPattern:
        password = matches[0]

      if username != "" and password != "":
        return (username, password)

    return ("", "")

method analyze*(self: ExtractCredentialsCmd, x: HayabusaJson) =
  var singleResultTable = initTable[string, string]()
  singleResultTable["Timestamp"] = x.Timestamp
  singleResultTable["Computer"] = x.Computer
  singleResultTable["Event"] = x.Channel & "-" & $(x.EventID)
  let cmd = x.Details["Cmdline"].getStr()
  let (user, pass) = extractUserPass(cmd)
  if user == "" and pass == "":
    return # skip if no user or password found
  singleResultTable["User"] = user
  singleResultTable["Password"] = pass
  singleResultTable["API Key"] = "N/A"
  singleResultTable["Cmdline"] = cmd
  self.seqOfResultsTables.add(singleResultTable)

method resultOutput*(self: ExtractCredentialsCmd) =
  var savedFiles = "n/a"
  var results = "n/a"
  let header = ["Timestamp", "Computer", "Event", "User", "Password", "API Key", "Cmdline"]
  if self.output != "":
    # Open file to save results
    var outputFile = open(self.output, fmWrite)

    ## Write CSV header
    outputFile.write(header.join(",") & "\p")

    ## Write contents
    for table in self.seqOfResultsTables:
      for i, key in enumerate(header):
        if table.hasKey(key):
          if i < header.len() - 1:
            outputFile.write(escapeCsvField(table[key]) & ",")
          else:
            outputFile.write(escapeCsvField(table[key]))
        else:
          outputFile.write(",")
      outputFile.write("\p")
    outputFile.close()
    let fileSize = getFileSize(self.output)
    savedFiles = self.output & " (" & formatFileSize(fileSize) & ")"
    results = "Events: " & intToStr(self.seqOfResultsTables.len).insertSep(',')
    if self.displayTable:
      echo ""
      echo "Saved results to " & savedFiles
  else:
    var table: TerminalTable
    table.add header
    for t in self.seqOfResultsTables:
      table.add t[header[0]], t[header[1]], t[header[2]], t[header[3]], t[header[4]], t[header[5]], t[header[6]]
    if self.displayTable:
      echo ""
      table.echoTableSepsWithStyled(seps = boxSeps)
      echo ""
  self.cmdResult = CmdResult(results: results, savedFiles: savedFiles)

proc extractCredentials(output: string = "", quiet: bool = false, skipProgressBar: bool = false, timeline: string) =
  checkArgs(quiet, timeline, "informational")
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = ExtractCredentialsCmd(
                timeline: timelinePath,
                skipProgressBar: skipProgressBar,
                output: output,
                name: "extract-credentials",
                msg: ExtractCredentialsMsg)
    cmd.analyzeJSONLFile()
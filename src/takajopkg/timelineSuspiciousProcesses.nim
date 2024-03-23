const TimelineSuspiciousProcessesMsg =
  """
This command will create a CSV timeline of suspicious processes.
The default minimum level of alerts is high.
You can change the minimum level with -l, --level=."""

type
  TimelineSuspiciousProcessesCmd* = ref object of AbstractCmd
    level*: string
    seqOfResultsTables*: seq[Table[string, string]]
    suspicousProcessCount_Sec_4688*, suspicousProcessCount_Sysmon_1 * = 0

method filter*(self: TimelineSuspiciousProcessesCmd, x: HayabusaJson): bool =
  return isMinLevel(x.Level, self.level) and (x.Channel == "Sec" and
      x.EventId == 4688) or (x.Channel == "Sysmon" and x.EventId == 1)

method analyze*(self: TimelineSuspiciousProcessesCmd, x: HayabusaJson) =
  # Found a Security 4688 process creation event
  var
    eventId, pidInt = 0
    channel, cmdLine, company, computer, description, eventLevel, eventType,
        hashes, hash_MD5, hash_SHA1, hash_SHA256, hash_IMPHASH,
        lid, lguid, ruleAuthor, ruleTitle, parentCmdline,
        parentGuid, parentPid, pidStr, process, processGuid, product, timestamp, user = ""
  let jsonLine = x
  if x.Channel == "Sec" and x.EventId == 4688 and isMinLevel(x.Level, self.level):
    inc self.suspicousProcessCount_Sec_4688
    try:
      cmdLine = jsonLine.Details["Cmdline"].getStr()
    except KeyError:
      cmdLine = ""
    eventType = "Security 4688"
    timestamp = jsonLine.Timestamp
    ruleTitle = jsonLine.RuleTitle
    computer = jsonLine.Computer
    process = jsonLine.Details["Proc"].getStr()
    pidStr = $jsonLine.Details["PID"].getInt()
    user = jsonLine.Details["User"].getStr()
    lid = jsonLine.Details["LID"].getStr()
    try:
      if pidStr == "0":
        # -F, --no-field-data-mapping JSONL requires hex conversion
        pidStr = intToStr(fromHex[int](jsonLine.Details["PID"].getStr()))
    except ValueError:
      discard
    try:
      ruleAuthor = jsonLine.RuleAuthor
    except KeyError:
      ruleAuthor = ""

    if self.output == "": # Output to screen
      echo "Timestamp: " & timestamp
      echo "Computer: " & computer
      echo "Type: " & eventType
      echo "Level: " & eventLevel
      echo "Rule: " & ruleTitle
      echo "RuleAuthor: " & ruleAuthor
      echo "Cmdline: " & cmdLine
      echo "Process: " & process
      echo "PID: " & pidStr
      echo "User: " & user
      echo "LID: " & lid
      echo ""
    else: # Add records to seqOfResultsTables to eventually save to file.
      var singleResultTable = initTable[string, string]()
      singleResultTable["Timestamp"] = timestamp
      singleResultTable["Computer"] = computer
      singleResultTable["Type"] = eventType
      singleResultTable["Level"] = eventLevel
      singleResultTable["Rule"] = ruleTitle
      singleResultTable["RuleAuthor"] = ruleAuthor
      singleResultTable["Cmdline"] = cmdLine
      singleResultTable["Process"] = process
      singleResultTable["PID"] = pidStr
      singleResultTable["User"] = user
      singleResultTable["LID"] = lid
      self.seqOfResultsTables.add(singleResultTable)

  # Found a Sysmon 1 process creation event
  if x.Channel == "Sysmon" and x.EventId == 1 and isMinLevel(x.Level, self.level):
    inc self.suspicousProcessCount_Sysmon_1
    cmdLine = jsonLine.Details["Cmdline"].getStr()
    eventType = "Sysmon 1"
    timestamp = jsonLine.Timestamp
    ruleTitle = jsonLine.RuleTitle
    computer = jsonLine.Computer
    process = jsonLine.Details["Proc"].getStr()
    pidStr = $jsonLine.Details["PID"].getInt()
    user = jsonLine.Details["User"].getStr()
    lid = jsonLine.Details["LID"].getStr()
    lguid = jsonLine.Details["LGUID"].getStr()
    processGuid = jsonLine.Details["PGUID"].getStr()
    parentCmdline = jsonLine.Details["ParentCmdline"].getStr()
    parentPid = $jsonLine.Details["ParentPID"].getInt()
    parentGuid = jsonLine.Details["ParentPGUID"].getStr()
    description = jsonLine.Details["Description"].getStr()
    product = jsonLine.Details["Product"].getStr()
    try:
      company = jsonLine.Details["Company"].getStr()
    except KeyError:
      company = ""
    try:
      ruleAuthor = jsonLine.RuleAuthor
    except KeyError:
      ruleAuthor = ""
    try:
      hashes = jsonLine.Details["Hashes"].getStr() # Hashes are not enabled by default so this field may not exist.
      let pairs = hashes.split(",") # Split the string into key-value pairs. Ex: MD5=DE9C75F34F47B60A71BBA03760F0579E,SHA256=12F06D3B1601004DB3F7F1A07E7D3AF4CC838E890E0FF50C51E4A0C9366719ED,IMPHASH=336674CB3C8337BDE2C22255345BFF43
      for pair in pairs:
        let keyVal = pair.split("=")
        case keyVal[0]:
        of "MD5":
          hash_MD5 = keyVal[1]
        of "SHA1":
          hash_SHA1 = keyVal[1]
        of "SHA256":
          hash_SHA256 = keyVal[1]
        of "IMPHASH":
          hash_IMPHASH = keyVal[1]
    except KeyError:
      hashes = ""
      hash_MD5 = ""
      hash_SHA1 = ""
      hash_SHA256 = ""
      hash_IMPHASH = ""

    if self.output == "": # Output to screen
      echo "Timestamp: " & timestamp
      echo "Computer: " & computer
      echo "Type: " & eventType
      echo "Level: " & eventLevel
      echo "Rule: " & ruleTitle
      echo "RuleAuthor: " & ruleAuthor
      echo "Cmdline: " & cmdLine
      echo "Process: " & process
      echo "PID: " & pidStr
      echo "User: " & user
      echo "LID: " & lid
      echo "LGUID: " & lguid
      echo "ProcessGUID: " & processGuid
      echo "ParentCmdline: " & parentCmdline
      echo "ParentPID: " & parentPid
      echo "ParentGUID: " & parentGuid
      echo "Description: " & description
      echo "Product: " & product
      echo "Company: " & company
      echo "MD5 Hash: " & hash_MD5
      echo "SHA1 Hash: " & hash_SHA1
      echo "SHA256 Hash: " & hash_SHA256
      echo "Import Hash: " & hash_IMPHASH
      echo ""
    else: # Add records to seqOfResultsTables to eventually save to file.
      var singleResultTable = initTable[string, string]()
      singleResultTable["Timestamp"] = timestamp
      singleResultTable["Computer"] = computer
      singleResultTable["Type"] = eventType
      singleResultTable["Level"] = eventLevel
      singleResultTable["Rule"] = ruleTitle
      singleResultTable["RuleAuthor"] = ruleAuthor
      singleResultTable["Cmdline"] = cmdLine
      singleResultTable["Process"] = process
      singleResultTable["PID"] = pidStr
      singleResultTable["User"] = user
      singleResultTable["LID"] = lid
      singleResultTable["LGUID"] = lguid
      singleResultTable["ProcessGUID"] = processGuid
      singleResultTable["ParentCmdline"] = parentCmdline
      singleResultTable["ParentPID"] = parentPid
      singleResultTable["ParentPGUID"] = parentGuid
      singleResultTable["Description"] = description
      singleResultTable["Product"] = product
      singleResultTable["Company"] = company
      singleResultTable["MD5 Hash"] = hash_MD5
      singleResultTable["SHA1 Hash"] = hash_SHA1
      singleResultTable["SHA256 Hash"] = hash_SHA256
      singleResultTable["Import Hash"] = hash_IMPHASH
      self.seqOfResultsTables.add(singleResultTable)

method resultOutput*(self: TimelineSuspiciousProcessesCmd) =
  var savedFiles = "n/a"
  var results = "n/a"
  if self.output != "" and (self.suspicousProcessCount_Sec_4688 > 0 or
      self.suspicousProcessCount_Sysmon_1 > 0): # Save results to CSV
        # Open file to save results
    let header = ["Timestamp", "Computer", "Type", "Level", "Rule",
        "RuleAuthor", "Cmdline", "Process", "PID", "User", "LID", "LGUID",
        "ProcessGUID", "ParentCmdline", "ParentPID", "ParentPGUID",
        "Description", "Product", "Company", "MD5 Hash", "SHA1 Hash",
        "SHA256 Hash", "Import Hash"]
    var outputFile = open(self.output, fmWrite)

    ## Write CSV header
    outputFile.write(header.join(",") & "\p")

    ## Write contents
    for table in self.seqOfResultsTables:
      for key in header:
        if table.hasKey(key):
          outputFile.write(escapeCsvField(table[key]) & ",")
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
  if self.displayTable:
    if self.suspicousProcessCount_Sec_4688 == 0 and
        self.suspicousProcessCount_Sysmon_1 == 0:
      echo ""
      echo "No suspicous processes were found. There are either no malicious processes or you need to change the level."
    else:
      echo ""
      echo "Suspicious processes in Security 4688 process creation events: " &
          intToStr(self.suspicousProcessCount_Sec_4688).insertSep(',')
      echo "Suspicious processes in Sysmon 1 process creation events: " &
          intToStr(self.suspicousProcessCount_Sysmon_1).insertSep(',')
  self.cmdResult = CmdResult(results: results, savedFiles: savedFiles)

proc timelineSuspiciousProcesses(level: string = "high",
    skipProgressBar: bool = false, output: string = "", quiet: bool = false,
    timeline: string) =
  checkArgs(quiet, timeline, "informational")
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = TimelineSuspiciousProcessesCmd(
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                level: level,
                name: "timeline-suspicious-processes",
                msg: TimelineSuspiciousProcessesMsg)
    cmd.analyzeJSONLFile()

const metricsUsersMsg = "This command creates user metrics from logon events."

type
  metricsUsersCmd* = ref object of AbstractCmd
    header* = @["Target Computer", "User", "SID", "Logon Count", "Source"]
    count*: CountTable[string] = initCountTable[string]()
    userSidMap*: Table[string, string] = initTable[string, string]()
    userSourceMap*: Table[string, HashSet[string]] = initTable[string, HashSet[string]]()

proc getDetailValue(details: JsonNode, key: string): string =
  if details.hasKey(key):
    return details[key].getStr("N/A")
  else:
    return "N/A"

method filter*(self: metricsUsersCmd, x: HayabusaJson): bool =
    let sid = getDetailValue(x.ExtraFieldInfo, "TargetUserSid")
    if sid == "S-1-5-18":
        return false
    return x.EventId == 4624 or x.EventId == 4625 or x.EventId == 4634 or
            x.EventId == 4647 or x.EventId == 4648 or x.EventId == 4672 or
            x.EventId == 21 or x.EventId == 23 or x.EventId == 302 or x.EventId == 303

method analyze*(self: metricsUsersCmd, x: HayabusaJson) =
  let rule = x.RuleTitle
  let computer = x.Computer
  let eventID = x.EventID
  let sid = getDetailValue(x.ExtraFieldInfo, "TargetUserSid")
  var user = getDetailValue(x.Details, "TgtUser")
  if user == "N/A":
    user = getDetailValue(x.Details, "User")
  var source = "N/A"
  if eventID == 4624 or eventID == 4625:
    source = getDetailValue(x.Details, "SrcComp") & " ¦ " & getDetailValue(x.Details, "SrcIP")
  elif eventID == 4648:
    source = getDetailValue(x.Details, "SrcIP")
  elif eventID == 21 or eventID == 23 or eventID == 302 or eventID == 303:
    source = getDetailValue(x.Details, "SrcIP")
  let key = computer & "|" & user
  self.count.inc(key)
  if not self.userSidMap.hasKey(key) or (self.userSidMap[key] == "N/A" and sid != "N/A"):
    self.userSidMap[key] = sid
  if not self.userSourceMap.hasKey(key):
    self.userSourceMap[key] = initHashSet[string]()
  if source != "N/A" and source != "-":
    let sources = source.split(" ¦ ")
    for src in sources:
      if src != "" and src != "-":
        self.userSourceMap[key].incl(src)


method resultOutput*(self: metricsUsersCmd) =
    var savedFiles = "n/a"
    let results = "Unique users: " & intToStr(self.count.len).insertSep(',')
    let sortedCounts = toSeq(pairs(self.count)).sorted(proc(a, b: (string, int)): int =
      if cmp(b[1], a[1]) == 0:
        cmp(a[0], b[0])
      else:
        cmp(b[1], a[1])
    )
    if self.output != "":
        if self.count.len == 0:
            if self.displayTable:
                echo ""
                echo "No " & self.name & " results where found."
        else:
            let outputFile = open(self.output, fmWrite)
            writeLine(outputFile, self.header.join(","))
            for (key, count) in sortedCounts:
                let computer = key.split("|")[0]
                let user = key.split("|")[1]
                var sid = "N/A"
                if self.userSidMap.hasKey(key):
                    sid = self.userSidMap[key]
                var source = "N/A"
                if self.userSourceMap.hasKey(key):
                    source = self.userSourceMap[key].toSeq().sorted().join(" ¦ ")
                let columns = @[computer, user, sid, intToStr(count).insertSep(','), source]
                for i, key in columns:
                    if i < columns.len - 1:
                        outputFile.write(escapeCsvField(columns[i]) & ",")
                    else:
                        outputFile.write(escapeCsvField(columns[i]))
                outputFile.write("\p")
            let outputFileSize = getFileSize(outputFile)
            savedFiles = self.output & " (" & formatFileSize(outputFileSize) & ")"
            close(outputFile)
            if self.displayTable:
                echo ""
                echo "Saved file: " & savedFiles
    else:
        var table: TerminalTable
        table.add self.header
        for (key, count) in sortedCounts:
            let computer = key.split("|")[0]
            let user = key.split("|")[1]
            var sid = "N/A"
            if self.userSidMap.hasKey(key):
                sid = self.userSidMap[key]
            var source = "N/A"
            if self.userSourceMap.hasKey(key):
                source = self.userSourceMap[key].toSeq().join(" ¦ ")
            table.add computer, user, sid, intToStr(count).insertSep(','), source
        if self.displayTable:
          echo ""
          table.echoTableSepsWithStyled(seps = boxSeps)
          echo ""
    self.cmdResult = CmdResult(results: results, savedFiles:savedFiles)


proc metricsUsers(skipProgressBar: bool = false, output: string = "", quiet: bool = false, timeline: string) =
  checkArgs(quiet, timeline)
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = metricsUsersCmd(
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                name: "metrics-users",
                msg: metricsUsersMsg)
    cmd.analyzeJSONLFile()

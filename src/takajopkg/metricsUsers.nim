const metricsUsersMsg = "This command creates user metrics from logon events."

type
  metricsUsersCmd* = ref object of AbstractCmd
    header* = @["Target Computer", "User", "SID", "Successful Logon Count", "Successful Sources", "Successful Hostnames", "Failed Logon Count", "Failed Sources", "Failed Hostnames"]
    count*: CountTable[string] = initCountTable[string]()
    failedCount*: CountTable[string] = initCountTable[string]()
    userSidMap*: Table[string, string] = initTable[string, string]()
    userSuccessSrcIPMap*: Table[string, HashSet[string]] = initTable[string, HashSet[string]]()
    userFailedSrcIPMap*: Table[string, HashSet[string]] = initTable[string, HashSet[string]]()
    userSuccessHostMap*: Table[string, HashSet[string]] = initTable[string, HashSet[string]]()
    userFailedHostMap*: Table[string, HashSet[string]] = initTable[string, HashSet[string]]()

proc getDetailValue(details: JsonNode, key: string): string =
  if details.hasKey(key):
    return details[key].getStr("N/A")
  else:
    return "N/A"

method filter*(self: metricsUsersCmd, x: HayabusaJson): bool =
    let sid = getDetailValue(x.ExtraFieldInfo, "TargetUserSid")
    if sid == "S-1-5-17" or sid == "S-1-5-18" or sid == "S-1-5-19" or sid == "S-1-5-20":
        return false
    return x.EventId == 4624 or x.EventId == 4625 or x.EventId == 4634 or
            x.EventId == 4647 or x.EventId == 4648 or x.EventId == 4672 or
            x.EventId == 21 or x.EventId == 23 or x.EventId == 302 or x.EventId == 303

method analyze*(self: metricsUsersCmd, x: HayabusaJson) =
  let computer = x.Computer
  let eventID = x.EventID
  let sid = getDetailValue(x.ExtraFieldInfo, "TargetUserSid")
  var user = getDetailValue(x.Details, "TgtUser")
  if user == "N/A":
    user = getDetailValue(x.Details, "User")
  var sourceIP = "N/A"
  var sourceComp = "N/A"
  var sourceFailIP = "N/A"
  var sourceFailComp = "N/A"
  let key = computer & "|" & user
  if eventID == 4625:
    sourceFailIP = getDetailValue(x.Details, "SrcIP")
    sourceFailComp = getDetailValue(x.Details, "SrcComp")
    self.failedCount.inc(key)
  else:
    sourceIP = getDetailValue(x.Details, "SrcIP")
    if eventID == 4624:
      sourceComp = getDetailValue(x.Details, "SrcComp")
    if eventID == 21 or eventID == 303 or eventID == 4624 or eventID == 4648:
        self.count.inc(key)
  if not self.userSidMap.hasKey(key) or (self.userSidMap[key] == "N/A" and sid != "N/A"):
    self.userSidMap[key] = sid
  if not self.userSuccessSrcIPMap.hasKey(key):
    self.userSuccessSrcIPMap[key] = initHashSet[string]()
  if not self.userFailedSrcIPMap.hasKey(key):
    self.userFailedSrcIPMap[key] = initHashSet[string]()
  if not self.userSuccessHostMap.hasKey(key):
    self.userSuccessHostMap[key] = initHashSet[string]()
  if not self.userFailedHostMap.hasKey(key):
    self.userFailedHostMap[key] = initHashSet[string]()
  
  if sourceIP != "N/A" and sourceIP != "-":
    let sources = sourceIP.split(" ¦ ")
    for src in sources:
      if src != "" and src != "-":
        self.userSuccessSrcIPMap[key].incl(src)

  if sourceFailIP != "N/A" and sourceFailIP != "-":
    let sources = sourceFailIP.split(" ¦ ")
    for src in sources:
      if src != "" and src != "-":
        self.userFailedSrcIPMap[key].incl(src)
  
  if sourceComp != "N/A" and sourceComp != "-":
    let sources = sourceComp.split(" ¦ ")
    for src in sources:
      if src != "" and src != "-":
        self.userSuccessHostMap[key].incl(src)
 
  if sourceFailComp != "N/A" and sourceFailComp != "-":
    let sources = sourceFailComp.split(" ¦ ")
    for src in sources:
      if src != "" and src != "-":
        self.userFailedHostMap[key].incl(src)

proc buildColumns(key: string, count: int, self: metricsUsersCmd): seq[string] =
    let computer = key.split("|")[0]
    let user = key.split("|")[1]
    var sid = "N/A"
    if self.userSidMap.hasKey(key):
        sid = self.userSidMap[key]
    var source = "N/A"
    var sourceFail = "N/A"
    var sourceComp = "N/A"
    var sourceFailComp = "N/A"
    if self.userSuccessSrcIPMap.hasKey(key):
        source = self.userSuccessSrcIPMap[key].toSeq().join(" ¦ ")
    if self.userFailedSrcIPMap.hasKey(key):
        sourceFail = self.userFailedSrcIPMap[key].toSeq().join(" ¦ ")
    if self.userSuccessHostMap.hasKey(key):
        sourceComp = self.userSuccessHostMap[key].toSeq().join(" ¦ ")
    if self.userFailedHostMap.hasKey(key):
        sourceFailComp = self.userFailedHostMap[key].toSeq().join(" ¦ ")
    return @[computer, user, sid, intToStr(self.count.getOrDefault(key, 0)).insertSep(','), source, sourceComp, intToStr(self.failedCount.getOrDefault(key, 0)).insertSep(','), sourceFail, sourceFailComp]

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
                let columns = buildColumns(key, count, self)
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
            let col = buildColumns(key, count, self)
            table.add col[0], col[1], col[2], col[3], col[4], col[5], col[6], col[7], col[8]
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

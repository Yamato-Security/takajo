const metricsComputersMsg = "This command creates computer metrics from System 12,6005,6009 and 6013 event logs."

type
  metricsComputersCmd* = ref object of AbstractCmd
    windowsVersions*: Table[string, string] = initTable[string, string]()
    header* = @["Computer", "OS information", "UpTime", "Timezone", "Events"]
    count*: CountTable[string] = initCountTable[string]()
    records* = Table[string, array[4, string]]()

method filter*(self: metricsComputersCmd, x: HayabusaJson): bool =
  return true

proc formatUptime(uptime: int): string =
  if uptime == 0:
    return ""
  let seconds = uptime mod 60
  let minutes = (uptime div 60) mod 60
  let hours = (uptime div 3600) mod 24
  let days = (uptime div 86400) mod 30
  let months = (uptime div 2592000) mod 12
  let years = uptime div 31104000
  return &"{years}Y {months}M {days}d {hours}h {minutes}m {seconds}s"

proc calculateTimeDifference(uptime: string, lastTime: string): int =
  if uptime == "" or lastTime == "":
    return 0
  var format = "yyyy-MM-dd HH:mm:ss.SSS Z"
  if uptime.endsWith("Z"): # --ISO-8601
    format = "yyyy-MM-dd'T'HH:mm:ss'.'ffffff"
  elif uptime.contains("AM") or uptime.contains("PM"): # --US-time
    format = "MM-dd-yyyy HH:mm:ss'.'fff tt"
  elif uptime.contains(","): # --RFC-2822
    format = "ddd,d MMM yyyy HH:mm:ss"
  elif uptime.count(' ') == 1: # --RFC-3339
    format = "yyyy-MM-dd HH:mm:ss'.'ffffff"
  elif uptime[4] == '-': # -UTC
    format = "yyyy-MM-dd HH:mm:ss'.'fff"
  else:
    try:
        let timeFormat = "MM-dd-yyyy HH:mm:ss'.'fff"
        let _ = parse(padString(uptime, '0', timeFormat), timeFormat)
    except CatchableError:
        format = "dd-MM-yyyy HH:mm:ss'.'fff" # --European-time
    format = "MM-dd-yyyy HH:mm:ss'.'fff" # --US-military-time
  let uptimeTime = parse(uptime[0 ..< format.len - 2], format)
  let lastTimeTime = parse(lastTime[0 ..< format.len - 2], format)
  return int((lastTimeTime - uptimeTime).inSeconds)

method analyze*(self: metricsComputersCmd, x: HayabusaJson) =
    let ruleTitle = x.RuleTitle
    let jsonLine = x
    let computer = jsonLine.Computer
    let channel = jsonLine.Channel
    let eventID = jsonLine.EventID
    self.count.inc(computer)
    if not self.records.hasKey(computer):
        self.records[computer] = ["", "", "", ""]
    if eventID == 6009 and ruleTitle == "Computer Startup":
        let ver = jsonLine.Details["MajorVer"].getStr("N/A").replace(".01", ".1").replace(".00", ".0").replace(re"\.$", "")
        let num = jsonLine.Details["BuildNum"].getInt(0)
        let ver_num = ver & "," & $num
        if ver_num in self.windowsVersions:
            let osInfo = self.windowsVersions[ver_num]
            self.records[computer][0] = "Windows " & osInfo
    elif eventID == 6013 and ruleTitle == "Computer Uptime/Timezone":
        let timezone = jsonLine.Details["Timezone"].getStr("N/A").replace(re"^\S+\s+", "")
        self.records[computer][2] = timezone
    if channel == "Sys":
        let timestamp = jsonLine.Timestamp
        if (ruleTitle == "Computer Startup" and eventID == 12) or (ruleTitle == "Event Log Svc Started" and eventID == 6005) or (ruleTitle == "Computer Startup" and eventID == 6009):
            let uptime  = self.records[computer][1]
            if uptime == "" or timestamp > uptime:
                self.records[computer][1] = timestamp
        let last = self.records[computer][3]
        if last == "" or timestamp > last:
            self.records[computer][3] = timestamp

method resultOutput*(self: metricsComputersCmd) =
    var savedFiles = "n/a"
    let results = "Unique computers: " & intToStr(self.count.len).insertSep(',')
    let sortedCounts = toSeq(pairs(self.count)).sorted(proc(a, b: (string, int)): int = cmp(b[1], a[1]))
    if self.output != "":
        if self.count.len == 0:
            if self.displayTable:
                echo ""
                echo "No " & self.name & " results where found."
        else:
            let outputFile = open(self.output, fmWrite)
            writeLine(outputFile, self.header.join(","))
            for (computer, count) in sortedCounts:
                if computer notin self.records:
                    self.records[computer] = ["", "", "", ""]
                let osInfo = self.records[computer][0]
                let uptime = self.records[computer][1]
                let timezone = self.records[computer][2]
                let lastTime = self.records[computer][3]
                let diff = calculateTimeDifference(uptime, lastTime)
                let columns = @[computer, osInfo, formatUptime(diff), timezone, intToStr(count).insertSep(',')]
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
        for (computer, count) in sortedCounts:
            if computer notin self.records:
                self.records[computer] = ["", "", "", ""]
            let osInfo = self.records[computer][0]
            let uptime = self.records[computer][1]
            let timezone = self.records[computer][2]
            let lastTime = self.records[computer][3]
            let diff = calculateTimeDifference(uptime, lastTime)
            table.add computer, osInfo, formatUptime(diff), timezone, intToStr(count).insertSep(',')
        if self.displayTable:
          echo ""
          table.echoTableSepsWithStyled(seps = boxSeps)
          echo ""
    self.cmdResult = CmdResult(results: results, savedFiles:savedFiles)

proc readWindowsVersions(filePath: string): Table[string, string] =
  var versions = initTable[string, string]()
  for line in lines(filePath):
    let parts = line.split(',')
    if parts.len >= 3:
      let key = parts[0] & "," & parts[1]
      let value = parts[2]
      versions[key] = value
  return versions

proc metricsComputers(skipProgressBar: bool = false, output: string = "", quiet: bool = false, timeline: string) =
  checkArgs(quiet, timeline)
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = metricsComputersCmd(
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                name: "computer-metrics",
                msg: metricsComputersMsg)
    cmd.windowsVersions = readWindowsVersions("conf/windows_versions.csv")
    cmd.analyzeJSONLFile()

const ExtractScriptBlocksMsg = "This command will extract PowerShell Script Block."

type Script = ref object
    firstTimestamp: string
    computerName: string
    scriptBlockId: string
    scriptBlocks: OrderedSet[string]
    levels: HashSet[string]
    ruleTitles: HashSet[string]

proc outputScriptText(output: string, timestamp: string, computerName: string,
        scriptObj: Script) =
    var scriptText = ""
    for text in scriptObj.scriptBlocks.items:
        scriptText = scriptText & text.replace("\\r\\n", "\p").replace("\\n", "\p").replace("\\t", "\t").replace("\\\"", "\"")
    let date = timestamp.replace(":", "_").replace(" ", "_")
    let fileName = output & "/" & computerName & "-" & date & "-" & scriptObj.scriptBlockId & ".txt"
    var outputFile = open(filename, fmWrite)
    outputFile.write(scriptText)
    flushFile(outputFile)
    close(outputFile)

proc calcMaxAlert(levels:HashSet):string =
    if "crit" in levels:
        return "crit"
    if "high" in levels:
        return "high"
    if "med" in levels:
        return "med"
    if "low" in levels:
        return "low"
    if "info" in levels:
        return "info"
    return "N/A"

proc buildSummaryRecord(path: string, messageTotal: int,
        scriptObj: Script): array[7, string] =
    let ts = scriptObj.firstTimestamp
    let cs = scriptObj.computerName
    let id = scriptObj.scriptBlockId
    let count = scriptObj.scriptBlocks.len
    let records = $count & "/" & $messageTotal
    let ruleTitles = fmt"{scriptObj.ruleTitles}".replace("{", "").replace("}", "")
    let maxLevel = calcMaxAlert(scriptObj.levels)
    return [ts, cs, id, path, records, maxLevel, ruleTitles]

type
  ExtractScriptBlocksCmd* = ref object of AbstractCmd
      currentIndex*  = 0
      totalLines* = 0
      stackedRecords* = newTable[string, Script]()
      summaryRecords* = newOrderedTable[string, array[7, string]]()
      level*: string

method filter*(self: ExtractScriptBlocksCmd, x: HayabusaJson):bool =
    inc self.currentIndex
    return x.EventID == 4104 and isMinLevel(x.Level, self.level)

method analyze*(self: ExtractScriptBlocksCmd, x: HayabusaJson) =
    let jsonLine = x
    try:
        var
            timestamp = jsonLine.Timestamp
            computerName = jsonLine.Computer
            eventLevel = jsonLine.Level
            ruleTitle = jsonLine.RuleTitle
            scriptBlock = jsonLine.Details["ScriptBlock"].getStr()
            scriptBlockId = jsonLine.ExtraFieldInfo["ScriptBlockId"].getStr()
            messageNumber = jsonLine.ExtraFieldInfo["MessageNumber"].getInt()
            messageTotal = jsonLine.ExtraFieldInfo["MessageTotal"].getInt()
            path = jsonLine.ExtraFieldInfo.getOrDefault("Path").getStr()
        if path == "":
            path = "no-path"
        if scriptBlockId in self.stackedRecords:
            self.stackedRecords[scriptBlockId].levels.incl(eventLevel)
            self.stackedRecords[scriptBlockId].ruleTitles.incl(ruleTitle)
            self.stackedRecords[scriptBlockId].scriptBlocks.incl(scriptBlock)
        else:
            self.stackedRecords[scriptBlockId] = Script(firstTimestamp: timestamp,
                    computerName: computerName,
                    scriptBlockId: scriptBlockId,
                    scriptBlocks: toOrderedSet([scriptBlock]),
                    levels:toHashSet([eventLevel]), ruleTitles:toHashSet([ruleTitle]))
        let scriptObj = self.stackedRecords[scriptBlockId]
        if messageNumber == messageTotal:
            if scriptBlockId in self.summaryRecords:
                self.summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
                # Already outputted
                discard
            outputScriptText(self.output, timestamp, computerName, scriptObj)
            self.summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
        elif self.currentIndex + 1 == self.totalLines:
            outputScriptText(self.output, timestamp, computerName, scriptObj)
            self.summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
    except CatchableError:
        discard

method resultOutput*(self: ExtractScriptBlocksCmd) =
    var savedFiles = "n/a"
    var results = "n/a"
    if self.summaryRecords.len == 0:
        echo ""
        echo "No malicious powershell script block were found. There are either no malicious powershell script block or you need to change the level."
    else:
        let summaryFile = self.output & "/" & "Summary.csv"
        let header = ["Creation Time", "Computer Name", "Script ID", "Script Name", "Records", "Level", "Alerts"]
        var outputFile = open(summaryFile, fmWrite)
        var table: TerminalTable
        table.add header
        for i, val in header:
            if i < 6:
                outputFile.write(escapeCsvField(val) & ",")
            else:
                outputFile.write(escapeCsvField(val) & "\p")
        for v in self.summaryRecords.values:
            let color = levelColor(v[5])
            table.add color v[0], color v[1], color v[2], color v[3], color v[4], color v[5], color v[6]
            for i, cell in v:
                if i < 6:
                    outputFile.write(escapeCsvField(cell) & ",")
                else:
                    outputFile.write(escapeCsvField(cell) & "\p")
        let outputFileSize = getFileSize(outputFile)
        outputFile.close()
        savedFiles = padString(summaryFile & " (" & formatFileSize(outputFileSize) & ")", ' ', 80)
        results = "PowerShell logs: " & intToStr(self.summaryRecords.len).insertSep(',')
        if self.displayTable:
            table.echoTableSepsWithStyled(seps = boxSeps)
            echo ""
            echo "The extracted PowerShell ScriptBlock is saved in the directory: " & self.output
            echo "Saved summary file: " & savedFiles
    self.cmdResult = CmdResult(results:results, savedFiles:  savedFiles & self.output & "/*.txt")


proc extractScriptblocks(level: string = "low", skipProgressBar:bool = false, output: string = "scriptblock-logs", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    if not dirExists(output):
        echo "The directory '" & output & "' does not exist so will be created."
        createDir(output)
        echo ""
    let cmd = ExtractScriptBlocksCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name:"extract-scriptblocks",
                msg: ExtractScriptBlocksMsg)
    cmd.totalLines = countLinesInTimeline(timeline, true)
    cmd.analyzeJSONLFile()
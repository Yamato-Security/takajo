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


proc extractScriptblocks(level: string = "low", output: string = "scriptblock-logs",
        quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)

    echo "Started the Extract ScriptBlock command."
    echo "This command will extract PowerShell Script Block."
    echo ""

    echo "Counting total lines. Please wait."
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""
    if level == "critical":
        echo "Extracting PowerShell ScriptBlocks with an alert level of critical. Please wait."
    else:
        echo "Extracting PowerShell ScriptBlocks with a minimal alert level of " & level & ". Please wait."
    echo ""

    if not dirExists(output):
        echo "The directory '" & output & "' does not exist so will be created."
        createDir(output)
        echo ""

    var
        bar: SuruBar = initSuruBar()
        currentIndex  = 0
        stackedRecords = newTable[string, Script]()
        summaryRecords = newOrderedTable[string, array[7, string]]()
        timestamp: string
        computerName: string
        eventLevel: string
        ruleTitle: string
        scriptBlock: string
        scriptBlockId: string
        messageNumber: int
        messageTotal: int
        path: string

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc currentIndex
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()

        if jsonLine.EventID != 4104 or isMinLevel(jsonLine.Level, level) == false:
            continue
        try:
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
        except CatchableError:
            continue

        if scriptBlockId in stackedRecords:
            stackedRecords[scriptBlockId].levels.incl(eventLevel)
            stackedRecords[scriptBlockId].ruleTitles.incl(ruleTitle)
            stackedRecords[scriptBlockId].scriptBlocks.incl(scriptBlock)
        else:
            stackedRecords[scriptBlockId] = Script(firstTimestamp: timestamp,
                    computerName: computerName,
                    scriptBlockId: scriptBlockId,
                    scriptBlocks: toOrderedSet([scriptBlock]),
                    levels:toHashSet([eventLevel]), ruleTitles:toHashSet([ruleTitle]))

        let scriptObj = stackedRecords[scriptBlockId]
        if messageNumber == messageTotal:
            if scriptBlockId in summaryRecords:
                summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
                # Already outputted
                continue
            outputScriptText(output, timestamp, computerName, scriptObj)
            summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
        elif currentIndex + 1 == totalLines:
            outputScriptText(output, timestamp, computerName, scriptObj)
            summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)

    bar.finish()
    echo ""

    if summaryRecords.len == 0:
        echo "No malicious powershell script block were found. There are either no malicious powershell script block or you need to change the level."
    else:
        let summaryFile = output & "/" & "summary.csv"
        let header = ["Creation Time", "Computer Name", "Script ID", "Script Name", "Records", "Level", "Alerts"]
        var outputFile = open(summaryFile, fmWrite)
        var table: TerminalTable
        table.add header
        for i, val in header:
            if i < 6:
                outputFile.write(escapeCsvField(val) & ",")
            else:
                outputFile.write(escapeCsvField(val) & "\p")
        for v in summaryRecords.values:
            let color = levelColor(v[5])
            table.add color v[0], color v[1], color v[2], color v[3], color v[4], color v[5], color v[6]
            for i, cell in v:
                if i < 6:
                    outputFile.write(escapeCsvField(cell) & ",")
                else:
                    outputFile.write(escapeCsvField(cell) & "\p")
        let outputFileSize = getFileSize(outputFile)
        outputFile.close()
        table.echoTableSepsWithStyled(seps = boxSeps)
        echo ""
        echo "The extracted PowerShell ScriptBlock is saved in the directory: " & output
        echo "Saved summary file: " & summaryFile & " (" & formatFileSize(outputFileSize) & ")"
    outputElapsedTime(startTime)
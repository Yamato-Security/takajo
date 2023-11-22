type
    Script = object
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

proc colorWrite(color: ForegroundColor, ansiEscape: string, txt: string) =
    # Remove ANSI escape sequences and use stdout.styledWrite instead
    let replacedTxt = txt.replace(ansiEscape,"").replace(termClear,"")
    if "│" in replacedTxt:
      stdout.styledWrite(color, replacedTxt.replace("│ ",""))
      stdout.write "│ "
    else:
      stdout.styledWrite(color, replacedTxt)

proc stdoutStyledWrite(txt: string) =
    if txt.startsWith(termRed):
      colorWrite(fgRed, termRed,txt)
    elif txt.startsWith(termGreen):
      colorWrite(fgGreen, termGreen, txt)
    elif txt.startsWith(termYellow):
      colorWrite(fgYellow, termYellow, txt)
    elif txt.startsWith(termCyan):
      colorWrite(fgCyan, termCyan, txt)
    else:
      stdout.write txt.replace(termClear,"")

proc echoTableSepsWithStyled(table: TerminalTable, maxSize = terminalWidth(), seps = defaultSeps) =
    # This function equivalent to echoTableSeps without using ANSI escape to avoid the following issue.
    # https://github.com/PMunch/nancy/issues/4
    # https://github.com/PMunch/nancy/blob/9918716a563f64d740df6a02db42662781e94fc8/src/nancy.nim#L195C6-L195C19
    let sizes = table.getColumnSizes(maxSize - 4, padding = 3)
    printSeparator(top)
    for k, entry in table.entries(sizes):
      for _, row in entry():
        stdout.write seps.vertical & " "
        for i, cell in row():
          stdoutStyledWrite cell & (if i != sizes.high: " " & seps.vertical & " " else: "")
        stdout.write " " & seps.vertical & "\n"
      if k != table.rows - 1:
        printSeparator(center)
    printSeparator(bottom)

proc extractScriptblocks(level: string = "low", output: string = "scriptblock-logs",
        quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    if level != "critical" and level != "high" and level != "medium" and level != "low" and level != "informational":
        echo "You must specify a minimum level of critical, high, medium, low or informational. (default: low)"
        echo ""
        return

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

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc currentIndex
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        var
            timestamp: string
            computerName: string
            eventLevel: string
            ruleTitle: string
            scriptBlock: string
            scriptBlockId: string
            messageNumber: int
            messageTotal: int
            path: string

        if jsonLine["EventID"].getInt(0) != 4104 or isMinLevel(jsonLine["Level"].getStr(), level) == false:
            continue
        try:
            timestamp = jsonLine["Timestamp"].getStr()
            computerName = jsonLine["Computer"].getStr()
            eventLevel = jsonLine["Level"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
            scriptBlock = jsonLine["Details"]["ScriptBlock"].getStr()
            scriptBlockId = jsonLine["ExtraFieldInfo"]["ScriptBlockId"].getStr()
            messageNumber = jsonLine["ExtraFieldInfo"]["MessageNumber"].getInt()
            messageTotal = jsonLine["ExtraFieldInfo"]["MessageTotal"].getInt()
            path = jsonLine["ExtraFieldInfo"].getOrDefault("Path").getStr()
            if path == "":
                path = "no-path"
        except:
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
            if v[5] == "crit":
                table.add red v[0], red v[1], red v[2], red v[3], red v[4], red v[5], red v[6]
            elif v[5] == "high":
                table.add yellow v[0], yellow v[1], yellow v[2], yellow v[3], yellow v[4], yellow v[5], yellow v[6]
            elif v[5] == "med":
                table.add cyan v[0], cyan v[1], cyan v[2], cyan v[3], cyan v[4], cyan v[5], cyan v[6]
            elif v[5] == "low":
                table.add green v[0], green v[1], green v[2], green v[3], green v[4], green v[5], green v[6]
            else:
                table.add v
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

    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
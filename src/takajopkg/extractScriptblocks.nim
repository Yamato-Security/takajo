type
    Script = object
        scriptBlockId: string
        firstTimestamp: string
        scriptBlocks: OrderedSet[string]
        levels: HashSet[string]
        ruleTitles: HashSet[string]

proc outputScriptText(output: string, timestamp: string, computerName: string,
        scriptObj: Script) =
    var scriptText = ""
    for text in scriptObj.scriptBlocks.items:
        scriptText = scriptText & text.replace("\\r\\n", "\p").replace("\\\"", "\"").replace("\\t", "\t")
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
    let id = scriptObj.scriptBlockId
    let count = scriptObj.scriptBlocks.len
    var status = "Complete"
    if count != messageTotal:
        status = "Incomplete"
    let records = $count & "/" & $messageTotal
    let ruleTitles = fmt"{scriptObj.ruleTitles}".replace("{", "").replace("}", "")
    let maxLevel = calcMaxAlert(scriptObj.levels)
    return [ts, id, path, status, records, maxLevel, ruleTitles]

proc extractScriptblocks(output: string = "scriptblock-logs",
        quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the Extract ScriptBlock command."
    echo "This command will extract PowerShell Script Block."
    echo ""

    echo "Counting total lines. Please wait."
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""
    echo "Extracting PowerShell ScriptBlocks. Please wait."

    if not dirExists(output):
        echo ""
        echo "The directory '" & output & "' does not exist so will be created."
        createDir(output)
    echo ""

    var
        bar: SuruBar = initSuruBar()
        stackedRecords = newTable[string, Script]()
        summaryRecords = newOrderedTable[string, array[7, string]]()

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        if jsonLine["EventID"].getInt(0) != 4104:
            continue

        let
            timestamp = jsonLine["Timestamp"].getStr()
            computerName = jsonLine["Computer"].getStr()
            level = jsonLine["Level"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
            scriptBlock = jsonLine["Details"]["ScriptBlock"].getStr()
            scriptBlockId = jsonLine["ExtraFieldInfo"]["ScriptBlockId"].getStr()
            messageNumber = jsonLine["ExtraFieldInfo"]["MessageNumber"].getInt()
            messageTotal = jsonLine["ExtraFieldInfo"]["MessageTotal"].getInt()
        var path = jsonLine["ExtraFieldInfo"].getOrDefault("Path").getStr()
        if path == "":
            path = "no-path"

        if scriptBlockId in stackedRecords:
            stackedRecords[scriptBlockId].levels.incl(level)
            stackedRecords[scriptBlockId].ruleTitles.incl(ruleTitle)
            stackedRecords[scriptBlockId].scriptBlocks.incl(scriptBlock)
        else:
            stackedRecords[scriptBlockId] = Script(scriptBlockId: scriptBlockId,
                    firstTimestamp: timestamp, scriptBlocks: toOrderedSet([scriptBlock]),
                    levels:toHashSet([level]), ruleTitles:toHashSet([ruleTitle]))

        if messageNumber == messageTotal:
            let scriptObj = stackedRecords[scriptBlockId]
            if scriptBlockId in summaryRecords:
                summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
                # Already outputted
                continue
            outputScriptText(output, timestamp, computerName, scriptObj)
            summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
    bar.finish()

    let summaryFile = output & "/" & "summary.csv"
    let header = ["Creation Time", "Script ID", "Script Name", "Results", "Extracted Records", "Max alert", "Alerts"]
    var outputFile = open(summaryFile, fmWrite)
    var table: TerminalTable
    table.add header[0], header[1], header[2], header[3], header[4], header[5], header[6]
    for i, val in header:
        if i < 6:
            outputFile.write(escapeCsvField(val) & ",")
        else:
            outputFile.write(escapeCsvField(val) & "\p")
    for rec in summaryRecords.values:
        if rec[5] == "crit":
            table.add red rec[0], red rec[1], red rec[2], red rec[3], red rec[4], red rec[5], red rec[6]
        elif rec[5] == "high":
            table.add yellow rec[0], yellow rec[1], yellow rec[2], yellow rec[3], yellow rec[4], yellow rec[5], yellow rec[6]
        elif rec[5] == "med":
            table.add cyan rec[0], cyan rec[1], cyan rec[2], cyan rec[3], cyan rec[4], cyan rec[5], cyan rec[6]
        elif rec[5] == "low":
            table.add green rec[0], green rec[1], green rec[2], green rec[3], green rec[4], green rec[5], green rec[6]
        elif rec[5] == "info":
            table.add rec[0], rec[1], rec[2], rec[3], rec[4], rec[5], rec[6]
        else:
            table.add rec[0], rec[1], rec[2], rec[3], rec[4], rec[5], rec[6]
        for i, val in rec:
            if i < 6:
                outputFile.write(escapeCsvField(val) & ",")
            else:
                outputFile.write(escapeCsvField(val) & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()
    table.echoTableSeps(seps = boxSeps)
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
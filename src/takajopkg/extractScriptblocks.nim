type
    Script = object
        scriptBlockId: string
        firstTimestamp: string
        scriptBlocks: OrderedSet[string]

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

proc buildSummaryRecord(path: string, messageTotal: int,
        scriptObj: Script): array[5, string] =
    let ts = scriptObj.firstTimestamp
    let id = scriptObj.scriptBlockId
    let count = scriptObj.scriptBlocks.len
    var status = "Complete"
    if count != messageTotal:
        status = "Incomplete"
    let records = $count & "/" & $messageTotal
    return [ts, id, path, status, records]

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
        summaryRecords = newOrderedTable[string, array[5, string]]()

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
            scriptBlock = jsonLine["Details"]["ScriptBlock"].getStr()
            scriptBlockId = jsonLine["ExtraFieldInfo"]["ScriptBlockId"].getStr()
            messageNumber = jsonLine["ExtraFieldInfo"]["MessageNumber"].getInt()
            messageTotal = jsonLine["ExtraFieldInfo"]["MessageTotal"].getInt()
        var path = jsonLine["ExtraFieldInfo"].getOrDefault("Path").getStr()
        if path == "":
            path = "no-path"

        if scriptBlockId in stackedRecords:
            stackedRecords[scriptBlockId].scriptBlocks.incl(scriptBlock)
        else:
            stackedRecords[scriptBlockId] = Script(scriptBlockId: scriptBlockId,
                    firstTimestamp: timestamp, scriptBlocks: toOrderedSet([scriptBlock]))

        if messageNumber == messageTotal:
            if scriptBlockId in summaryRecords:
                # Already outputted
                continue
            let scriptObj = stackedRecords[scriptBlockId]
            outputScriptText(output, timestamp, computerName, scriptObj)
            summaryRecords[scriptBlockId] = buildSummaryRecord(path, messageTotal, scriptObj)
    bar.finish()

    let summaryFile = output & "/" & "summary.csv"
    let header = ["Creation Time", "Script ID", "Script Name", "Results", "Extracted Records"]
    var outputFile = open(summaryFile, fmWrite)
    echo ""
    stdout.styledWrite(fgGreen, header[0])
    stdout.styledWrite(fgWhite, " | ")
    stdout.styledWrite(fgYellow, header[1])
    stdout.styledWrite(fgWhite, " | ")
    stdout.styledWrite(fgBlue, header[2])
    stdout.styledWrite(fgWhite, " | ")
    stdout.styledWrite(fgMagenta, header[3])
    stdout.styledWrite(fgWhite, " | ")
    stdout.styledWrite(fgCyan, header[4] & "\p")
    for i, val in header:
        if i < 4:
            outputFile.write(escapeCsvField(val) & ",")
        else:
            outputFile.write(escapeCsvField(val) & "\p")
    for rec in summaryRecords.values:
        stdout.styledWrite(fgGreen, rec[0])
        stdout.styledWrite(fgWhite, " | ")
        stdout.styledWrite(fgYellow, rec[1])
        stdout.styledWrite(fgWhite, " | ")
        stdout.styledWrite(fgBlue, rec[2])
        stdout.styledWrite(fgWhite, " | ")
        stdout.styledWrite(fgMagenta, rec[3])
        stdout.styledWrite(fgWhite, " | ")
        stdout.styledWrite(fgCyan, rec[4] & "\p")
        for i, val in rec:
            if i < 4:
                outputFile.write(escapeCsvField(val) & ",")
            else:
                outputFile.write(escapeCsvField(val) & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()
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
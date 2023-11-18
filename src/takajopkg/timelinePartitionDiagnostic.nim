proc timelinePartitionDiagnostic(output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the Timeline partition diagnostic command"
    echo "This command will create a CSV timeline of partition diagnostic."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    var
        jsonLine: JsonNode
        bar: SuruBar = initSuruBar()
        seqOfResultsTables: seq[Table[string, string]]

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        jsonLine = parseJson(line)

        if jsonLine["EventID"].getInt() != 1006 or jsonLine["Channel"].getStr() != "MS-Win-Partition/Diagnostic":
            continue
        var singleResultTable = initTable[string, string]()
        singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
        singleResultTable["Computer"] = jsonLine["Computer"].getStr()
        singleResultTable["Manufacturer"] = jsonLine["Details"]["Manufacturer"].getStr()
        singleResultTable["Model"] = jsonLine["Details"]["Model"].getStr()
        singleResultTable["Revision"] = jsonLine["Details"]["Revision"].getStr()
        singleResultTable["SerialNumber"] = jsonLine["Details"]["SerialNumber"].getStr()
        seqOfResultsTables.add(singleResultTable)

    bar.finish()

    let header = ["Timestamp", "Computer", "Manufacturer", "Model", "Revision", "SerialNumber"]
    if output != "":
        # Open file to save results
        var outputFile = open(output, fmWrite)

        ## Write CSV header
        outputFile.write(header.join(",") & "\p")

        ## Write contents
        for table in seqOfResultsTables:
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
        let fileSize = getFileSize(output)
        echo ""
        echo "Saved results to " & output & " (" & formatFileSize(fileSize) & ")"
        echo ""
    else:
        echo ""
        var table: TerminalTable
        table.add header
        for t in seqOfResultsTables:
            table.add t[header[0]], t[header[1]], t[header[2]], t[header[3]], t[header[4]], t[header[5]]
        table.echoTableSeps(seps = boxSeps)
        echo ""

    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
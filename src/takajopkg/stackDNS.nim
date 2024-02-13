proc stackDNS(output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the Stack DNS command"
    echo ""
    echo "This command will stack DNS queries and responses."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""
    echo "Scanning the Hayabusa timeline. Please wait."
    echo ""

    var
        bar: SuruBar = initSuruBar()
        stackDNS = initCountTable[string]()

    bar[0].total = totalLines
    bar.setup()

    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        let eventId = jsonLine["EventID"].getInt(0)
        let channel = jsonLine["Channel"].getStr("N/A")
        if (eventId == 22 and channel == "Sysmon"):
            let prog = jsonLine["Details"]["Proc"].getStr("N/A")
            let query = jsonLine["Details"]["Query"].getStr("N/A")
            let res = jsonLine["Details"]["Result"].getStr("N/A")
            let result = prog & " -> " & query & " -> " & res
            stackDNS.inc(result)

    bar.finish()
    echo ""

    stackDNS.sort()

    # Print results to screen
    var outputFileSize = 0
    if output == "":
        for res, count in stackDNS:
            var commaDelimitedStr = $count & "," & res
            commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
            echo commaDelimitedStr
    # Save to CSV file
    else:
        let outputFile = open(output, fmWrite)
        writeLine(outputFile, "Count,DNS query and response")

        # Write results
        for res, count in stackDNS:
            writeLine(outputFile, $count & "," & res)
        outputFileSize = getFileSize(outputFile)
        close(outputFile)

    echo ""
    echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
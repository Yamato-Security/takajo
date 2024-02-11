proc stackProcesses(ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the Stack Processes command"
    echo ""
    echo "This command will stack executed processes."
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
        stackProcesses = initCountTable[string]()
        uniqueProcesses = 0

    bar[0].total = totalLines
    bar.setup()

    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        let eventId = jsonLine["EventID"].getInt(0)
        let channel = jsonLine["Channel"].getStr("N/A")
        if (eventId == 1 and not ignoreSysmon and channel == "Sysmon") or
           (eventId == 4688 and not ignoreSecurity and channel == "Security"):
            let process = jsonLine["Details"]["Proc"].getStr("N/A")
            stackProcesses.inc(process)

    bar.finish()
    echo ""

    stackProcesses.sort()

    # Print results to screen
    var outputFileSize = 0
    if output == "":
        for process, count in stackProcesses:
            inc uniqueProcesses
            var commaDelimitedStr = $count & "," & process
            commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
            echo commaDelimitedStr
    # Save to CSV file
    else:
        let outputFile = open(output, fmWrite)
        writeLine(outputFile, "Count,Processes")

        # Write results
        for process, count in stackProcesses:
            inc uniqueProcesses
            writeLine(outputFile, $count & "," & process)
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
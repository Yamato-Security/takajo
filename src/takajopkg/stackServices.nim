proc stackServices(ignoreSysmon: bool = false, ignoreSecurity: bool = false,output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the Stack Services command"
    echo ""
    echo "This command will stack service names and paths."
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
        stackServices = initCountTable[string]()
        stackCount = initTable[string, CountTable[string]]()

    bar[0].total = totalLines
    bar.setup()

    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        let eventId = jsonLine["EventID"].getInt(0)
        let channel = jsonLine["Channel"].getStr("N/A")
        if (eventId == 7040 and not ignoreSysmon and channel == "Sysmon") or
           (eventId == 4697 and not ignoreSecurity and channel == "Sec"):
            let svc = jsonLine["Details"]["Svc"].getStr("N/A")
            let path = jsonLine["Details"]["Path"].getStr("N/A")
            let res = svc & " -> " & path
            stackServices.inc(res)
            stackRuleCount(jsonLine, stackCount)
    bar.finish()
    echo ""

    if stackServices.len == 0:
       echo "No results where found."
    else:
        # Print results to screen
        printAlertCount(stackCount)
        stackServices.sort()
        var stackServicesSorted = newOrderedTable[string, int]()
        var stack: seq[string] = newSeq[string]()
        var prevCount = 0
        for service, count in stackServices:
            stack.add(service)
            if prevCount == count:
                continue
            stack.sort()
            for s in stack:
                stackServicesSorted[s] = count
            stack = newSeq[string]()
            prevCount = count
        stack.sort()
        for s in stack:
            stackServicesSorted[s] = prevCount

        # Print results to screen
        var outputFileSize = 0
        if output == "":
            for service, count in stackServicesSorted:
                var commaDelimitedStr = $count & "," & service
                commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
                echo commaDelimitedStr
        # Save to CSV file
        else:
            let outputFile = open(output, fmWrite)
            writeLine(outputFile, "Count,Services")

            # Write results
            for service, count in stackServicesSorted:
                writeLine(outputFile, $count & "," & service)
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
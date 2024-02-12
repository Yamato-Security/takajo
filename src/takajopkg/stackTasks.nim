proc decodeEntity(txt: string): string =
   return txt.replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;","\"").replace("&apos;","'")

proc stackTasks(ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the Stack Tasks command"
    echo ""
    echo "This command will stack new scheduled tasks."
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
        stackTasks = initCountTable[string]()

    bar[0].total = totalLines
    bar.setup()


    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        let eventId = jsonLine["EventID"].getInt(0)
        let channel = jsonLine["Channel"].getStr("N/A")
        if eventId == 4698 and channel == "Sec":
            let user = jsonLine["Details"]["User"].getStr("N/A")
            let name = jsonLine["Details"]["Name"].getStr("N/A")
            let content = jsonLine["Details"]["Content"].getStr("N/A").replace("\\r\\n", "")
            let node = parseXml(content)
            let commands = node.findAll("Command")
            var commandAndArgs = ""
            if len(commands) > 0:
                commandAndArgs = $commands[0]
                commandAndArgs = commandAndArgs.replace("<Command>", "").replace("</Command>","")
            let arguments = node.findAll("Arguments")
            if len(arguments) > 0:
                commandAndArgs = commandAndArgs & " " & $arguments[0]
                commandAndArgs = commandAndArgs.replace("<Arguments>", "").replace("</Arguments>","")
            let result = user & " -> "  & name & " -> " & decodeEntity(commandAndArgs)
            stackTasks.inc(result)

    bar.finish()
    echo ""

    stackTasks.sort()
    if stackTasks.len == 0:
        echo "No results where found."
    else:
        # Print results to screen
        var outputFileSize = 0
        if output == "":
            for task, count in stackTasks:
                var commaDelimitedStr = $count & "," & task
                commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
                echo commaDelimitedStr
        # Save to CSV file
        else:
            let outputFile = open(output, fmWrite)
            writeLine(outputFile, "Count,Tasks")

            # Write results
            for task, count in stackTasks:
                writeLine(outputFile, $count & "," & task)
            outputFileSize = getFileSize(outputFile)
            close(outputFile)
            echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
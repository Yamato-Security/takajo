proc splitCsvTimeline(makeMultiline: bool = false, output: string = "output", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    echo "Started the Split CSV Timeline command"
    echo ""
    echo "This command will split a large CSV timeline into many multiple ones based on computer name."
    echo "If you want to separate the field data by newlines, add the -m option."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""
    echo "Splitting the Hayabusa CSV timeline. Please wait."

    if not dirExists(output):
        echo ""
        echo "The directory '" & output & "' does not exist so will be created."
        createDir(output)
    echo ""

    var
        inputFile = open(timeline, FileMode.fmRead)
        line = ""
        filenameSequence: seq[string] = @[]
        filesTable = initTable[string, File]()
        bar: SuruBar = initSuruBar()

    bar[0].total = totalLines
    bar.setup()

    # Read in the CSV header
    let csvHeader = inputFile.readLine()
    while inputFile.endOfFile == false:
        inc bar
        bar.update(1000000000) # refresh every second

        var currentLine = inputFile.readLine()
        let splitFields = currentLine.split(',')
        var computerName = splitFields[1]
        computerName = computerName[1 .. computerName.len - 2] # Remove surrounding double quotes

        # If it is the first time we see this computer name, then record it in a str sequence, create a file,
        # write the CSV headers and current row.
        if not filesTable.hasKey(computerName):
            let filename = output & "/" & computerName & "-HayabusaResults.csv"
            filenameSequence.add(filename)
            var outputFile = open(filename, fmWrite)
            filesTable[computerName] = outputFile
            outputFile.write(csvHeader)
            outputFile.write("\p")
            flushFile(outputFile)  # Flush buffer after writing to file

        # Use the file from the table and write the line.
        var outputFile = filesTable[computerName]
        if makeMultiline == true:
            currentLine = currentLine.replace("¦", "\n")
            outputFile.write(currentLine)
        else:
            outputFile.write(currentLine)
        outputFile.write("\p")
        flushFile(outputFile)
    bar.finish()

    # Close all opened files
    for file in filesTable.values:
        close(file)

    close(inputFile)

    echo ""
    for fn in filenameSequence:
        let fileSize = getFileSize(fn)
        echo "Saved file: " & fn & " (" & formatFileSize(fileSize) & ")"

    echo ""

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
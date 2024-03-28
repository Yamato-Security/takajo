proc splitCsvTimeline(makeMultiline: bool = false, output: string = "output",
        quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    checkArgs(quiet, timeline, "informational")

    echo "Started the Split CSV Timeline command"
    echo ""
    echo "This command will split a large CSV timeline into many multiple ones based on computer name."
    echo "If you want to separate the field data by newlines, add the -m option."
    echo ""

    var totalLines = 0
    var filePaths = getTargetExtFileLists(timeline, ".csv", true)
    for timelinePath in filePaths:
        totalLines += countLinesInTimeline(timelinePath)


    echo "Splitting the Hayabusa CSV timeline. Please wait."

    if not dirExists(output):
        echo ""
        echo "The directory '" & output & "' does not exist so will be created."
        createDir(output)
    echo ""

    var
        filenameSequence: seq[string] = @[]
        filesTable = initTable[string, File]()
        bar: SuruBar = initSuruBar()

    bar[0].total = totalLines

    for timelinePath in filePaths:
        var inputFile = open(timelinePath, fmRead)
        # Read in the CSV header
        let csvHeader = inputFile.readLine()
        let headerColums = csvHeader.split(',')
        var computerColumnNum = 0
        for i, col in enumerate(headerColums):
            if "Computer" in col:
                computerColumnNum = i
                break
        if computerColumnNum == 0:
            echo ""
            echo "There is no column for Computer. Please specify a valid csv."
            createDir(output)
        echo ""
        bar.setup()

        inc bar
        while inputFile.endOfFile == false:
            inc bar
            bar.update(1000000000) # refresh every second

            var currentLine = inputFile.readLine()
            let splitFields = currentLine.split(',')
            var computerName = splitFields[computerColumnNum]
            computerName = computerName[1 .. computerName.len -
                    2] # Remove surrounding double quotes

            # If it is the first time we see this computer name, then record it in a str sequence, create a file,
            # write the CSV headers and current row.
            if not filesTable.hasKey(computerName):
                let filename = output & "/" & computerName & "-HayabusaResults.csv"
                filenameSequence.add(filename)
                var outputFile = open(filename, fmWrite)
                filesTable[computerName] = outputFile
                outputFile.write(csvHeader)
                outputFile.write("\p")
                flushFile(outputFile) # Flush buffer after writing to file

            # Use the file from the table and write the line.
            var outputFile = filesTable[computerName]
            if makeMultiline == true:
                currentLine = currentLine.replace("¦", "\n")
                outputFile.write(currentLine)
            else:
                outputFile.write(currentLine)
            outputFile.write("\p")
            flushFile(outputFile)
        inc bar
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
    outputElapsedTime(startTime)

proc splitJsonTimeline(output: string = "output", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())
    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    echo "Calculating total lines in the JSONL file. Please wait."
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""
    echo "Splitting the Hayabusa JSONL timeline into separate timelines according to the computer name."

    if not dirExists(output):
        echo ""
        echo "The directory '" & output & "' does not exist so will be created."
        createDir(output)
    echo ""

    var
        inputFile = open(timeline, FileMode.fmRead)
        filenameSequence: seq[string] = @[]
        filesTable = initTable[string, File]()
        bar = newProgressBar(total = totalLines)
        lineCount = 0
        updateInterval = max(totalLines div 500, 1)
    bar.start()

    for line in lines(timeline):
        inc(lineCount)
        if lineCount mod updateInterval == 0:  # Update about every .2% of lines
            bar.set(lineCount)
        updateInterval = max(totalLines div 500, 1)  # Update about every .2% of lines, but at least once per line
        let jsonLine = parseJson(line)
        let computerName = jsonLine["Computer"].getStr()

        if not filesTable.hasKey(computerName):
            let filename = output & "/" & computerName & "-HayabusaResults.jsonl"
            filenameSequence.add(filename)
            var outputFile = open(filename, fmWrite)
            filesTable[computerName] = outputFile
            outputFile.write(line)
            outputFile.write("\p")
            flushFile(outputFile)
        else:
            var outputFile = filesTable[computerName]
            outputFile.write(line)
            outputFile.write("\p")
            flushFile(outputFile)
    bar.finish()

    # Close all opened files
    for file in filesTable.values:
        close(file)

    echo ""
    for fn in filenameSequence:
        let fileSize = getFileSize(fn)
        echo "Created the file: " & fn & " (" & formatFileSize(fileSize) & ")"

    echo ""

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
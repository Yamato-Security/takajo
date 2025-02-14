proc splitJsonTimeline(output: string = "output", quiet: bool = false,
        timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

    echo "Started the Split JSONL Timeline command"
    echo ""
    echo "This command will split a large JSONL timeline into many multiple ones based on computer name."
    echo ""

    var totalLines = 0
    var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
    for timelinePath in filePaths:
        totalLines += countLinesInTimeline(timelinePath)

    echo "Splitting the Hayabusa JSONL timeline. Please wait."

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
    bar.setup()

    for timelinePath in filePaths:
        for line in lines(timeline):
            inc bar
            bar.update(1000000000) # refresh every second

            let jsonLineOpt = parseLine(line)
            if jsonLineOpt.isNone:
                continue
            let jsonLine: HayabusaJson = jsonLineOpt.get()
            let computerName = jsonLine.Computer

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
        echo "Saved file: " & fn & " (" & formatFileSize(fileSize) & ")"

    echo ""
    outputElapsedTime(startTime)

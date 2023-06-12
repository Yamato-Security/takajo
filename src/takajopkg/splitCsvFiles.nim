proc splitCsvFiles(outputDir: string = "output", quiet: bool = false, timeline: string): int =

    if not dirExists(outputDir):
        echo ""
        echo "The directory '" & outputDir & "' does not exist so will be created."
        echo ""
        createDir(outputDir)

    var
        inputFile = open(timeline, FileMode.fmRead)
        line = ""
        computersSequence: seq[string] = @[]

    # Read in the CSV header
    let csvHeader = inputFile.readLine()
    while inputFile.endOfFile == false:
        let currentLine = inputFile.readLine()
        let splitFields = currentLine.split(',')
        var computerName = splitFields[1]
        computerName = computerName[1 .. computerName.len - 2] # Remove surrounding double quotes
        # If it is the first time we see this computer name, then record it in a str sequence, create a file,
        # write the CSV headers and current row.
        if not computersSequence.contains(computerName):
            let filename = outputDir & "/" & computerName & "-HayabusaResults.csv"
            computersSequence.add(computerName)
            var outputFile = open(filename, fmWrite)
            outputFile.write(csvHeader)
            outputFile.write("\p")
            outputFile.write(currentLine)
            outputFile.write("\p")
            close(outputFile)
        # If the file already exists, append the data.
        else:
            let filename = outputDir & "/" & computerName & "-HayabusaResults.csv"
            var outputFile = open(filename, fmAppend)
            outputFile.write(currentLine)
            outputFile.write("\p")
            close(outputFile)

    close(inputFile)

    #[
    # if csvPath is not valid, error output and quit.
    if inputFile == nil:
        quit("Error: cannot open the file. FilePath: " & timeline)

    var
        parseCSV: CsvParser
        computersSequence: seq[string] = @[]

    # Parse the CSV
    open(parseCSV, inputFile, timeline)
    parseCSV.readHeaderRow()
    let headers = parseCSV.row

    if parseCSV.headers[1] != "Computer":
        echo "Error: The second column is not Computer."
        echo ""
        return

    while parseCSV.readRow():
        let computerName = parseCSV.rowEntry("Computer")
        # If it is the first time we see this computer name, then record it in a str sequence, create a file,
        # write the CSV headers and current row.
        if not computersSequence.contains(computerName):
            let filename = outputDir & "/" & computerName & "-HayabusaResults.csv"
            computersSequence.add(computerName)
            var outputFile = open(filename, fmWrite)
            outputFile.write(headers)
            outputFile.write("\p")
            outputFile.write(parseCSV.row)
            outputFile.write("\p")



    parseCSV.close()
    ]#
# TODO
# Output to stdout in tables (Target User, Target Computer, Logon Type, Source Computer)
# Remove local logins

proc stackLogons(localSrcIpAddresses = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

    echo "Started the Stack Logons command"
    echo ""
    echo "This command will stack logons based on target user, target computer, source IP address and source computer from Security 4624 events."
    echo "Local source IP addresses are not included by default but can be enabled with -l, --localSrcIpAddresses."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""
    echo "Scanning the Hayabusa timeline. Please wait."
    echo ""

    var
        EID_4624_count = 0
        tgtUser, tgtComp, logonType, srcIP, srcComp = ""
        seqOfStrings: seq[string]
        bar: SuruBar = initSuruBar()
        uniqueLogons = 0
        outputFileSize: int64

    bar[0].total = totalLines
    bar.setup()

    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()
        let ruleTitle = jsonLine.RuleTitle

        # EID 4624 Successful Logon
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count

            tgtUser = getJsonValue(jsonLine.Details, @["TgtUser"])
            tgtComp = jsonLine.Computer
            logonType = getJsonValue(jsonLine.Details, @["Type"])
            srcIP = getJsonValue(jsonLine.Details, @["SrcIP"])
            srcComp = getJsonValue(jsonLine.Details, @["SrcComp"])

            if not localSrcIpAddresses and isLocalIP(srcIP):
                discard
            else:
                seqOfStrings.add(tgtUser & "," & tgtComp & "," & logonType & "," & srcIP & "," & srcComp)
    bar.finish()
    echo ""

    var countsTable: Table[string, int] = initTable[string, int]()

    # Add a count for each time the unique string was found
    for string in seqOfStrings:
        if not countsTable.hasKey(string):
            countsTable[string] = 0
        countsTable[string] += 1

    # Create a sequence of pairs from the Table
    var seqOfPairs: seq[(string, int)] = @[]
    for key, val in countsTable:
        seqOfPairs.add((key, val))

    # Sort the sequence in descending order based on the count
    seqOfPairs.sort(proc (x, y: (string, int)): int = y[1] - x[1])

    # Print results to screen
    if output == "":
        # Print the sorted counts with unique strings
        for (string, count) in seqOfPairs:
            inc uniqueLogons
            var commaDelimitedStr = $count & "," & string
            commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
            echo commaDelimitedStr
    # Save to CSV file
    else:
        let outputFile = open(output, fmWrite)
        # Write headers
        writeLine(outputFile, "Count,TgtUser,TgtComp,LogonType,SrcIP,SrcComp")

        # Write results
        for (string, count) in seqOfPairs:
            inc uniqueLogons
            writeLine(outputFile, $count & "," & string)
        outputFileSize = getFileSize(outputFile)
        close(outputFile)

    echo ""
    echo "Unique logons: " & $uniqueLogons
    echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""
    outputElapsedTime(startTime)
# TODO
# Output to stdout in tables (Target User, Target Computer, Logon Type, Source Computer)
# Save to CSV
# Remove local logins
# Output to screen in tables

proc stackLogons(output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo "Loading the Hayabusa JSONL timeline. Please wait."
    echo ""

    var
        seqOfResultsTables: seq[TableRef[string, string]]
        EID_4624_count = 0
        bar = newProgressBar(total = totalLines)
        seqOfStrings: seq[string]
        uniqueCountTable = initTable[string, int]()
        uniqueResults = initTable[string, tuple[count: int, tgtUser: string, tgtComp: string, logonType: string, srcIP: string, srcComp: string]]()  # tuple for unique counts
    bar.start()

    # Loop through JSON lines
    for line in lines(timeline):
        bar.increment()
        let jsonLine = parseJson(line)
        let ruleTitle = jsonLine["RuleTitle"].getStr()

        # EID 4624 Successful Logon
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count
            var singleResultTable = newTable[string, string]()

            #change to just strings?
            singleResultTable["TgtUser"] = getJsonValue(jsonLine, @["Details", "TgtUser"])
            singleResultTable["TgtComp"] = getJsonValue(jsonLine, @["Computer"])
            singleResultTable["LogonType"] = logonNumberToString(parseInt(getJsonValue(jsonLine, @["Details", "Type"])))
            singleResultTable["SrcIP"] = getJsonValue(jsonLine, @["Details", "SrcIP"])
            singleResultTable["SrcComp"] = getJsonValue(jsonLine, @["Details", "SrcComp"])

            # Create a combination of TgtUser,TgtComp,LogonType,SrcIP,SrcComp
            seqOfStrings.add(singleResultTable["TgtUser"] & "," & singleResultTable["TgtComp"] & "," & singleResultTable["LogonType"] & "," & singleResultTable["SrcIP"] & "," & singleResultTable["SrcComp"])
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
            var commaDelimitedStr = $count & "," & string
            commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
            echo commaDelimitedStr
    # Save to CSV file
    else:
        let file = open(output, fmWrite)
        # Write headers
        writeLine(file, "Count,TgtUser,TgtComp,LogonType,SrcIP,SrcComp")

        # Write results
        for (string, count) in seqOfPairs:
            writeLine(file, $count & "," & string)
        close(file)

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""

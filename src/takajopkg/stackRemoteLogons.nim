# TODO
# Output to stdout in tables (Target User, Target Computer, Logon Type, Source Computer)
# Save to CSV
# Remove local logins

proc stackRemoteLogons(output: string, quiet: bool = false, timeline: string) =
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
    bar.start()

    for line in lines(timeline):
        bar.increment()
        let jsonLine = parseJson(line)
        let ruleTitle = jsonLine["RuleTitle"].getStr()

        #EID 4624 Successful Logon
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count
            var singleResultTable = newTable[string, string]()
            let details = jsonLine["Details"]
            let extraFieldInfo = jsonLine["ExtraFieldInfo"]
            let logonType = details.extractInt("Type")

            # Commented out due to undefined functions
            #singleResultTable["Type"] = logonNumberToString(logonType)
            #singleResultTable["TargetComputer"] = jsonLine.extractStr("Computer")
            #singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            #singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            #singleResultTable["SourceComputer"] = details.extractStr("SrcComp")

            seqOfStrings.add(details.extractStr("TgtUser") & " : " & jsonLine.extractStr("Computer") &
                logonNumberToString(logonType) & " : " & details.extractStr("SrcIP") & " : " & details.extractStr("SrcComp"))

    bar.finish()
    echo ""
    seqOfStrings.sort()

    var countsTable: Table[string, int] = initTable[string, int]()

    for string in seqOfStrings:
        if not countsTable.hasKey(string):
            countsTable[string] = 0
        countsTable[string] += 1

    # Create a sequence of pairs from the Table
    var seqOfPairs: seq[(string, int)] = @[]
    for key, val in countsTable:
        seqOfPairs.add((key, val))

    # Sort the sequence in descending order based on the counts
    seqOfPairs.sort(proc (x, y: (string, int)): int = y[1] - x[1])

    # Print the sorted counts with unique strings
    for (string, count) in seqOfPairs:
        echo count, string


    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""

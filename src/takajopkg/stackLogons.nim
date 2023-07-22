# TODO
# Output to stdout in tables (Target User, Target Computer, Logon Type, Source Computer)
# Save to CSV
# Remove local logins

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

    for line in lines(timeline):
        bar.increment()
        let jsonLine = parseJson(line)
        let ruleTitle = jsonLine["RuleTitle"].getStr()

        #EID 4624 Successful Logon
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count
            var singleResultTable = newTable[string, string]()
            #let details = jsonLine["Details"]
            #let extraFieldInfo = jsonLine["ExtraFieldInfo"]
            #let logonType = details.extractInt("Type")

            singleResultTable["TgtUser"] = getJsonValue(jsonLine, @["Details", "TgtUser"])
            singleResultTable["TgtComp"] = getJsonValue(jsonLine, @["Computer"])
            singleResultTable["LogonType"] = logonNumberToString(parseInt(getJsonValue(jsonLine, @["Details", "Type"])))
            singleResultTable["SrcIP"] = getJsonValue(jsonLine, @["Details", "SrcIP"])
            singleResultTable["SrcComp"] = getJsonValue(jsonLine, @["Details", "SrcComp"])

            # Combine all fields into a unique string and update counts
            #[
            let combinedKey = $singleResultTable
            if combinedKey in uniqueResults:
                uniqueResults[combinedKey].count.inc()
            else:
                uniqueResults[combinedKey] = (count: 1, tgtUser: singleResultTable["TgtUser"], tgtComp: singleResultTable["TgtComp"], logonType: singleResultTable["LogonType"], srcIP: singleResultTable["SrcIP"], srcComp: singleResultTable["SrcComp"])
]#
            seqOfStrings.add(singleResultTable["TgtUser"] & "🦅" & singleResultTable["TgtComp"] & singleResultTable["LogonType"] & "🦅" & singleResultTable["SrcIP"] & "🦅" & singleResultTable["SrcComp"])
            seqOfResultsTables.add(singleResultTable)

    bar.finish()
    echo ""
    #seqOfStrings.sort()
    # Convert table to a sequence of tuples and sort by count
    #let sortedResults = toSeq(uniqueResults.pairs).sortedBy(it[1].count)


    var countsTable: Table[string, int] = initTable[string, int]()

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

    # Print the sorted counts with unique strings
    for (string, count) in seqOfPairs:
        echo count, string


    # Write results to CSV
   # let file = open(output, fmWrite)
   # defer: close(file)

    # Write headers
   #writeLine(file, "Count,TgtUser,TgtComp,LogonType,SrcIP,SrcComp")

    # Write results
    #[
    for result in sortedResults:
        let entry = result[1]
        writeLine(file, fmt"{entry.count},{entry.tgtUser},{entry.tgtComp},{entry.logonType},{entry.srcIP},{entry.srcComp}")
]#

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""

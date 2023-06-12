proc listLogonSummary(output: string, quiet: bool = false, timeline: string): int =
    echo "hi"
#[
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo "Loading the Hayabusa JSONL timeline. Please wait."
    echo ""

    var
        seqOfResultsTables: seq[TableRef[string, string]] # Sequences are immutable so need to create a sequence of pointers to tables so we can update ["ElapsedTime"]
        EID_4624_count = 0 # Successful logon
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
            #[
            singleResultTable["Type"] = logonNumberToString(logonType)
            singleResultTable["TargetComputer"] = jsonLine.extractStr("Computer")
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            singleResultTable["SourceComputer"] = details.extractStr("SrcComp")
            ]#
            seqOfStrings.add(details.extractStr("TgtUser") & " : " & jsonLine.extractStr("Computer") &
                logonNumberToString(logonType) & " : " & details.extractStr("SrcIP") & " : " & details.extractStr("SrcComp"))

            #seqOfResultsTables.add(singleResultTable)

    bar.finish()
    echo ""
    sort(seqOfStrings)

    # Create a table to store the counts of unique strings
    var countsTable: Table[string, int] = initTable[string, int]()

    # Count the occurrences of each string
    for string in seqOfStrings:
        countsTable[string] += 1

    # Sort the countsTable in descending order based on the counts
    var sortedCounts = sortBy(countsTable.pairs, proc(a, b: (string, int)): int = b[1] - a[1])

    # Print the sorted counts with unique strings
    for (string, count) in sortedCounts:
        echo count, string


    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo "" ]#
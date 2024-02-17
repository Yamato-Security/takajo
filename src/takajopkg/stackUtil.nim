import general
import json
import nancy
import takajoTerminal
import std/algorithm
import std/strutils
import std/tables

proc stackRuleCount*(jsonLine:JsonNode, stackCount: var Table[string, CountTable[string]]) =
    let level = jsonLine["Level"].getStr("N/A")
    if level != "info":
        if level notin stackCount:
              stackCount[level] = initCountTable[string]()
        stackCount[level].inc(jsonLine["RuleTitle"].getStr("N/A"))

proc alertCmp(x, y: (string, int)): int =
  result = cmp(x[1], y[1]) * -1
  if result == 0:
    result = cmp(x[0], y[0])

proc sortCountTable(countTable: var CountTable[string]): seq[(string, int)] =
    countTable.sort()
    var stack = newSeq[(string, int)]()
    for ruleTitle, count in countTable:
        stack.add((ruleTitle, count))
    stack.sort(alertCmp) # Sort by rule name
    return stack

proc printAlertCount(countTable: Table[string, CountTable[string]]) =
    if countTable.len == 0:
        return
    var table: TerminalTable
    table.add ["Count", "Level", "RuleTitle"]
    for level in ["crit", "high", "med", "low"]:
        if level notin countTable:
            continue
        var result = countTable[level]
        var sortedResult = sortCountTable(result)
        for (ruleTitle, count) in sortedResult:
            let color = levelColor(level)
            table.add color count, color level, color ruleTitle
    table.echoTableSepsWithStyled(seps = boxSeps)
    echo ""

proc outputResult*(output:string, stackTarget: var CountTable[string], stackAlert: Table[string,  CountTable[string]]) =
    echo ""
    if stackTarget.len == 0:
        echo "No results where found."
    else:
        # Print results to screen
        printAlertCount(stackAlert)
        let sortedStack = sortCountTable(stackTarget)
        var outputFileSize = 0
        if output == "":
            for (key, count) in sortedStack:
                var commaDelimitedStr = $count & "," & key
                commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
                echo commaDelimitedStr
        # Save to CSV file
        else:
            let outputFile = open(output, fmWrite)
            writeLine(outputFile, "Count,Processes")

            # Write results
            for (key, count) in sortedStack:
                writeLine(outputFile, $count & "," & key)
            outputFileSize = getFileSize(outputFile)
            close(outputFile)
            echo ""
            echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
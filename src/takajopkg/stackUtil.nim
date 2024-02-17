import json
import nancy
import takajoTerminal
import std/algorithm
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

proc printAlertCount*(countTable: Table[string, CountTable[string]]) =
    if countTable.len == 0:
        return
    var table: TerminalTable
    table.add ["Count", "Level", "RuleTitle"]
    for level in ["crit", "high", "med", "low"]:
        if level notin countTable:
            continue
        var result = countTable[level]
        result.sort() # Sort by number of detections
        var stack = newSeq[(string, int)]()
        for ruleTitle, count in result:
            stack.add((ruleTitle, count))
        stack.sort(alertCmp) # Sort by rule name
        for (ruleTitle, count) in stack:
            let color = levelColor(level)
            table.add color count, color level, color ruleTitle
    table.echoTableSepsWithStyled(seps = boxSeps)
    echo ""
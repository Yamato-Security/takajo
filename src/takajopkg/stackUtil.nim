import json
import nancy
import takajoTerminal
import std/tables
import std/algorithm

proc stackRuleCount*(jsonLine:JsonNode, stackCount: var Table[string, CountTable[string]]) =
    let level = jsonLine["Level"].getStr("N/A")
    if level != "info":
        if level notin stackCount:
              stackCount[level] = initCountTable[string]()
        stackCount[level].inc(jsonLine["RuleTitle"].getStr("N/A"))

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
        for ruleTitle, count in result:
            let color = levelColor(level)
            table.add color count, color level, color ruleTitle
    table.echoTableSepsWithStyled(seps = boxSeps)
    echo ""
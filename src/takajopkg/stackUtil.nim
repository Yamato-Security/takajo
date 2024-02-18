import general
import json
import nancy
import takajoTerminal
import std/algorithm
import std/enumerate
import std/sets
import std/sequtils
import std/strutils
import std/tables

let LEVEL_ORDER = {"crit": 5, "high": 4, "med": 3, "low": 2, "info": 1}.toTable

type StackRecord* = object
  key*: string
  count* = 0
  levelsOrder* = 0
  levels* = initHashSet[string]()
  ruleTitles* = initHashSet[string]()

proc calcLevelOrder(x: StackRecord): int =
  result = 0
  if "crit" in x.levels:
      result = LEVEL_ORDER["crit"]
  elif "high" in x.levels:
      result = LEVEL_ORDER["high"]
  elif "med" in x.levels:
      result = LEVEL_ORDER["med"]
  elif "low" in x.levels:
      result = LEVEL_ORDER["low"]
  elif "info" in x.levels:
      result = LEVEL_ORDER["info"]

proc levelCmp(x, y: string): int =
  cmp(LEVEL_ORDER[x], LEVEL_ORDER[y]) * -1

proc recordCmp(x, y: StackRecord): int =
  result = cmp(x.levelsOrder, y.levelsOrder) * -1
  if result == 0:
      result = cmp(x.count, y.count) * - 1
  if result == 0:
      result = cmp(x.key, y.key)

proc buildCSVRecord(x: StackRecord): array[4, string] =
  let levelsStr = toSeq(x.levels).sorted(levelCmp).join(",")
  let ruleTitlesStr = toSeq(x.ruleTitles).sorted.join(",")
  return [intToStr(x.count), x.key, levelsStr, ruleTitlesStr]

proc stackResult*(key:string, minLevel:string, jsonLine:JsonNode, stack: var Table[string, StackRecord]) =
    let level = jsonLine["Level"].getStr("N/A")
    if not isMinLevel(level, minLevel):
        return
    var val: StackRecord
    if key notin stack:
        val = StackRecord(key: key)
    else:
        val = stack[key]
    val.count += 1
    val.levels.incl(level)
    val.levelsOrder = val.calcLevelOrder()
    val.ruleTitles.incl(jsonLine["RuleTitle"].getStr("N/A"))
    stack[key] = val

proc outputResult*(output:string, culumnName: string, stack: Table[string, StackRecord]) =
    echo ""
    if stack.len == 0:
        echo "No results where found."
    else:
        let stackRecords = toSeq(stack.values).sorted(recordCmp).map(buildCSVRecord)
        let header = ["Count", culumnName, "Levels", "Alerts"]
        var table: TerminalTable
        table.add header
        for row in stackRecords:
            let color = levelColor(row[2])
            table.add color row[0], color row[1], color row[2], color row[3]
        table.echoTableSepsWithStyled(seps = boxSeps)
        echo ""
        if output == "":
            return
        let outputFile = open(output, fmWrite)
        writeLine(outputFile, header.join(","))
        for row in stackRecords:
            for i, col in enumerate(row):
                if i < row.len - 1:
                  outputFile.write(escapeCsvField(col) & ",")
                else:
                  outputFile.write(escapeCsvField(col))
        close(outputFile)
        echo ""
        echo "Saved file: " & output & " (" & formatFileSize(getFileSize(outputFile)) & ")"
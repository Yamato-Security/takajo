import general
import json
import nancy
import takajoTerminal
import hayabusaJson
import std/algorithm
import std/enumerate
import std/sequtils
import std/strutils
import std/tables

let LEVEL_ORDER = {"crit": 5, "high": 4, "med": 3, "low": 2, "info": 1}.toTable

type StackRecord* = ref object
    key*: string
    count* = 0
    eid* = ""
    channel* = ""
    levelsOrder* = 0
    levels*:CountTable = initCountTable[string]()
    ruleTitles*:CountTable = initCountTable[string]()
    otherColumn = newSeq[string]()

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

proc levelCmp(x, y: (string, int)): int =
  cmp(LEVEL_ORDER[x[0]], LEVEL_ORDER[y[0]]) * -1

proc buildCountStr(x:(string, int)): string =
  x[0] & " (" & intToStr(x[1]) & ")"

proc recordCmp(x, y: StackRecord): int =
  result = cmp(x.levelsOrder, y.levelsOrder) * -1
  if result == 0:
      result = cmp(x.count, y.count) * - 1
  if result == 0:
      result = cmp(x.channel, y.channel)
  if result == 0:
      result = cmp(x.eid, y.eid)
  if result == 0:
      result = cmp(x.key, y.key)

proc buildCSVRecord(x: StackRecord, isStackComputer:bool = false): seq[string] =
  let levelsStr = toSeq(pairs(x.levels)).sorted(levelCmp).map(buildCountStr).join(" | ")
  let ruleTitlesStr = toSeq(pairs(x.ruleTitles)).sorted.map(buildCountStr).join(" | ")
  if x.otherColumn.len == 0:
    if isStackComputer:
        return @[intToStr(x.count), x.key, levelsStr, ruleTitlesStr]
    return @[intToStr(x.count), x.channel, x.eid, x.key, levelsStr, ruleTitlesStr]
  return concat(@[intToStr(x.count), x.channel, x.eid], x.otherColumn, @[levelsStr, ruleTitlesStr])

proc stackResult*(key:string, stack: var Table[string, StackRecord], minLevel:string, jsonLine:HayabusaJson, otherColumn:seq[string] = @[]) =
    let level = jsonLine.Level
    if not isMinLevel(level, minLevel):
        return
    var val: StackRecord
    if key notin stack:
        val = StackRecord(key: key, eid: intToStr(jsonLine.EventID), channel: jsonLine.Channel)
    else:
        val = stack[key]
    val.count += 1
    val.levels.inc(level)
    val.levelsOrder = val.calcLevelOrder()
    val.ruleTitles.inc(jsonLine.RuleTitle)
    val.otherColumn = otherColumn
    stack[key] = val

proc outputResult*(output:string, culumnName: string, stack: Table[string, StackRecord], otherHeader:seq[string] = newSeq[string](), isStackComputer:bool = false) =
    echo ""
    if stack.len == 0:
        echo "No results where found."
    else:
        let stackRecords = toSeq(stack.values).sorted(recordCmp).map(proc(x: StackRecord): seq[string] = buildCSVRecord(x, isStackComputer))
        var header = @["Count", "Channel", "EventID", culumnName, "Levels", "Alerts"]
        if otherHeader.len > 0:
            header = concat(@["Count", "Channel", "EventID"], otherHeader, @["Levels", "Alerts"])
        if isStackComputer:
            header = @["Count", culumnName, "Levels", "Alerts"]
        var table: TerminalTable
        table.add header
        for row in stackRecords:
            let color = levelColor(row[^2])
            table.add map(row, proc(col: string): string = color col)
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
                  outputFile.write(escapeCsvField(col) & "\p")
        let outputFileSize = getFileSize(outputFile)
        close(outputFile)
        echo ""
        echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
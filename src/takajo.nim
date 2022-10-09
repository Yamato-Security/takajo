import cligen
import os
import terminal
import std/sequtils
import std/strformat
import std/strutils
import std/tables
import takajopkg/submodule

proc listUndetectedEvtxFiles(timeline: string, evtxDir: string,
    columnName: system.string = "EvtxFile", quiet: bool = false,
        output: string = ""): int =

  if not quiet:
    styledEcho(fgGreen, outputLogo())

  let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
  var fileLists: seq[string] = getTargetExtFileLists(evtxDir, ".evtx")

  var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
  detectedPaths = deduplicate(detectedPaths)

  let checkResult = getUnlistedSeq(fileLists, detectedPaths)
  var outputStock: seq[string] = @[]

  outputStock.add("Finished. ")
  outputStock.add("---------------")

  if checkResult.len == 0:
    echo "Great! No undetected evtx files were found."
  else:
    echo "Undetected evtx files:"
    echo ""
    var numberOfEvtxFiles = 0
    for undetectedFile in checkResult:
      outputStock.add(undetectedFile)
      inc numberOfEvtxFiles
    outputStock.add("")
    let undetectedPercentage = (checkResult.len() / fileLists.len()) * 100
    outputStock.add(fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections.")
    outputStock.add(fmt"Number of evtx files not detected: {numberOfEvtxFiles}")
    outputStock.add("")
  if output != "":
    let f = open(output, fmWrite)
    defer: f.close()
    for line in outputStock:
      f.writeLine(line)
  else:
    echo outputstock.join("\n")
  discard


proc listUnusedRules(timeline: string, rulesDir: string,
    columnName: string = "RuleFile", quiet: bool = false,
        output: string = ""): int =

  if not quiet:
    styledEcho(fgGreen, outputLogo())

  let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
  var fileLists: seq[string] = getTargetExtFileLists(rulesDir, ".yml")
  var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
  detectedPaths = deduplicate(detectedPaths)

  echo "Finished. "
  echo "---------------"

  let checkResult = getUnlistedSeq(fileLists, detectedPaths)
  if checkResult.len == 0:
    echo "Great! No unused rule files were found."
  else:
    echo "Unused rule files:"
    var numberOfUnusedRules = 0
    for undetectedFile in checkResult:
      echo undetectedFile
      inc numberOfUnusedRules
    let undetectedPercentage = (checkResult.len() / fileLists.len()) * 100
    echo ""
    echo fmt"{ undetectedPercentage :.4}% of the yml rules were not used."
    echo "Number of unused rule files: ", numberOfUnusedRules
    echo ""
  discard

when isMainModule:
  clCfg.version = "0.0.1"
  const examples = "Examples:\n  undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx\n  unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules\n"
  clCfg.useMulti = "Usage: takajo.exe <COMMAND>\n\nCommands:\n$subcmds\nCommand help: $command help <COMMAND>\n\n" & examples

  if paramCount() == 0:
    styledEcho(fgGreen, outputLogo())
  dispatchMulti(
    [
      listUndetectedEvtxFiles, cmdName = "undetected-evtx",
      doc = "List up undetected evtx files",
      help = {
        "timeline": "CSV timeline created by Hayabusa with verbose profile",
        "evtxDir": "The directory of .evtx files you scanned with Hayabusa",
        "columnName": "Specify custom column header name",
        "quiet": "Do not display the launch banner",
        "output": "Save the results to a text file. The default is to print to screen.",
      }
    ],
    [
      listUnusedRules, cmdName = "unused-rules",
      doc = "List up unused rules",
      help = {
        "timeline": "CSV timeline created by Hayabusa with verbose profile",
        "rulesDir": "Hayabusa rules directory",
        "columnName": "Specify custom column header name",
        "quiet": "Do not display the launch banner",
        "output": "Save the results to a text file. The default is to print to screen.",
      }
    ]
  )


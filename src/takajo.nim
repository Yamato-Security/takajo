import cligen
import os
import terminal
import std/sequtils
import std/strformat
import std/strutils
import std/tables
import takajopkg/submodule

proc listUndetectedEvtxFiles(timeline: string, evtxDir: string,
    columnName: system.string = "EvtxFile", quiet: bool = false): int =

  if not quiet:
    styledEcho(fgGreen,outputLogo())

  let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
  var fileLists: seq[string] = getTargetExtFileLists(evtxDir, ".evtx")

  var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
  detectedPaths = deduplicate(detectedPaths)

  let output = getUnlistedSeq(fileLists, detectedPaths)

  echo "Finished. "
  echo "---------------"

  if output.len == 0:
    echo "Great! No undetected evtx files were found."
  else:
    echo "Undetected evtx files:"
    echo ""
    var numberOfEvtxFiles = 0
    for undetectedFile in output:
      echo undetectedFile
      inc numberOfEvtxFiles
    let undetectedPercentage = (output.len() / fileLists.len()) * 100
    echo ""
    echo fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections."
    echo "Number of evtx files not detected: ", numberOfEvtxFiles
    echo ""
  discard


proc listUnusedRules(timeline: string, rulesDir: string,
    columnName = "RuleFile", quiet: bool = false): int =

  if not quiet:
    styledEcho(fgGreen,outputLogo())

  let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
  var fileLists: seq[string] = getTargetExtFileLists(rulesDir, ".yml")
  var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
  detectedPaths = deduplicate(detectedPaths)

  echo "Finished. "
  echo "---------------"

  let output = getUnlistedSeq(fileLists, detectedPaths)
  if output.len == 0:
    echo "Great! No unused rule files were found."
  else:
    echo "Unused rule files:"
    var numberOfUnusedRules = 0
    for undetectedFile in output:
      echo undetectedFile
      inc numberOfUnusedRules
    let undetectedPercentage = (output.len() / fileLists.len()) * 100
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
    styledEcho(fgGreen,outputLogo())
  dispatchMulti(
    [
      listUndetectedEvtxFiles, cmdName = "undetected-evtx",
      doc = "List up undetected evtx files",
      help = {
        "timeline": "CSV timeline created by Hayabusa with verbose profile",
        "evtxDir": "The directory of .evtx files you scanned with Hayabusa",
        "columnName": "Specify custom column header name",
        "quiet": "Do not display the launch banner"
      }
    ],
    [
      listUnusedRules, cmdName = "unused-rules",
      doc = "List up unused rules",
      help = {
        "timeline": "CSV timeline created by Hayabusa with verbose profile",
        "rulesDir": "Hayabusa rules directory",
        "columnName": "Specify custom column header name",
        "quiet": "Do not display the launch banner"
      }
    ]
  )


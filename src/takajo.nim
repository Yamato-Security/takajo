import cligen
import std/sequtils
import std/strformat
import std/strutils
import std/tables

import takajopkg/submodule

proc listUndetectedEvtxFiles(timeline: string, evtxDir: string,
    columnName: system.string = "EvtxFile"): int =
  ## List up undetected evtx files.

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
    columnName = "RuleFile"): int =
  ## List up unused rules.

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

  dispatchMulti(
    [
      listUndetectedEvtxFiles, cmdName = "list-undetected-evtx-files",
      help = {
      "timeline": "CSV timeline created by Hayabusa with verbose profile.",
      "evtxDir": "The directory of .evtx files you scanned with Hayabusa.",
      "columnName": "Column header name."
      }
    ],
    [
      listUnusedRules, cmdName = "list-unused-rules",
      help = {
        "rulesDir": "Hayabusa rules directory."
      }
    ]
  )

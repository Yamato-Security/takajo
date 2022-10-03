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

  echo "Finished check. "
  echo "---------------"

  if output.len == 0:
    echo "Great! No unused rules or undetected evtx files were found."
  else:
    echo "Undetected evtx Files:"
    for undetectedFile in output:
      echo "    - ", undetectedFile

    let undetectedPercentage = (output.len() / fileLists.len()) * 100
    echo fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections."
  discard


proc listUnusedRules(timeline: string, rulesDir: string,
    columnName = "RuleFile"): int =
  ## List up unused rules.

  let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
  var fileLists: seq[string] = getTargetExtFileLists(rulesDir, ".yml")
  var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
  detectedPaths = deduplicate(detectedPaths)

  echo "Finished check. "
  echo "---------------"

  let output = getUnlistedSeq(fileLists, detectedPaths)
  if output.len == 0:
    echo "Great! No unused rules or undetected evtx files were found."
  else:
    echo "Unused rule Files:"
    for undetectedFile in output:
      echo "    - ", undetectedFile
    let undetectedPercentage = (output.len() / fileLists.len()) * 100
    echo fmt"{ undetectedPercentage :.4}% of the yml rules were not used."

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

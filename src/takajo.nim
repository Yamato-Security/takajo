import takajopkg/submodule
import std/sequtils
import std/strformat

import docopt

let doc = """

Usage:
  takajo (-h | --help)
  takajo version
  takajo list-undetected-evtx-files -t <CSV_TIMELINE> -e <EVTX_DIR> [-c <COLUMN_NAME>]
  takajo list-unused-rules -t <CSV> -r <RULES_DIR> [-c <COLUMN_NAME>]

Actions:
  -h, --help                  Show help menu.
  version                     Show version.
  list-undetected-evtx-files  List up undetected evtx files.
  list-unused-rules           List up unused rules.

Options:
  -t, --timeline <CSV_TIMELINE> CSV timeline created by Hayabusa with verbose profile.
  -r, --rules-dir <RULES_DIR> Hayabusa rules directory.
  -e, --evtx-dir <EVTX_DIR> The directory of .evtx files you scanned with Hayabusa.
  -c, --column_name <COLUMN_NAME> Optional: Column header name. [default: EvtxFile|RuleFile]

"""


when isMainModule:
  let args = docopt(doc)
  if args["version"]:
    echo "Takajo Version 0.0.1"
  if "--timeline" in args:
    let csvData = getHayabusaCsvData($args["--timeline"])
    var fileLists: seq[string] =
      if args["list-undetected-evtx-files"]:
        let dirPath: string = $args["--evtx-dir"]
        getTargetExtFileLLists(dirPath, ".evtx")
      elif args["list-unused-rules"]:
        let dirPath: string = $args["--rules-dir"]
        getTargetExtFileLLists(dirPath, ".yml")
      else:
        @[]

    var targetColumn =
      if $args["--column_name"] != "nil":
        $args["--column_name"]
      elif args["list-undetected-evtx-files"]:
        "EvtxFile"
      else:
        "RuleFile"
    if not (targetColumn in csvData):
      quit(fmt"Coud not fine the {targetColumn} column. Please run hayabusa with the verbose profile (-P option).")
    var detectedPaths: seq[string] = csvData[targetColumn].map(getFileNameWithExt)
    detectedPaths = deduplicate(detectedPaths)
    if fileLists.len() == 0:
      quit("Target file does not exist in specified directory. Please check your option parameters.")
    else:
      var output: seq[string] = @[]
      let totalFileCnt = fileLists.len()
      for targetFile in fileLists:
        if not(targetFile in detectedPaths):
          output.add(targetFile)
      echo "Finished check. "
      echo "---------------"
      if output.len == 0:
        echo "Great! No unused rules or undetected evtx files were found."
      else:
        if args["list-undetected-evtx-files"]:
          let dirPath: string = $args["--evtx-dir"]
          fileLists = getTargetExtFileLLists(dirPath, ".evtx")
        var outputHeader =
          if args["list-unused-rules"]:
            "Unused rule Files:"
          elif args["list-undetected-evtx-files"]:
            "Undetected evtx Files:"
          else:
            ""
        echo outputHeader
        for undetectedFile in output:
          echo "    - ", undetectedFile
      let undetectedPercentage = (output.len() / totalFileCnt) * 100
      var resultsSummary =
        if args["list-undetected-evtx-files"]:
          fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections."
        elif args["list-unused-rules"]:
          fmt"{ undetectedPercentage :.4}% of the yml rules were not used."
        else:
          ""
      echo resultsSummary

import takajopkg/submodule
import std/sequtils
import std/strformat

import docopt

let doc = """
takajo

Usage:
  takajo (-h | --help)
  takajo --version
  takajo list-undetected-evtx-files -t <CSV> -e <EVTX_DIR_PATH> [-T <COLUMN>]
  takajo list-unused-rules -t <CSV> -r <TARGET_PATH> [-T <COLUMN>]

Options:
  -h --help           Show this screen.
  --version           Show version.
  -t --timeline=<CSV> CSV timeline created by Hayabusa.
  -r --rules-dir=<TARGET_PATH> Specified no detected file in hayabusa-rules directory.
  -e --evtx-dir=<EVTX_DIR_PATH> The directory of .evtx file you scanned with Hayabusa.
  -T --target-column=<column> Specified target column header name when check detected(RulePath when Unused rules listup and EvtxFile Undetected evtx files listup ) [default: EvtxFile|RuleFile]
"""


when isMainModule:
  let args = docopt(doc)
  if args["--version"]:
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
      if $args["--target-column"] != "nil":
        $args["--target-column"]
      elif args["list-undetected-evtx-files"]:
        "EvtxFile"
      else:
        "RuleFile"
    echo targetColumn
    var detectedPaths: seq[string] = csvData[targetColumn]
    detectedPaths = deduplicate(detectedPaths)
    if fileLists.len() == 0:
      quit("target file does not exist in specified directory. Please check option value.")
    else:
      var output: seq[string] = @[]
      var cnt = 0
      let totalFileCnt = fileLists.len()
      for targetFile in fileLists:
        if targetFile in detectedPaths:
          output.add(targetFile)
        cnt += 1
      echo "Finished check. "
      echo "---------------"
      if output.len == 0:
        echo "WellDone! Not found unused rule or undetected evtx file."
      else:
        if "list-undetected-evtx-files" in args:
          let dirPath: string = $args["--evtx-dir"]
          fileLists = getTargetExtFileLLists(dirPath, ".evtx")
        var outputHeader =
          if "list-unused-rules" in args:
            "Unused rule Files:"
          elif "list-undetected-evtx-files" in args:
            "Undetected evtx Files:"
          else:
            ""
        echo outputHeader
        for undetectedFile in output:
          echo "    - ", undetectedFile
      let undetectedPercentage = (output.len() / totalFileCnt) * 100
      var resultsSummary =
        if "list-undetected-evtx-files" in args:
          fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections."
        elif "list-unused-rules" in args:
          fmt"{ undetectedPercentage :.4}% of the yml rules were not used."
        else:
          ""
      echo resultsSummary

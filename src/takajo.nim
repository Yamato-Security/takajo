import takajopkg/submodule
import std/sequtils

import docopt

let doc = """
takajo

Usage:
  takajo [evtx|yml] <CSV-FILE> -c <target-path> -t <column>
  takajo (-h | --help)
  takajo --version

Options:
  -h --help           Show this screen.
  --version           Show version.
  -c --check-undetected=<target-path> Specified no detected file(rule or evtx) in hayabusa-rules directory.
  -t --target-column=<column> Specified target column header name when check detected rule file
"""


when isMainModule:
  let args = docopt(doc)
  if "<CSV-FILE>" in args:
    let csvData = getHayabusaCsvData($args["<CSV-FILE>"])
    var fileLists: seq[string]
    if "--check-undetected" in args:
      let rulePath: string = $args["--check-undetected"]
      if args["evtx"]:
        fileLists = getTargetExtFileLLists(rulePath, ".evtx")
      else:
        fileLists = getTargetExtFileLLists(rulePath, ".yml")
    if "--target-column" in args:
      let targetColumn = $args["--target-column"]
      var detectedPaths: seq[string] = csvData[targetColumn]
      detectedPaths = deduplicate(detectedPaths)
      if fileLists.len() == 0:
        quit("target file does not exist in specified directory. Please check -c option.")
      else:
        var output: seq[string] = @[]
        var cnt = 0
        for targetFile in fileLists:
          if targetFile in detectedPaths:
            output.add(targetFile)
          cnt += 1
        echo "Finished check. "
        echo "---------------"
        if output.len == 0:
          echo "WellDone! Not found undetected file."
        else:
          echo "Undetected File:"
          for undetectedFile in output:
            echo "    - ", undetectedFile


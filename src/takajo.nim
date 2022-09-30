import takajopkg/submodule
import std/sequtils

import docopt

let doc = """
takajo

Usage:
  takajo <CSV-FILE> -c <hayabusa-rulespath> -t <column>
  takajo (-h | --help)
  takajo --version

Options:
  -h --help           Show this screen.
  --version           Show version.
  -c --check-undetected=<hayabusa-rulespath> Check no detected rule file in hayabusa-rules directory.
  -t --target-column=<column> Specified target column header name when check detected rule file
"""


when isMainModule:
  let args = docopt(doc)
  if args["<CSV-FILE>"]:
    let csvData = getHayabusaCsvData($args["<CSV-FILE>"])
    var ymlLists: seq[string]
    if args["--check-undetected"]:
      let rulePath: string = $args["--check-undetected"]
      ymlLists = getTargetExtFileLLists(rulePath, "*.yml")
    if args["--target-column"]:
      let targetColumn = $args["--target-column"]
      var detectedRulePath: seq[string] = csvData[targetColumn]
      detectedRulePath = deduplicate(detectedRulePath)
      if ymlLists.len() == 0:
        quit("yml file does not exist in specified directory. Please check -c option.")
      else:
        var output: seq[string] = @[]
        var cnt = 0
        for ymlFile in ymlLists:
          if ymlFile in detectedRulePath:
            output.add(ymlFile)
          cnt += 1
        echo "Finished check. "
        echo "---------------"
        echo "Undetected rules:"
        for undetectedYmlFile in output:
          echo "    - ", undetectedYmlFile


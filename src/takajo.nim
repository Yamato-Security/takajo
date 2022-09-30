import takajopkg/submodule

import docopt

let doc = """
takajo

Usage:
  takajo <CSV-FILE>
  takajo (-h | --help)
  takajo --version

Options:
  -h --help           Show this screen.
  --version           Show version.
  -c --check-undetected=<hayabusa-rulespath>  Check no detected rule file in hayabusa-rules directory.
  -t --target-column=<column> Specified target column header name when check detected rule file
"""


when isMainModule:
  let args = docopt(doc)
  if args["<CSV-FILE>"]:
    let csvData = getHayabusaCsvData($args["<CSV-FILE>"])
    if args["<hayabusa-rulespath>"]:
      let rulePath: string = args["<hayabusa-rulespath>"]
      for f in walkDirRec(rulePath, "*.yml"):

    if args["c"] == true and args["<column>"]:
      let targetColumn = args["<column>"]
      csvData[targetColumn]

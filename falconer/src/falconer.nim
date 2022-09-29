import falconerpkg/submodule

import docopt

let doc = """
Falconer

Usage:
  falconer <CSV-FILE>
  falconer (-h | --help)
  falconer --version

Options:
  -h --help           Show this screen.
  --version           Show version.
  -c --check-undetected=<hayabusa-rulespath>  Check no detected rule file in hayabusa-rules directory.
  -t --target-column=<column> Specified target column header name when check detected rule file
"""


when isMainModule:
  let args = docopt(doc)
  if args["c"] == true and not args["<CSV-FILE>"]:
    let csvData = getHayabusaCsvData($args["<CSV-FILE>"])

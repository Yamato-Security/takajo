import general
import json
import math
import std/tables
import std/sequtils

type TTPResult* = ref object
  techniqueID: string
  comment: string
  score: int

proc newTTPResult*(techniqueID: string, comment: string,
    score: int): TTPResult =
  result = TTPResult(techniqueID: techniqueID, comment: comment, score: score)

proc outputTTPResult*(stackedMitreTags: Table[string, string],
    stackedMitreTagsCount: Table[string, int], output: string,
    displayTable: bool = true, name: string): string =
  var savedFiles = "n/a"
  if stackedMitreTags.len == 0:
    savedFiles = "No MITRE ATT&CK tags were found in the Hayabusa results."
    if displayTable:
      echo ""
      echo savedFiles
      echo "Please run your Hayabusa scan with a profile that includes the %MitreTags% field. (ex: -p verbose)"
  else:
    var mitreTags = newSeq[TTPResult]()
    let maxCount = stackedMitreTagsCount.values.toSeq.max
    for techniqueID, ruleTitle in stackedMitreTags:
      let score = toInt(round(stackedMitreTagsCount[techniqueID]/maxCount * 100))
      mitreTags.add(newTTPResult(techniqueID, ruleTitle, score))
    let jsonObj = %* {
                        "name": name,
                        "versions": {
                            "attack": "17",
                            "navigator": "5.1.0",
                            "layer": "4.5"
      },
      "domain": "enterprise-attack",
      "description": name,
      "techniques": mitreTags,
      "gradient": {
          "colors": [
            "#8ec843ff",
            "#ffe766ff",
            "#ff6666ff"
        ],
        "minValue": 0,
        "maxValue": 100
        },
        "legendItems": [],
        "metadata": [],
        "links": [],
        "showTacticRowBackground": false,
        "tacticRowBackground": "#dddddd",
        "selectTechniquesAcrossTactics": true,
        "selectSubtechniquesWithParent": false,
        "selectVisibleTechniques": false
    }

    let outputFile = open(output, FileMode.fmWrite)
    outputFile.write(jsonObj.pretty())
    let outputFileSize = getFileSize(outputFile)
    savedFiles = output & " (" & formatFileSize(outputFileSize) & ")"
    outputFile.close()
    if displayTable:
      echo ""
      echo "Saved file: " & savedFiles
  return savedFiles

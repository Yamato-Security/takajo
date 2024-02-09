type
  TTPResult = object
    techniqueID: string
    comment: string
    score: int

proc newTTPResult(techniqueID: string, comment: string, score: int): TTPResult =
  result.techniqueID = techniqueID
  result.comment = comment
  result.score = score

proc ttpVisualize(output: string = "mitre-attack-navigator.json", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    echo "Started the TTP Visualize command."
    echo "This command extracts TTPs and creates a JSON file to visualize in MITRE ATT&CK Navigator."
    echo ""

    echo "Counting total lines. Please wait."
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    var
        bar: SuruBar = initSuruBar()
        stackedMitreTags = initTable[string, string]()
        stackedMitreTagsCount = initTable[string, int]()

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        try:
            for tag in jsonLine["MitreTags"]:
                let techniqueID = tag.getStr()
                let ruleTitle = strip(jsonLine["RuleTitle"].getStr())
                if stackedMitreTags.hasKey(techniqueID) and ruleTitle notin stackedMitreTags[techniqueID]:
                    stackedMitreTags[techniqueID] = stackedMitreTags[techniqueID] & "," & ruleTitle
                    stackedMitreTagsCount[techniqueID] += 1
                else:
                    stackedMitreTags[techniqueID] = ruleTitle
                    stackedMitreTagsCount[techniqueID] = 1
        except CatchableError:
            continue

    bar.finish()
    echo ""
    if stackedMitreTags.len == 0:
        echo "No MITRE ATT&CK tags were found in the Hayabusa results."
        echo "Please run your Hayabusa scan with a profile that includes the %MitreTags% field. (ex: -p verbose)"
    else:
        var mitreTags = newSeq[TTPResult]()
        let maxCount = stackedMitreTagsCount.values.toSeq.max
        for techniqueID, ruleTitle in stackedMitreTags:
            let score = toInt(round(stackedMitreTagsCount[techniqueID]/maxCount * 100))
            mitreTags.add(newTTPResult(techniqueID, ruleTitle, score))
        let jsonObj = %* {
                            "name": "Hayabusa detection result heatmap",
                            "versions": {
                                "attack": "14",
                                "navigator": "4.9.1",
                                "layer": "4.5"
                            },
                            "domain": "enterprise-attack",
                            "description": "Hayabusa detection result heatmap",
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
        outputFile.close()
        echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"

    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
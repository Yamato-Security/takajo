proc ttpVisualizeSigma(output: string = "mitre-attack-navigator.json", quiet: bool = false, rulesDir: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.dirExists(rulesDir):
        echo "The dir '" & rulesDir & "' does not exist. Please specify a valid path."
        quit(1)

    echo "Started the TTP Visualize Sigma command."
    echo "This command extracts TTPs from Sigma rules and creates a JSON file to visualize the heatmap in MITRE ATT&CK Navigator."
    echo ""

    echo "Counting total rule files. Please wait."
    let yamlPathes = getYAMLpathes(rulesDir)
    echo "Total rule files: ", len(yamlPathes)
    echo ""

    var bar: SuruBar = initSuruBar()
    bar[0].total = len(yamlPathes)
    bar.setup()

    var stackedMitreTags = initTable[string, string]()
    var stackedMitreTagsCount = initTable[string, int]()
    let titleRegex = re"^title:\s*([^🛂]+)🛂"
    let attackRegex = re"^.*attack\.([a-zA-Z0-9\.]+)\s*🛂"
    for yaml in yamlPathes:
        inc bar
        bar.update(1000000000) # refresh every second
        let yaml_str = readFile(yaml).replace("\n", "🛂")
        var ruleTitle = ""
        if yaml_str =~ titleRegex:
            ruleTitle = matches[0]
        if yaml_str =~ attackRegex:
            for techniqueID in matches:
                if techniqueID.startsWith("t"):
                    let techniqueID = techniqueID.replace("t","T")
                    if stackedMitreTags.hasKey(techniqueID) and ruleTitle notin stackedMitreTags[techniqueID]:
                        stackedMitreTags[techniqueID] = stackedMitreTags[techniqueID] & "," & ruleTitle
                        stackedMitreTagsCount[techniqueID] += 1
                    else:
                        stackedMitreTags[techniqueID] = ruleTitle
                        stackedMitreTagsCount[techniqueID] = 1
    bar.finish()
    echo ""

    if stackedMitreTags.len == 0:
        echo "No MITRE ATT&CK tags were found in Simga reule's dir."
        echo "Please check the directory and try again."
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
                            "description": "Sigma rule heatmap",
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
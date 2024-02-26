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
    outputTTPResult(stackedMitreTags, stackedMitreTagsCount, output)
    outputElapsedTime(startTime)
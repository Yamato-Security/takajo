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
    echo "Total rule files: ", intToStr(len(yamlPathes)).insertSep(',')
    echo ""

    var bar: SuruBar = initSuruBar()
    bar[0].total = len(yamlPathes)
    bar.setup()

    var stackedMitreTags = initTable[string, string]()
    var stackedMitreTagsCount = initTable[string, int]()
    for yaml in yamlPathes:
        inc bar
        bar.update(1000000000) # refresh every second
        let yaml_str = readFile(yaml).replace("\n", "🛂")
        var ruleTitle = ""
        for line in yaml_str.split("🛂"):
            let stripped = line.strip()
            if stripped.startsWith("title:"):
                ruleTitle = stripped["title:".len..^1].strip()
                break
        for line in yaml_str.split("🛂"):
            let stripped = line.strip()
            let idx = stripped.find("attack.")
            if idx >= 0:
                let afterAttack = stripped[idx + "attack.".len..^1]
                let techniqueID = afterAttack.split({' ', '\t', ',', ']', '"', '\''})[0].strip()
                if techniqueID.startsWith("t"):
                    let techniqueID = techniqueID.replace("t","T")
                    if stackedMitreTags.hasKey(techniqueID) and ruleTitle notin stackedMitreTags[techniqueID]:
                        stackedMitreTags[techniqueID] = stackedMitreTags[techniqueID] & "," & ruleTitle
                        stackedMitreTagsCount[techniqueID] += 1
                    else:
                        stackedMitreTags[techniqueID] = ruleTitle
                        stackedMitreTagsCount[techniqueID] = 1
    bar.finish()
    let _ = outputTTPResult(stackedMitreTags, stackedMitreTagsCount, output, true, "Sigma rule heatmap")
    outputElapsedTime(startTime)
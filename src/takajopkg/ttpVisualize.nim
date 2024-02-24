proc ttpVisualize(output: string = "mitre-attack-navigator.json", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

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
    outputTTPResult(stackedMitreTags, stackedMitreTagsCount, output)
    outputElapsedTime(startTime)
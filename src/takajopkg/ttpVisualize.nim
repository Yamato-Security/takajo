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
                else:
                    stackedMitreTags[techniqueID] = ruleTitle
        except CatchableError:
            continue

    bar.finish()
    echo ""
    if stackedMitreTags.len == 0:
        echo "No MITRE ATT&CK tags were found in the Hayabusa results."
        echo "Please run your Hayabusa scan with a profile that includes the %MitreTags% field. (ex: -p verbose)"
    else:
        var mitreTags = newSeq[TableRef[string, string]]()
        for techniqueID, ruleTitle in stackedMitreTags:
            mitreTags.add({"techniqueID":  techniqueID, "comment": ruleTitle, "color": "#fd8d3c"}.newTable)
        let jsonObj = %* {
                            "name": "Hayabusa detection result heatmap",
                            "versions": {
                                "attack": "14",
                                "navigator": "4.9.1",
                                "layer": "4.5"
                            },
                            "domain": "enterprise-attack",
                            "description": "Hayabusa detection result heatmap",
                            "techniques": mitreTags
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
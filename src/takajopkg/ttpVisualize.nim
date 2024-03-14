const TTPVisualizeMsg = "This command extracts TTPs and creates a JSON file to visualize in MITRE ATT&CK Navigator."

type
  TTPVisualizeCmd* = ref object of AbstractCmd
    stackedMitreTags* = initTable[string, string]()
    stackedMitreTagsCount* = initTable[string, int]()

method analyze*(self: TTPVisualizeCmd, x: HayabusaJson) =
    try:
        for tag in x.MitreTags:
            let techniqueID = tag
            let ruleTitle = strip(x.RuleTitle)
            if self.stackedMitreTags.hasKey(techniqueID) and ruleTitle notin self.stackedMitreTags[techniqueID]:
                self.stackedMitreTags[techniqueID] = self.stackedMitreTags[techniqueID] & "," & ruleTitle
                self.stackedMitreTagsCount[techniqueID] += 1
            else:
                self.stackedMitreTags[techniqueID] = ruleTitle
                self.stackedMitreTagsCount[techniqueID] = 1
    except CatchableError:
        discard

method resultOutput*(self: TTPVisualizeCmd) =
    outputTTPResult(self.stackedMitreTags, self.stackedMitreTagsCount, self.output)

proc ttpVisualize(skipProgressBar:bool = false, output: string = "mitre-ttp-heatmap.json", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    let cmd = TTPVisualizeCmd(
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name:"TTP Visualize",
                msg: TTPVisualizeMsg)
    cmd.analyzeJSONLFile()
const TTPSummaryMsg = "This command outputs TTP summary."

proc readJsonFromFile(filename: string): JsonNode =
    var
        file: File
        content: string
    if file.open(filename):
        content = file.readAll()
        file.close()
        result = parseJson(content)

proc compareArrays(a, b: array[5, string]): int =
    for i in 0..<4:
        if a[i] < b[i]:
            return -1
        elif a[i] > b[i]:
            return 1
    return 0

type
  TTPSummaryCmd* = ref object of AbstractCmd
    seqOfResultsTables*: seq[array[5, string]]
    attack*: JsonNode
    tac_no* = {"Reconnaissance": "01. ",
               "Resource Development": "02. ",
               "Initial Access": "03. ",
               "Execution": "04. ",
               "Persistence": "05. ",
               "Privilege Escalation": "06. ",
               "Defense Evasion": "07. ",
               "Credential Access": "08. ",
               "Discovery": "09. ",
               "Lateral Movement": "10. ",
               "Collection": "11. ",
               "Exfiltration": "12. ",
               "Command and Control": "13. ",
               "Impact": "14. "}.toTable

method analyze*(self: TTPSummaryCmd, x: HayabusaJson) =
    try:
        let com = x.Computer
        for tag in x.MitreTags:
            if tag notin self.attack:
                continue
            let res = self.attack[tag]
            let dat = res["Tactic"].getStr()
            let tac = self.tac_no[dat] & dat
            let tec = res["Technique"].getStr()
            let sub = res["Sub-Technique"].getStr()
            let rul = x.RuleTitle
            self.seqOfResultsTables.add([com, tac, tec, sub, rul])
    except CatchableError:
        discard

method resultOutput*(self: TTPSummaryCmd) =
    self.seqOfResultsTables.sort(compareArrays)
    let header = ["Computer", "Tactic", "Technique", "Sub-Technique", "RuleTitle", "Count"]
    var prev = ["","","","",""]
    var count = 1
    var ruleStr = initHashSet[string]()
    if self.output != "":
        # Open file to save results
        var outputFile = open(self.output, fmWrite)

        ## Write CSV header
        outputFile.write(header.join(",") & "\p")

        ## Write contents
        for arr in self.seqOfResultsTables:
            ruleStr.incl(arr[4])
            if arr[0..<4] == prev[0..<4]:
                count += 1
                continue
            for i, val in enumerate(arr[0..<4]):
                outputFile.write(escapeCsvField(val) & ",")
            outputFile.write(escapeCsvField(ruleStr.mapIt($it).join(", ")) & ",")
            outputFile.write(escapeCsvField(intToStr(count)))
            prev = arr
            count = 1
            ruleStr = initHashSet[string]()
            outputFile.write("\p")
        outputFile.close()
        let fileSize = getFileSize(self.output)
        echo ""
        echo "Saved results to " & self.output & " (" & formatFileSize(fileSize) & ")"
    else:
        echo ""
        var table: TerminalTable
        table.add header
        for arr in self.seqOfResultsTables:
            ruleStr.incl(arr[4])
            if arr[0..<4] == prev[0..<4]:
                count += 1
                continue
            table.add arr[0], arr[1], arr[2], arr[3], ruleStr.mapIt($it).join(", "), intToStr(count)
            prev = arr
            count = 1
            ruleStr = initHashSet[string]()
        table.echoTableSepsWithStyled(seps = boxSeps)
    echo ""
    if self.seqOfResultsTables.len == 0:
        echo "No MITRE ATT&CK tags were found in the Hayabusa results."
        echo "Please run your Hayabusa scan with a profile that includes the %MitreTags% field. (ex: -p verbose)"

proc ttpSummary(skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    if not os.fileExists("mitre-attack.json"):
        echo "The file '" & "mitre-attack.json" & "' does not exist. Please specify a valid file path."
        quit(1)
    let cmd = TTPSummaryCmd(
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name:"TTP Summary",
                msg: TTPSummaryMsg)
    cmd.attack = readJsonFromFile("mitre-attack.json")
    cmd.analyzeJSONLFile()
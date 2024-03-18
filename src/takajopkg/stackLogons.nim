# TODO
# Output to stdout in tables (Target User, Target Computer, Logon Type, Source Computer)
# Remove local logins
const StackLogonsMsg = "This command will stack logons based on target user, target computer, source IP address and source computer from Security 4624 events.\nLocal source IP addresses are not included by default but can be enabled with -l, --localSrcIpAddresses."

type
  StackLogonsCmd* = ref object of AbstractCmd
      seqOfStrings*: seq[string]
      uniqueLogons = 0
      localSrcIpAddresses:bool

method filter*(self: StackLogonsCmd, x: HayabusaJson):bool =
    return isEID_4624(x.RuleTitle)

method analyze*(self: StackLogonsCmd, x: HayabusaJson) =
    let
      tgtUser = getJsonValue(x.Details, @["TgtUser"])
      tgtComp = x.Computer
      logonType = getJsonValue(x.Details, @["Type"])
      srcIP = getJsonValue(x.Details, @["SrcIP"])
      srcComp = getJsonValue(x.Details, @["SrcComp"])

    if not self.localSrcIpAddresses and isLocalIP(srcIP):
        discard
    else:
        self.seqOfStrings.add(tgtUser & "," & tgtComp & "," & logonType & "," & srcIP & "," & srcComp)

method resultOutput*(self: StackLogonsCmd) =
    var countsTable: Table[string, int] = initTable[string, int]()

    # Add a count for each time the unique string was found
    for string in self.seqOfStrings:
        if not countsTable.hasKey(string):
            countsTable[string] = 0
        countsTable[string] += 1

    # Create a sequence of pairs from the Table
    var seqOfPairs: seq[(string, int)] = @[]
    for key, val in countsTable:
        seqOfPairs.add((key, val))

    # Sort the sequence in descending order based on the count
    seqOfPairs.sort(proc (x, y: (string, int)): int = y[1] - x[1])

    # Print results to screen
    var outputFileSize = 0
    if self.output == "":
        # Print the sorted counts with unique strings
        for (string, count) in seqOfPairs:
            inc self.uniqueLogons
            var commaDelimitedStr = $count & "," & string
            commaDelimitedStr = replace(commaDelimitedStr, ",", " | ")
            echo commaDelimitedStr
    # Save to CSV file
    else:
        let outputFile = open(self.output, fmWrite)
        # Write headers
        writeLine(outputFile, "Count,TgtUser,TgtComp,LogonType,SrcIP,SrcComp")

        # Write results
        for (string, count) in seqOfPairs:
            inc self.uniqueLogons
            writeLine(outputFile, $count & "," & string)
        outputFileSize = getFileSize(outputFile)
        close(outputFile)
    let results = "Unique logons: " & $self.uniqueLogons
    let savedFiles = self.output & " (" & formatFileSize(outputFileSize) & ")"
    if self.displayTable:
        echo ""
        echo results
        echo "Saved file: " & savedFiles
    self.cmdResult = CmdResult(results:results, savedFiles:savedFiles)

proc stackLogons(localSrcIpAddresses = false, skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    let cmd = StackLogonsCmd(
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name:"stack-logons",
                msg: StackLogonsMsg,
                localSrcIpAddresses: localSrcIpAddresses)
    cmd.analyzeJSONLFile()
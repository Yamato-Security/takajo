const ListIpAddressesMsg =
    """
Inbound traffic is included by default but can be disabled with -i=false.
Outbound traffic is included by default but can be disabled with -O=false.
Private IP addresses are not included by default but can be enabled with -p."""

type
    ListIpAddressesCmd* = ref object of AbstractCmd
        ipHashSet* = initHashSet[string]()
        inbound*: bool
        outbound*: bool
        privateIp*: bool

method filter*(self: ListIpAddressesCmd, x: HayabusaJson): bool =
    return true

method analyze*(self: ListIpAddressesCmd, x: HayabusaJson) =
    if self.inbound:
        let ipAddress = getJsonValue(x.Details, @["SrcIP"])
        if (not isPrivateIP(ipAddress) or self.privateIp) and
            not isMulticast(ipAddress) and not isLoopback(ipAddress) and
                    ipAddress != "Unknown" and ipAddress != "-":
            self.ipHashSet.incl(ipAddress)

    # Search for events with a TgtIP field if outbound == true
    if self.outbound:
        let ipAddress = getJsonValue(x.Details, @["TgtIP"])
        if (not isPrivateIP(ipAddress) or self.privateIp) and
            not isMulticast(ipAddress) and not isLoopback(ipAddress) and
                    ipAddress != "Unknown" and ipAddress != "-":
            self.ipHashSet.incl(ipAddress)

method resultOutput*(self: ListIpAddressesCmd) =
    # Save results
    var outputFile = open(self.output, fmWrite)
    for ipAddress in self.ipHashSet:
        outputFile.write(ipAddress & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()
    let savedFiles = self.output & " (" & formatFileSize(outputFileSize) & ")"
    let results = "IP adddresses: " & intToStr(len(self.ipHashSet))
    if self.displayTable:
        echo ""
        echo "IP Addresss: ", intToStr(len(self.ipHashSet)).insertSep(',')
        echo "Saved file: " & savedFiles
    self.cmdResult = CmdResult(results: results, savedFiles: savedFiles)

proc listIpAddresses(inbound: bool = true, outbound: bool = true,
        skipProgressBar: bool = false, output: string, privateIp: bool = false,
        quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
    for timelinePath in filePaths:
        let cmd = ListIpAddressesCmd(
                    timeline: timelinePath,
                    output: output,
                    name: "list-ip-addresses",
                    msg: ListIpAddressesMsg,
                    inbound: inbound,
                    outbound: outbound,
                    privateIp: privateIp)
        cmd.analyzeJSONLFile()

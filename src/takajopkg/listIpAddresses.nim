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

method filter*(self: ListIpAddressesCmd, x: HayabusaJson):bool =
    var ipAddress = ""
    if self.inbound:
        ipAddress = getJsonValue(x.Details, @["SrcIP"])
    if self.outbound:
        ipAddress = getJsonValue(x.Details, @["TgtIP"])
    return (not isPrivateIP(ipAddress) or self.privateIp) and
            isMulticast(ipAddress) == false and isLoopback(ipAddress) == false and ipAddress != "Unknown" and ipAddress != "-"

method analyze*(self: ListIpAddressesCmd, x: HayabusaJson) =
    var ipAddress = ""
    if self.inbound:
        ipAddress = getJsonValue(x.Details, @["SrcIP"])
    if self.outbound:
        ipAddress = getJsonValue(x.Details, @["TgtIP"])
    self.ipHashSet.incl(ipAddress)

method resultOutput*(self: ListIpAddressesCmd) =
    # Save results
    var outputFile = open(self.output, fmWrite)
    for ipAddress in self.ipHashSet:
        outputFile.write(ipAddress & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()

    echo ""
    echo "IP Addresss: ", intToStr(len(self.ipHashSet)).insertSep(',')
    echo "Saved file: " & self.output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""

proc listIpAddresses(inbound: bool = true, outbound: bool = true, skipProgressBar:bool = false, output: string, privateIp: bool = false,  quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    let cmd = ListIpAddressesCmd(
                timeline: timeline,
                output: output,
                name:"List IpAddresses",
                msg: ListIpAddressesMsg,
                inbound: inbound,
                outbound: outbound,
                privateIp: privateIp)
    cmd.analyzeJSONLFile()
# TODO: List up domain info from DNS Server and Client events
# Graceful error when no domains loaded
const ListDomainsMsg =
  """
  Local queries to workstations are filtered out by default, but can be included with -w, --includeWorkstations.
  Sub-domains are also filtered out by default, but can be included with -s, --includeSubdomains.
  Domains ending with .lan, .LAN or .local are filtered out.
  """

type
  ListDomainsCmd* = ref object of AbstractCmd
      domainHashSet* = initHashSet[string]()
      includeSubdomains*: bool
      includeWorkstations*: bool

method filter*(self: ListDomainsCmd, x: HayabusaJson):bool =
    if not (x.Channel == "Sysmon" and x.EventId == 22):
        return false
    let domain = x.Details.extractStr("Query")
    return self.includeWorkstations or (domain.contains('.') and domain != "." and not domain.endsWith(".lan") and
      not domain.endsWith(".LAN") and not domain.endsWith(".local") and not isIpAddress(domain) and not domain.endsWith('.'))

method analyze*(self: ListDomainsCmd, x: HayabusaJson) =
    var domain = x.Details.extractStr("Query")
    if not self.includeSubdomains:
        domain = extractDomain(domain)
    self.domainHashSet.incl(domain)

method resultOutput*(self: ListDomainsCmd)=
    # Save results
    var outputFile = open(self.output, fmWrite)
    for domain in self.domainHashSet:
        outputFile.write(domain & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()

    echo ""
    echo "Domains: ", intToStr(len(self.domainHashSet)).insertSep(',')
    echo "Saved file: " & self.output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""

proc listDomains(includeSubdomains: bool = false, includeWorkstations: bool = false, skipProgressBar:bool = false, output: string, quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    let cmd = ListDomainsCmd(
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name:"List Domains",
                msg: ListDomainsMsg,
                includeSubdomains: includeSubdomains,
                includeWorkstations: includeWorkstations)
    cmd.analyzeJSONLFile()
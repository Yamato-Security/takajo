# TODO: List up domain info from DNS Server and Client events
# Graceful error when no domains loaded
proc listDomains(includeSubdomains: bool = false, includeWorkstations: bool = false, output: string, quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

    echo "Started the List Domains command"
    echo ""
    echo "Local queries to workstations are filtered out by default, but can be included with -w, --includeWorkstations."
    echo "Sub-domains are also filtered out by default, but can be included with -s, --includeSubdomains."
    echo "Domains ending with .lan, .LAN or .local are filtered out."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    echo "Extracting domain queries from Sysmon 22 events. Please wait."
    echo ""

    var
        domainHashSet = initHashSet[string]()
        bar: SuruBar = initSuruBar()

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000)
        let jsonLine:HayabusaJson = line.fromJson(HayabusaJson)
        let eventId = jsonLine.EventID
        let channel = jsonLine.Channel
        let details = jsonLine.Details
        # Found a Sysmon 22 DNS Query event
        if channel == "Sysmon" and eventId == 22:
            var domain = details.extractStr("Query")

            # If includeWorkstations is false, only add domain if it contains a period
            # Filter out ".", "*.lan" and "*.LAN"
            if includeWorkstations or (domain.contains('.') and domain != "." and not domain.endsWith(".lan") and not
                domain.endsWith(".LAN") and not domain.endsWith(".local") and not isIpAddress(domain) and not domain.endsWith('.')):

                # Do not include subdomains by default so strip the subdomains
                if not includeSubdomains:
                    domain = extractDomain(domain)
                domainHashSet.incl(domain)

    bar.finish()

    # Save results
    var outputFile = open(output, fmWrite)
    for domain in domainHashSet:
        outputFile.write(domain & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()

    echo ""
    echo "Domains: ", len(domainHashSet)
    echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""
    outputElapsedTime(startTime)
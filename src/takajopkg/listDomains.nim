# TODO: List up domain info from DNS Server and Client events
proc listDomains(includeSubdomains: bool = false, includeWorkstations: bool = false, output: string, quiet: bool = false, timeline: string) =

    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    var
        channel, domain = ""
        eventId = 0
        domainHashSet = initHashSet[string]()
        jsonLine: JsonNode

    for line in lines(timeline):
        jsonLine = parseJson(line)
        channel = jsonLine["Channel"].getStr()
        eventId = jsonLine["EventID"].getInt()

        # Found a Sysmon 22 DNS Query event
        if channel == "Sysmon" and eventId == 22:
            domain = jsonLine["Details"]["Query"].getStr()

            # If includeWorkstations is false, only add domain if it contains a period
            # Filter out ".", "*.lan" and "*.LAN"
            if includeWorkstations or (domain.contains('.') and domain != "." and not domain.endsWith(".lan") and not
                domain.endsWith(".LAN") and not isIpAddress(domain) and not domain.endsWith('.')):

                # Do not include subdomains by default so strip the subdomains
                if not includeSubdomains:
                    domain = extractDomain(domain)
                domainHashSet.incl(domain)

    # Save results
    var outputFile = open(output, fmWrite)
    for domain in domainHashSet:
        outputFile.write(domain & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()

    echo "Domains: ", len(domainHashSet)
    echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""
    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
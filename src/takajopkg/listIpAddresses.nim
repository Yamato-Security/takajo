proc listIpAddresses(inbound: bool = true, outbound: bool = true, output: string, privateIp: bool = false,  quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

    # Error if both inbound and outbound are set to false as there is nothing to search for.
    if inbound == false and outbound == false:
        echo "You must enable inbound and/or outbound searching."
        echo ""
        return

    echo "Started the List IP Addresses command"
    echo ""
    echo "Inbound traffic is included by default but can be disabled with -i=false."
    echo "Outbound traffic is included by default but can be disabled with -O=false."
    echo "Private IP addresses are not included by default but can be enabled with -p."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    echo "Extracting IP addresses from various logs. Please wait."
    echo ""

    var
        ipAddress = ""
        ipHashSet = initHashSet[string]()
        bar: SuruBar = initSuruBar()

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000)
        let jsonLine:HayabusaJson = line.fromJson(HayabusaJson)
        let eventId = jsonLine.EventID
        let channel = jsonLine.Channel

        # Search for events with a SrcIP field if inbound == true
        if inbound == true:
            ipAddress = getJsonValue(jsonLine.Details, @["SrcIP"])
            if (not isPrivateIP(ipAddress) or privateIp) and
                isMulticast(ipAddress) == false and isLoopback(ipAddress) == false and ipAddress != "Unknown" and ipAddress != "-":
                ipHashSet.incl(ipAddress)

        # Search for events with a TgtIP field if outbound == true
        if outbound == true:
                ipAddress = getJsonValue(jsonLine.Details, @["TgtIP"])
                if (not isPrivateIP(ipAddress) or privateIp) and
                    isMulticast(ipAddress) == false and isLoopback(ipAddress) == false and ipAddress != "Unknown" and ipAddress != "-":
                    ipHashSet.incl(ipAddress)
    bar.finish()

    # Save results
    var outputFile = open(output, fmWrite)
    for ipAddress in ipHashSet:
        outputFile.write(ipAddress & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()

    echo ""
    echo "IP Addresss: ", len(ipHashSet)
    echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""
    outputElapsedTime(startTime)
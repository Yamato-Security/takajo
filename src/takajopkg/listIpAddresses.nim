proc listIpAddresses(inbound: bool = true, outbound: bool = true, output: string, privateIp: bool = false,  quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    var
        channel, ipAddress = ""
        eventId = 0
        ipHashSet = initHashSet[string]()
        jsonLine: JsonNode

    # Error if both inbound and outbound are set to false as there is nothing to search for.
    if inbound == false and outbound == false:
        echo "You must enable inbound and/or outbound searching."
        echo ""
        return

    for line in lines(timeline):
        jsonLine = parseJson(line)
        channel = jsonLine["Channel"].getStr()
        eventId = jsonLine["EventID"].getInt()

        # Search for events with a SrcIP field if inbound == true
        # Found a Sysmon 3 Network Connection event
        if inbound == true:
            ipAddress = getJsonValue(jsonLine, @["Details", "SrcIP"])
            if (not isPrivateIP(ipAddress) or privateIp) and
                isMulticast(ipAddress) == false and isLoopback(ipAddress) == false and ipAddress != "Unknown" and ipAddress != "-":
                ipHashSet.incl(ipAddress)

        # Search for events with a TgtIP field if outbound == true
        # Sysmon 3 (Network Conn), Security 5156 (Win FW permitted conn), 5157 (Win FW blocked conn)
        if outbound == true:
                ipAddress = getJsonValue(jsonLine, @["Details", "TgtIP"])
                if (not isPrivateIP(ipAddress) or privateIp) and
                    isMulticast(ipAddress) == false and isLoopback(ipAddress) == false and ipAddress != "Unknown" and ipAddress != "-":
                    ipHashSet.incl(ipAddress)

    # Save results
    var outputFile = open(output, fmWrite)
    for ipAddress in ipHashSet:
        outputFile.write(ipAddress & "\p")
    let outputFileSize = getFileSize(outputFile)
    outputFile.close()

    echo "IP Addresss: ", len(ipHashSet)
    echo "Saved file: " & output & " (" & formatFileSize(outputFileSize) & ")"
    echo ""
    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
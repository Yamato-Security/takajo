proc isPrivateIP(ip: string): bool =
  let
    ipv4Private = re"^(10\.\d{1,3}\.\d{1,3}\.\d{1,3})$|^(192\.168\.\d{1,3}\.\d{1,3})$|^(172\.(1[6-9]|2\d|3[01])\.\d{1,3}\.\d{1,3})$|^(127\.\d{1,3}\.\d{1,3}\.\d{1,3})$"
    ipv6Private = re"^fd[0-9a-f]{2}:|^fe80:"

  if ip =~ ipv4Private or ip =~ ipv6Private:
    return true
  else:
    return false

proc isMulticast(address: string): bool =
    # Define regex for IPv4 multicast addresses
    let ipv4MulticastPattern = re"^(224\.0\.0\.0|22[5-9]\.|23[0-9]\.)"

    # Define regex for IPv6 multicast addresses
    let ipv6MulticastPattern = re"(?i)^ff[0-9a-f]{2}:"
    # check if the address matches either of the multicast patterns
    if address.find(ipv4MulticastPattern) >= 0 or address.find(ipv6MulticastPattern) >= 0:
        return true
    return false

proc isLoopback(address: string): bool =
    # Define regex for IPv4 loopback addresses
    let ipv4LoopbackPattern = re"^127\.0\.0\.1$"

    # Define regex for IPv6 loopback addresses
    let ipv6LoopbackPattern = re"^(?:0*:)*?:?0*1$"

    # Check if the address matches either of the loopback patterns
    if address.find(ipv4LoopbackPattern) >= 0 or address.find(ipv6LoopbackPattern) >= 0:
        return true
    return false

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

        # Found a Sysmon 3 Network Connection event
        if channel == "Sysmon" and eventId == 3:
            if inbound == true:
                ipAddress = jsonLine["Details"]["SrcIP"].getStr()
                if (not isPrivateIP(ipAddress) or privateIp) and
                    isMulticast(ipAddress) == false and isLoopback(ipAddress) == false:
                    ipHashSet.incl(ipAddress)
            if outbound == true:
                ipAddress = jsonLine["Details"]["TgtIP"].getStr()
                if (not isPrivateIP(ipAddress) or privateIp) and
                    isMulticast(ipAddress) == false and isLoopback(ipAddress) == false:
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
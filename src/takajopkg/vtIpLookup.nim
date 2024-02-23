# TODO: add SAN array info

var vtIpAddressChannel: Channel[VirusTotalResult] # channel for receiving parallel query results

proc queryIpAPI(ipAddress:string, headers: httpheaders.HttpHeaders) {.thread.} =
    let response = get("https://www.virustotal.com/api/v3/ip_addresses/" & ipAddress, headers)
    var jsonResponse = %* {}
    var singleResultTable = newTable[string, string]()
    var malicious = false
    singleResultTable["IP-Address"] = ipAddress
    singleResultTable["Link"] = "https://www.virustotal.com/gui/ip_addresses/" & ipAddress
    singleResultTable["Response"] = intToStr(response.code)
    if response.code == 200:
        jsonResponse = parseJson(response.body)

        # Parse values that need epoch time to human readable time
        singleResultTable["LastAnalysisDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_analysis_date"])
        singleResultTable["LastModifiedDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_modification_date"])
        singleResultTable["LastHTTPSCertDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_https_certificate_date"])
        singleResultTable["LastWhoisDate"] = getJsonDate(jsonResponse, @["data", "attributes", "whois_date"])

        # Parse simple data
        singleResultTable["MaliciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "malicious"])
        singleResultTable["HarmlessCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "harmless"])
        singleResultTable["SuspiciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "suspicious"])
        singleResultTable["UndetectedCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "undetected"])
        singleResultTable["CommunityVotesHarmless"] = getJsonValue(jsonResponse, @["data", "attributes", "total_votes", "harmless"])
        singleResultTable["CommunityVotesMalicious"] = getJsonValue(jsonResponse, @["data", "attributes", "total_votes", "malicious"])
        singleResultTable["Reputation"] = getJsonValue(jsonResponse, @["data", "attributes", "reputation"])
        singleResultTable["RegionalInternetRegistry"] = getJsonValue(jsonResponse, @["data", "attributes", "regional_internet_registry"])
        singleResultTable["WhoisInfo"] = getJsonValue(jsonResponse, @["data", "attributes", "whois"])
        singleResultTable["Network"] = getJsonValue(jsonResponse, @["data", "attributes", "network"])
        singleResultTable["Country"] = getJsonValue(jsonResponse, @["data", "attributes", "country"])
        singleResultTable["AS-Owner"] = getJsonValue(jsonResponse, @["data", "attributes", "as_owner"])
        singleResultTable["SSL-ValidAfter"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "validity", "not_before"])
        singleResultTable["SSL-ValidUntil"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "validity", "not_after"])
        singleResultTable["SSL-Issuer"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "issuer", "O"])
        singleResultTable["SSL-IssuerCountry"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "issuer", "C"])
        singleResultTable["SSL-CommonName"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "subject", "CN"])

    vtIpAddressChannel.send(VirusTotalResult(resTable:singleResultTable, resJson:jsonResponse,))


proc vtIpLookup(apiKey: string, ipList: string, jsonOutput: string = "", output: string, rateLimit: int = 4, quiet: bool = false) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not fileExists(ipList):
        echo "The file " & ipList & " does not exist."
        return

    echo "Started the VirusTotal IP Lookup command"
    echo ""
    echo "This command will lookup a list of IP addresses on VirusTotal."
    echo "Specify -j results.json to save the original JSON responses."
    echo "The default rate is 4 requests per minute so increase this if you have a premium membership."
    echo ""

    echo "Loading IP addresses. Please wait."
    echo ""

    let file = open(ipList)

    # Read each line into a sequence.
    var lines = newSeq[string]()
    for line in file.lines:
        lines.add(line)
    file.close()

    echo "Loaded IP addresses: ", len(lines)
    echo "Rate limit per minute: ", rateLimit
    echo ""

    let
        timePerRequest = 60.0 / float(rateLimit) # time taken for one request
        estimatedTimeInSeconds = float(len(lines)) * timePerRequest
        estimatedHours = int(estimatedTimeInSeconds) div 3600
        estimatedMinutes = (int(estimatedTimeInSeconds) mod 3600) div 60
        estimatedSeconds = int(estimatedTimeInSeconds) mod 60
    echo "Estimated time: ", $estimatedHours & " hours, " & $estimatedMinutes & " minutes, " & $estimatedSeconds & " seconds"
    echo ""

    var
        totalMaliciousIpAddressCount = 0
        bar: SuruBar = initSuruBar()
        seqOfResultsTables: seq[TableRef[string, string]]
        jsonResponses: seq[JsonNode]  # Declare sequence to store Json responses
        headers: httpheaders.HttpHeaders

    headers["x-apikey"] = apiKey
    bar[0].total = len(lines)
    bar.setup()
    vtIpAddressChannel.open()

    for ipAddress in lines:
        inc bar
        bar.update(1000000000) # refresh every second
        spawn queryIpAPI(ipAddress, headers) # run queries in parallel

        # Sleep to respect the rate limit.
        sleep(int(timePerRequest * 1000)) # Convert to milliseconds.

    for ipAddress in lines:
        let vtResult: VirusTotalResult = vtIpAddressChannel.recv() # get results of queries executed in parallel
        seqOfResultsTables.add(vtResult.resTable)
        jsonResponses.add(vtResult.resJson)
        if vtResult.resTable["Response"] == "200" and parseInt(vtResult.resTable["MaliciousCount"]) > 0:
          totalMaliciousIpAddressCount += 1

    sync()
    vtIpAddressChannel.close()
    bar.finish()

    echo ""
    echo "Finished querying IP addresses. " & intToStr(totalMaliciousIpAddressCount) & " Malicious IP addresses found."
    echo ""
    for table in seqOfResultsTables:
        if table["Response"] == "200":
            if parseInt(table["MaliciousCount"]) > 0:
                echo "Found malicious IP address: " & table["IP-Address"] & " (Malicious count: " & table["MaliciousCount"] & ")"
        elif table["Response"] == "404":
            echo "IP address not found: ", table["IP-Address"]
        else:
            echo "Unknown error: ", table["Response"], " - " & table["IP-Address"]

    let header = @["Response", "IP-Address", "SSL-CommonName", "SSL-IssuerCountry", "LastAnalysisDate", "LastModifiedDate", "LastHTTPSCertDate", "LastWhoisDate", "MaliciousCount", "HarmlessCount",
        "SuspiciousCount", "UndetectedCount", "CommunityVotesHarmless", "CommunityVotesMalicious", "Reputation", "RegionalInternetRegistry",
        "Network", "Country", "AS-Owner", "SSL-ValidAfter", "SSL-ValidUntil", "SSL-Issuer", "WhoisInfo", "Link"]
    outputVtCmdResult(output, header, seqOfResultsTables, jsonOutput, jsonResponses)
    outputElapsedTime(startTime)
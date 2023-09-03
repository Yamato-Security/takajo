# TODO:
# Handle OSError exception when the network gets disconnected while running
# Add categories and SAN info
# Add output not found to txt file

var vtAPIDomainChannel: Channel[VirusTotalResult] # channel for receiving parallel query results

proc queryDomainAPI(domain:string, headers: httpheaders.HttpHeaders) {.thread.} =
    let response = get("https://www.virustotal.com/api/v3/domains/" & encodeUrl(domain), headers)
    let jsonResponse = parseJson(response.body)
    var singleResultTable = newTable[string, string]()
    var malicious = false
    singleResultTable["Domain"] = domain
    singleResultTable["Link"] = "https://www.virustotal.com/gui/domain/" & domain
    if response.code == 200:
        singleResultTable["Response"] = "200"
        # Parse values that need epoch time to human readable time
        singleResultTable["CreationDate"] = getJsonDate(jsonResponse, @["data", "attributes", "creation_date"])
        singleResultTable["LastAnalysisDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_analysis_date"])
        singleResultTable["LastModifiedDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_modification_date"])
        singleResultTable["LastWhoisDate"] = getJsonDate(jsonResponse, @["data", "attributes", "whois_date"])

        # Parse simple data
        singleResultTable["MaliciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "malicious"])
        singleResultTable["HarmlessCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "harmless"])
        singleResultTable["SuspiciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "suspicious"])
        singleResultTable["UndetectedCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "undetected"])
        singleResultTable["CommunityVotesHarmless"] = getJsonValue(jsonResponse, @["data", "attributes", "total_votes", "harmless"])
        singleResultTable["CommunityVotesMalicious"] = getJsonValue(jsonResponse, @["data", "attributes", "total_votes", "malicious"])
        singleResultTable["Reputation"] = getJsonValue(jsonResponse, @["data", "attributes", "reputation"])
        singleResultTable["Registrar"] = getJsonValue(jsonResponse, @["data", "attributes", "registrar"])
        singleResultTable["WhoisInfo"] = getJsonValue(jsonResponse, @["data", "attributes", "whois"])
        singleResultTable["SSL-ValidAfter"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "not_before"])
        singleResultTable["SSL-ValidUntil"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "not_after"])
        singleResultTable["SSL-Issuer"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "issuer", "O"])
        singleResultTable["SSL-IssuerCountry"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "issuer", "C"])

        # If it was found to be malicious, print to screen an alert
        if parseInt(singleResultTable["MaliciousCount"]) > 0:
            malicious = true
            echo "\pFound malicious domain: " & domain & " (Malicious count: " & singleResultTable["MaliciousCount"] & " )"

    # If we get a 404 not found
    elif response.code == 404:
        echo "\pDomain not found: ", domain
        singleResultTable["Response"] = "404"
    else:
        echo "\pUnknown error: ", intToStr(response.code), " - " & domain
        singleResultTable["Response"] = intToStr(response.code)

    vtAPIDomainChannel.send(VirusTotalResult(resTable:singleResultTable, resJson:jsonResponse, isMalicious:malicious))


proc vtDomainLookup(apiKey: string, domainList: string, jsonOutput: string = "", output: string, rateLimit: int = 4, quiet: bool = false) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not fileExists(domainList):
        echo "The file " & domainList & " does not exist."
        return

    echo "Started the VirusTotal Domain Lookup command"
    echo ""
    echo "This command will lookup a list of domains on VirusTotal."
    echo "Specify -j results.json to save the original JSON responses."
    echo "The default rate is 4 requests per minute so increase this if you have a premium membership."
    echo ""

    echo "Loading domains. Please wait."
    echo ""

    let file = open(domainList)
    # Read each line into a sequence.
    var lines = newSeq[string]()
    for line in file.lines:
        lines.add(line)
    file.close()

    echo "Loaded domains: ", len(lines)
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
        totalMaliciousDomainCount = 0
        bar: SuruBar = initSuruBar()
        seqOfResultsTables: seq[TableRef[string, string]]
        jsonResponses: seq[JsonNode]  # Declare sequence to store Json responses
        headers: httpheaders.HttpHeaders

    headers["x-apikey"] = apiKey
    bar[0].total = len(lines)
    bar.setup()
    vtAPIDomainChannel.open()

    for domain in lines:
        inc bar
        bar.update(1000000000) # refresh every second
        spawn queryDomainAPI(domain, headers) # run queries in parallel

        # Sleep to respect the rate limit.
        sleep(int(timePerRequest * 1000)) # Convert to milliseconds.

    for domain in lines:
        let vtResult: VirusTotalResult = vtAPIDomainChannel.recv() # get results of queries executed in parallel
        seqOfResultsTables.add(vtResult.resTable)
        jsonResponses.add(vtResult.resJson)
        if vtResult.isMalicious:
          totalMaliciousDomainCount += 1

    sync()
    vtAPIDomainChannel.close()

    bar.finish()

    echo ""
    echo "Finished querying domains"
    echo "Malicious domains found: ", totalMaliciousDomainCount
    # Print elapsed time

    # If saving to a file
    if output != "":
        var outputFile = open(output, fmWrite)
        let header = ["Response", "Domain", "CreationDate", "LastAnalysisDate", "LastModifiedDate", "LastWhoisDate", "MaliciousCount", "HarmlessCount",
            "SuspiciousCount", "UndetectedCount", "CommunityVotesHarmless", "CommunityVotesMalicious", "Reputation", "Registrar", "WhoisInfo",
            "SSL-ValidAfter", "SSL-ValidUntil", "SSL-Issuer", "SSL-IssuerCountry", "Link"]

        ## Write CSV header
        for h in header:
            outputFile.write(h & ",")
        outputFile.write("\p")

        ## Write contents
        for table in seqOfResultsTables:
            for key in header:
                if table.hasKey(key):
                    outputFile.write(escapeCsvField(table[key]) & ",")
                else:
                    outputFile.write(",")
            outputFile.write("\p")
        let fileSize = getFileSize(output)
        outputFile.close()

        echo "Saved CSV results to " & output & " (" & formatFileSize(fileSize) & ")"

    # After the for loop, check if jsonOutput is not blank and then write the JSON responses to a file
    if jsonOutput != "":
        var jsonOutputFile = open(jsonOutput, fmWrite)
        let jsonArray = newJArray() # create empty JSON array
        for jsonResponse in jsonResponses: # iterate over jsonResponse sequence
            jsonArray.add(jsonResponse) # add each jsonResponse to jsonArray
        jsonOutputFile.write(jsonArray.pretty)
        jsonOutputFile.close()
        let fileSize = getFileSize(jsonOutput)
        echo "Saved JSON responses to " & jsonOutput & " (" & formatFileSize(fileSize) & ")"

    # Print elapsed time
    echo ""
    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
# TODO:
# Handle OSError exception when the network gets disconnected while running
# Add categories and SAN info
# Add output not found to txt file

proc queryDomainAPI(domain:string, headers: httpheaders.HttpHeaders, results: ptr seq[VirusTotalResult]; L: ptr TicketLock) =
    let response = get("https://www.virustotal.com/api/v3/domains/" & encodeUrl(domain), headers)
    var jsonResponse = %* {}
    var singleResultTable = newTable[string, string]()
    singleResultTable["Domain"] = domain
    singleResultTable["Link"] = "https://www.virustotal.com/gui/domain/" & domain
    singleResultTable["Response"] = intToStr(response.code)
    if response.code == 200:
        jsonResponse = parseJson(response.body)
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
    withLock L[]:
          results[].add VirusTotalResult(resTable:singleResultTable, resJson:jsonResponse)


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
    var m = createMaster()
    var results = newSeq[VirusTotalResult]()
    var L = initTicketLock() # protects `results`
    m.awaitAll:
      for i, domain in lines:
          inc bar
          bar.update(1000000000) # refresh every second
          m.spawn queryDomainAPI(domain, headers, addr results, addr L) # run queries in parallel
          # Sleep to respect the rate limit.
          if i < len(lines) - 1:
            sleep(int(timePerRequest * 1000)) # Convert to milliseconds.

    for r in results:
        seqOfResultsTables.add(r.resTable)
        jsonResponses.add(r.resJson)
        if r.resTable["Response"] == "200" and parseInt(r.resTable["MaliciousCount"]) > 0:
          totalMaliciousDomainCount += 1
    bar.finish()

    echo ""
    echo "Finished querying domains. " & intToStr(totalMaliciousDomainCount) & " Malicious domains found."
    echo ""
    for table in seqOfResultsTables:
        if table["Response"] == "200":
            if parseInt(table["MaliciousCount"]) > 0:
                echo "Found malicious domains: " & table["Domain"] & " (Malicious count: " & table["MaliciousCount"] & ")"
        elif table["Response"] == "404":
            echo "Domain not found: ", table["Domain"]
        else:
            echo "Unknown error: ", table["Response"], " - " & table["Domain"]

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
        echo ""
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
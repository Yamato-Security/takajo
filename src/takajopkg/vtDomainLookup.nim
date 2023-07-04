proc getJsonValue(jsonResponse: JsonNode, keys: seq[string], default: string = "Unknown"): string =
    var value = jsonResponse
    for key in keys:
        try:
            value = value[key]
        except KeyError:
            return default
    # Check if the value is an integer or a string
    if value.kind == JInt:
        return $value.getInt()  # Convert to string
    elif value.kind == JString:
        return value.getStr()
    else:
        return default  # If it's neither a string nor an integer, return default

proc getJsonDate(jsonResponse: JsonNode, keys: seq[string]): string =
    try:
        var node = jsonResponse
        for key in keys:
            node = node[key]
        let epochDate = fromUnix(node.getInt()).utc
        return epochDate.format("yyyy-MM-dd HH:mm:ss")
    except KeyError:
        return "Unknown"

# TODO:
# Make asynchronous
# Handle OSError exception when the network gets disconnected while running
# Add categories and SAN info
# Add output not found to txt file
proc vtDomainLookup(apiKey: string, domainList: string, jsonOutput: string = "", output: string, rateLimit: int = 4, quiet: bool = false) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not fileExists(domainList):
        echo "The file " & domainList & " does not exist."
        return

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

    let client = newHttpClient()
    client.headers = newHttpHeaders({ "x-apikey": apiKey })

    var
        totalMaliciousDomainCount = 0
        bar = newProgressBar(total = len(lines))
        seqOfResultsTables: seq[TableRef[string, string]]
        jsonResponses: seq[JsonNode]  # Declare sequence to store Json responses

    bar.start()

    for domain in lines:
        bar.increment()
        let response = client.request("https://www.virustotal.com/api/v3/domains/" & domain, httpMethod = HttpGet)
        var singleResultTable = newTable[string, string]()
        singleResultTable["Domain"] = domain
        singleResultTable["Link"] = "https://www.virustotal.com/gui/domain/" & domain
        if response.status == $Http200:
            singleResultTable["Response"] = "200"
            let jsonResponse = parseJson(response.body)
            jsonResponses.add(jsonResponse)

            # Parse values that need epoch time to human readable time
            singleResultTable["CreationDate"] = getJsonDate(jsonResponse, @["data", "attributes", "creation_date"])
            singleResultTable["LastAnalysisDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_analysis_date"])
            singleResultTable["LastModifiedDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_modification_date"])
            singleResultTable["LastWhoisDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_submission_date"])

            # Parse simple data
            singleResultTable["MaliciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "malicious"])
            singleResultTable["HarmlessCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "harmless"])
            singleResultTable["SuspiciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "suspicious"])
            singleResultTable["UndetectedCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "undetected"])
            singleResultTable["Reputation"] = getJsonValue(jsonResponse, @["data", "attributes", "reputation"])
            singleResultTable["Registrar"] = getJsonValue(jsonResponse, @["data", "attributes", "registrar"])
            singleResultTable["WhoisInfo"] = getJsonValue(jsonResponse, @["data", "attributes", "whois"])
            singleResultTable["CommunityVotesHarmless"] = getJsonValue(jsonResponse, @["data", "attributes", "total_votes", "harmless"])
            singleResultTable["CommunityVotesMalicious"] = getJsonValue(jsonResponse, @["data", "attributes", "total_votes", "malicious"])
            singleResultTable["SSL-ValidAfter"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "not_before"])
            singleResultTable["SSL-ValidUntil"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "not_after"])
            singleResultTable["SSL-Issuer"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "issuer", "O"])
            singleResultTable["SSL-IssuerCountry"] = getJsonValue(jsonResponse, @["data", "attributes", "last_https_certificate", "issuer", "C"])

            # If it was found to be malicious
            if parseInt(singleResultTable["MaliciousCount"]) > 0:
                inc totalMaliciousDomainCount
                echo "\pFound malicious domain: " & domain & " (Malicious count: " & singleResultTable["MaliciousCount"] & " )"

        # If we get a 404 not found
        elif response.status == $Http404:
            echo "\pDomain not found: ", domain
            singleResultTable["Response"] = "404"
        else:
            echo "\pUnknown error: ", response.status, " - " & domain
            singleResultTable["Response"] = response.status

        seqOfResultsTables.add(singleResultTable)

        # Sleep to respect the rate limit.
        sleep(int(timePerRequest * 1000)) # Convert to milliseconds.

    bar.finish()

    echo ""
    echo "Finished querying domains"
    echo "Malicious domains found: ", totalMaliciousDomainCount
    # Print elapsed time

    # If saving to a file
    if output != "":
        var outputFile = open(output, fmWrite)
        let header = ["Domain", "Response", "LastAnalysisDate", "LastModifiedDate", "LastWhoisDate", "MaliciousCount", "HarmlessCount",
            "SuspiciousCount", "UndetectedCount", "CommunityVotesHarmless", "CommunityVotesMalicious", "Reputation", "Registrar",
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
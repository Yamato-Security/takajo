# TODO: add more info useful for triage, trusted_verdict, signature info, sandbox results etc...
# https://blog.virustotal.com/2021/08/introducing-known-distributors.html
# Add output not found to txt file

var vtAPIHashChannel: Channel[VirusTotalResult] # channel for receiving parallel query results

proc queryHashAPI(hash:string, headers: httpheaders.HttpHeaders) {.thread.} =
    let response = get("https://www.virustotal.com/api/v3/files/" & hash, headers)
    var jsonResponse = %* {}
    var singleResultTable = newTable[string, string]()
    var malicious = false
    singleResultTable["Hash"] = hash
    singleResultTable["Link"] = "https://www.virustotal.com/gui/file/" & hash
    singleResultTable["Response"] = intToStr(response.code)
    if response.code == 200:
        jsonResponse = parseJson(response.body)
        # Parse values that need epoch time to human readable time
        singleResultTable["CreationDate"] = getJsonDate(jsonResponse, @["data", "attributes", "creation_date"])
        singleResultTable["FirstInTheWildDate"] = getJsonDate(jsonResponse, @["data", "attributes", "first_seen_itw_date"])
        singleResultTable["FirstSubmissionDate"] = getJsonDate(jsonResponse, @["data", "attributes", "first_submission_date"])
        singleResultTable["LastSubmissionDate"] = getJsonDate(jsonResponse, @["data", "attributes", "last_submission_date"])

        # Parse simple data
        singleResultTable["MaliciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "malicious"])
        singleResultTable["HarmlessCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "harmless"])
        singleResultTable["SuspiciousCount"] = getJsonValue(jsonResponse, @["data", "attributes", "last_analysis_stats", "suspicious"])

    vtAPIHashChannel.send(VirusTotalResult(resTable:singleResultTable, resJson:jsonResponse))


proc vtHashLookup(apiKey: string, hashList: string, jsonOutput: string = "", output: string = "", rateLimit: int = 4, quiet: bool = false) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not fileExists(hashList):
        echo "The file " & hashList & " does not exist."
        return

    echo "Started the VirusTotal Hash Lookup command"
    echo ""
    echo "This command will lookup a list of file hashes on VirusTotal."
    echo "Specify -j results.json to save the original JSON responses."
    echo "The default rate is 4 requests per minute so increase this if you have a premium membership."
    echo ""

    echo "Loading hashes. Please wait."
    echo ""

    let lines = readFile(hashList).splitLines()

    echo "Loaded hashes: ", len(lines)
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
        totalMaliciousHashCount = 0
        bar: SuruBar = initSuruBar()
        seqOfResultsTables: seq[TableRef[string, string]]
        jsonResponses: seq[JsonNode]  # Declare sequence to store Json responses
        headers: httpheaders.HttpHeaders

    headers["x-apikey"] = apiKey
    bar[0].total = len(lines)
    bar.setup()
    vtAPIHashChannel.open()

    for hash in lines:
        inc bar
        bar.update(1000000000) # refresh every second
        spawn queryHashAPI(hash, headers) # run queries in parallel

        # Sleep to respect the rate limit.
        sleep(int(timePerRequest * 1000)) # Convert to milliseconds.

    for hash in lines:
        let vtResult: VirusTotalResult = vtAPIHashChannel.recv() # get results of queries executed in parallel
        seqOfResultsTables.add(vtResult.resTable)
        jsonResponses.add(vtResult.resJson)
        if vtResult.resTable["Response"] == "200" and parseInt(vtResult.resTable["MaliciousCount"]) > 0:
          totalMaliciousHashCount += 1

    sync()
    vtAPIHashChannel.close()
    bar.finish()

    echo ""
    echo "Finished querying hashes. " & intToStr(totalMaliciousHashCount) & " Malicious hashes found."
    echo ""
    for table in seqOfResultsTables:
        if table["Response"] == "200":
            if parseInt(table["MaliciousCount"]) > 0:
                echo "Found malicious hashes: " & table["Hash"] & " (Malicious count: " & table["MaliciousCount"] & ")"
        elif table["Response"] == "404":
            echo "Hash not found: ", table["Hash"]
        else:
            echo "Unknown error: ", table["Response"], " - " & table["Hash"]

    let header = @["Response", "Hash", "FirstInTheWildDate", "FirstSubmissionDate", "LastSubmissionDate", "MaliciousCount", "HarmlessCount", "SuspiciousCount", "Link"]
    outputVtCmdResult(output, header, seqOfResultsTables, jsonOutput, jsonResponses)
    outputElapsedTime(startTime)
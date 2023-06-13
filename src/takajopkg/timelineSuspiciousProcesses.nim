proc timelineSuspiciousProcesses(level: string = "high", output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if level != "critical" and level != "high" and level != "medium" and level != "low" and level != "informational":
        echo "You must specify a minimum level of critical, high, medium, low or informational. (default: high)"
        echo ""
        return

    if level == "critical":
        echo "Scanning for processes with an alert level of critical"
    else:
        echo "Scanning for processes with a minimal alert level of " & level
    echo ""

    var
        seqOfResultsTables: seq[Table[string, string]]
        suspicousProcessCount_Sec_4688, suspicousProcessCount_Sysmon_1, eventId,pidInt = 0
        channel, cmdLine, company, computer, description, eventLevel, eventType, hashes, hash_MD5, hash_SHA1, hash_SHA256, hash_IMPHASH,
            lid, lguid, ruleAuthor,ruleTitle, parentCmdline,
            parentGuid, parentPid, pidStr, process, processGuid, product, timestamp, user = ""
        jsonLine: JsonNode

    for line in lines(timeline):

        jsonLine = parseJson(line)
        channel = jsonLine["Channel"].getStr()
        eventId = jsonLine["EventID"].getInt()
        eventLevel = jsonLine["Level"].getStr()

        # Found a Security 4688 process creation event
        if channel == "Sec" and eventId == 4688 and isMinLevel(eventLevel, level) == true:
            inc suspicousProcessCount_Sec_4688
            try:
                cmdLine = jsonLine["Details"]["Cmdline"].getStr()
            except KeyError:
                cmdLine = ""
            eventType = "Security 4688"
            timestamp = jsonLine["Timestamp"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
            computer = jsonLine["Computer"].getStr()
            process = jsonLine["Details"]["Proc"].getStr()
            pidStr = jsonLine["Details"]["PID"].getStr()
            pidStr = intToStr(fromHex[int](pidStr))
            user = jsonLine["Details"]["User"].getStr()
            lid = jsonLine["Details"]["LID"].getStr()
            try:
                ruleAuthor = jsonLine["RuleAuthor"].getStr()
            except KeyError:
                ruleAuthor = ""

            if output == "": # Output to screen
                echo "Timestamp: " & timestamp
                echo "Computer: " & computer
                echo "Type: " & eventType
                echo "Level: " & eventLevel
                echo "Rule: " & ruleTitle
                echo "RuleAuthor: " & ruleAuthor
                echo "Cmdline: " & cmdLine
                echo "Process: " & process
                echo "PID: " & pidStr
                echo "User: " & user
                echo "LID: " & lid
                echo ""
            else: # Add records to seqOfResultsTables to eventually save to file.
                var singleResultTable = initTable[string, string]()
                singleResultTable["Timestamp"] = timestamp
                singleResultTable["Computer"] = computer
                singleResultTable["Type"] = eventType
                singleResultTable["Level"] = eventLevel
                singleResultTable["Rule"] = ruleTitle
                singleResultTable["RuleAuthor"] = ruleAuthor
                singleResultTable["Cmdline"] = cmdLine
                singleResultTable["Process"] = process
                singleResultTable["PID"] = pidStr
                singleResultTable["User"] = user
                singleResultTable["LID"] = lid
                seqOfResultsTables.add(singleResultTable)

        # Found a Sysmon 1 process creation event
        if channel == "Sysmon" and eventId == 1 and isMinLevel(eventLevel, level) == true:
            inc suspicousProcessCount_Sysmon_1
            cmdLine = jsonLine["Details"]["Cmdline"].getStr()
            eventType = "Sysmon 1"
            timestamp = jsonLine["Timestamp"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
            computer = jsonLine["Computer"].getStr()
            process = jsonLine["Details"]["Proc"].getStr()
            pidInt = jsonLine["Details"]["PID"].getInt()
            user = jsonLine["Details"]["User"].getStr()
            lid = jsonLine["Details"]["LID"].getStr()
            lguid = jsonLine["Details"]["LGUID"].getStr()
            processGuid = jsonLine["Details"]["PGUID"].getStr()
            parentCmdline = jsonLine["Details"]["ParentCmdline"].getStr()
            parentPid = $jsonLine["Details"]["ParentPID"].getInt()
            parentGuid = jsonLine["Details"]["ParentPGUID"].getStr()
            description = jsonLine["Details"]["Description"].getStr()
            product = jsonLine["Details"]["Product"].getStr()
            company = jsonLine["Details"]["Company"].getStr()
            try:
                ruleAuthor = jsonLine["RuleAuthor"].getStr()
            except KeyError:
                ruleAuthor = ""
            try:
                hashes = jsonLine["Details"]["Hashes"].getStr() # Hashes are not enabled by default so this field may not exist.
                let pairs = hashes.split(",")  # Split the string into key-value pairs. Ex: MD5=DE9C75F34F47B60A71BBA03760F0579E,SHA256=12F06D3B1601004DB3F7F1A07E7D3AF4CC838E890E0FF50C51E4A0C9366719ED,IMPHASH=336674CB3C8337BDE2C22255345BFF43
                for pair in pairs:
                    let keyVal = pair.split("=")
                    case keyVal[0]:
                    of "MD5":
                        hash_MD5 = keyVal[1]
                    of "SHA1":
                        hash_SHA1 = keyVal[1]
                    of "SHA256":
                        hash_SHA256 = keyVal[1]
                    of "IMPHASH":
                        hash_IMPHASH = keyVal[1]
            except KeyError:
                hashes = ""
                hash_MD5 = ""
                hash_SHA1 = ""
                hash_SHA256 = ""
                hash_IMPHASH = ""

            if output == "": # Output to screen
                echo "Timestamp: " & timestamp
                echo "Computer: " & computer
                echo "Type: " & eventType
                echo "Level: " & eventLevel
                echo "Rule: " & ruleTitle
                echo "RuleAuthor: " & ruleAuthor
                echo "Cmdline: " & cmdLine
                echo "Process: " & process
                echo "PID: " & $pidInt
                echo "User: " & user
                echo "LID: " & lid
                echo "LGUID: " & lguid
                echo "ProcessGUID: " & processGuid
                echo "ParentCmdline: " & parentCmdline
                echo "ParentPID: " & parentPid
                echo "ParentGUID: " & parentGuid
                echo "Description: " & description
                echo "Product: " & product
                echo "Company: " & company
                echo "MD5 Hash: " & hash_MD5
                echo "SHA1 Hash: " & hash_SHA1
                echo "SHA256 Hash: " & hash_SHA256
                echo "Import Hash: " & hash_IMPHASH
                echo ""
            else: # Add records to seqOfResultsTables to eventually save to file.
                var singleResultTable = initTable[string, string]()
                singleResultTable["Timestamp"] = timestamp
                singleResultTable["Computer"] = computer
                singleResultTable["Type"] = eventType
                singleResultTable["Level"] = eventLevel
                singleResultTable["Rule"] = ruleTitle
                singleResultTable["RuleAuthor"] = ruleAuthor
                singleResultTable["Cmdline"] = cmdLine
                singleResultTable["Process"] = process
                singleResultTable["PID"] = pidStr
                singleResultTable["User"] = user
                singleResultTable["LID"] = lid
                singleResultTable["LGUID"] = lguid
                singleResultTable["ProcessGUID"] = processGuid
                singleResultTable["ParentCmdline"] = parentCmdline
                singleResultTable["ParentPID"] = parentPid
                singleResultTable["ParentGUID"] = parentGuid
                singleResultTable["Description"] = description
                singleResultTable["Product"] = product
                singleResultTable["Company"] = company
                singleResultTable["MD5 Hash"] = hash_MD5
                singleResultTable["SHA1 Hash"] = hash_SHA1
                singleResultTable["SHA256 Hash"] = hash_SHA256
                singleResultTable["Import Hash"] = hash_IMPHASH
                seqOfResultsTables.add(singleResultTable)


    if output != "" and suspicousProcessCount_Sec_4688 != 0 and suspicousProcessCount_Sysmon_1 != 0: # Save results to CSV
        # Open file to save results
        var outputFile = open(output, fmWrite)
        let header = ["Timestamp", "Computer", "Type", "Level", "Rule", "RuleAuthor", "Cmdline", "Process", "PID", "User", "LID", "LGUID", "ProcessGUID", "ParentCmdline", "ParentPID", "ParentPGUID", "Description", "Product", "Company", "MD5 Hash", "SHA1 Hash", "SHA256 Hash", "Import Hash"]

        ## Write CSV header
        outputFile.write(header.join(",") & "\p")

        ## Write contents
        for table in seqOfResultsTables:
            for key in header:
                if table.hasKey(key):
                    outputFile.write(escapeCsvField(table[key]) & ",")
                else:
                    outputFile.write(",")
            outputFile.write("\p")
        outputFile.close()
        let fileSize = getFileSize(output)

        echo "Saved results to " & output & " (" & formatFileSize(fileSize) & ")"
        echo ""

    if suspicousProcessCount_Sec_4688 == 0 and suspicousProcessCount_Sysmon_1 == 0:
        echo "No suspicous processes were found. There are either no malicious processes or you need to change the level."
        echo ""
        return

    echo "Suspicous processes in Security 4688 process creation events: " & $suspicousProcessCount_Sec_4688
    echo "Suspicious processes in Sysmon 1 process creation events: " & $suspicousProcessCount_Sysmon_1
    echo ""
    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
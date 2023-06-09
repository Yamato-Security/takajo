proc formatDuration(d: Duration): string =
    let days = d.inDays
    let hours = d.inHours mod 24
    let minutes = d.inMinutes mod 60
    let seconds = d.inSeconds mod 60
    let milliseconds = d.inMilliseconds mod 1000
    return $days & "d " & $hours & "h " & $minutes & "m " & $seconds & "s " & $milliseconds & "ms"

proc extractStr(jsonObj: JsonNode, key: string): string =
    let value = jsonObj.hasKey(key)
    if value and jsonObj[key].kind == JString:
        return jsonObj[key].getStr()
    else:
        return ""

proc extractInt(jsonObj: JsonNode, key: string): int =
    if jsonObj.hasKey(key) and jsonObj[key].kind == JInt:
        return jsonObj[key].getInt()
    else:
        return -1

proc logonNumberToString(msgLogonType: int): string =
    case msgLogonType:
        of 0: result = "0 - System"
        of 2: result = "2 - Interactive"
        of 3: result = "3 - Network"
        of 4: result = "4 - Batch"
        of 5: result = "5 - Service"
        of 7: result = "7 - Unlock"
        of 8: result = "8 - NetworkCleartext"
        of 9: result = "9 - NewCredentials"
        of 10: result = "10 - RemoteInteractive"
        of 11: result = "11 - CachedInteractive"
        of 12: result = "12 - CachedRemoteInteractive"
        of 13: result = "13 - CachedUnlock"
        else: result = "Unknown - " & $msgLogonType
    return result

proc isEID_4624(msgLogonRule: string): bool =
    case msgLogonRule
    of
        "Logon (System) - Bootup", "Logon (Interactive) *Creds in memory*",
        "Logon (Network)", "Logon (Batch)", "Logon (Service)",
        "Logon (Unlock)", "Logon (NetworkCleartext)",
        "Logon (NewCredentials) *Creds in memory*",
        "Logon (RemoteInteractive (RDP)) *Creds in memory*",
        "Logon (CachedInteractive) *Creds in memory*",
        "Logon (CachedRemoteInteractive) *Creds in memory*",
        "Logon (CachedUnlock) *Creds in memory*":
        result = true
    else:
        result = false

proc isEID_4625(msgLogonRule: string): bool =
    case msgLogonRule
    of
        "Logon Failure (User Does Not Exist)",
        "Logon Failure (Unknown Reason)",
        "Logon Failure (Wrong Password)":
        result = true
    else:
        result = false


proc escapeCsvField(s: string): string =
    # If the field contains a quote, comma, or newline, enclose it in quotes
    # and replace any internal quotes with double quotes.
    if '"' in s or ',' in s or '\n' in s:
        result = "\"" & s.replace("\"", "\"\"") & "\""
    else:
        result = s

proc impersonationLevelIdToName(impersonationLevelId: string): string =
    case impersonationLevelId:
        of "%%1832": result = "Identification"
        of "%%1833": result = "Impersonation"
        of "%%1840": result = "Delegation"
        of "%%1841": result = "Denied by Process Trust Label ACE"
        of "%%1842": result = "Yes"
        of "%%1843": result = "No"
        of "%%1844": result = "System"
        of "%%1845": result = "Not Available"
        of "%%1846": result = "Default"
        of "%%1847": result = "DisallowMmConfig"
        of "%%1848": result = "Off"
        of "%%1849": result = "Auto"
        of "": result = ""
        else: result = "Unknown - " & impersonationLevelId
    return result

proc logonFailureReason(subStatus: string): string =
    case subStatus:
        of "0xc0000064": result = "Non-existant User"
        of "0xc000006a": result = "Wrong Password"
        of "": result = ""
        else: result = "Unknown - " & subStatus
    return result

proc elevatedTokenIdToName(elevatedTokenId: string): string =
    case elevatedTokenId:
        of "%%1842": result = "Yes"
        of "%%1843": result = "No"
        of "": result = ""
        else: result = "Unknown - " & elevatedTokenId
    return result

proc countLines(filePath: string): int =
    var count = 0
    for _ in filePath.lines():
        inc count
    return count

proc logonTimeline(timeline: string, quiet: bool = false, output: string): int =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let totalLines = countLines(timeline)
    echo "Total lines: ", totalLines
    echo "Loading the Hayabusa JSONL timeline. Please wait."
    echo ""

    var
        seqOfResultsTables: seq[TableRef[string, string]] # Sequences are immutable so need to create a sequence of pointers to tables
        seqOfLogoffEventTables: seq[Table[string, string]] # This sequence can be immutable
        EID_4624_count = 0 # Successful logon
        EID_4625_count = 0 # Failed logon
        EID_4634_count = 0 # Logoff
        EID_4647_count = 0 # User initiated logoff
        EID_4648_count = 0 # Explicit logon
        bar = newProgressBar(total = totalLines)
    bar.start()

    for line in lines(timeline):
        bar.increment()
        let jsonLine = parseJson(line)
        let ruleTitle = jsonLine["RuleTitle"].getStr()

        #EID 4624 Successful Logon
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Successful Logon"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            let details = jsonLine["Details"]
            let extraFieldInfo = jsonLine["ExtraFieldInfo"]
            let logonType = details.extractInt("Type")
            singleResultTable["Type"] = logonNumberToString(logonType)
            singleResultTable["Auth"] = extraFieldInfo.extractStr("AuthenticationPackageName")
            singleResultTable["TargetComputer"] = jsonLine.extractStr("Computer")
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            let impersonationLevel = extraFieldInfo.extractStr("ImpersonationLevel")
            singleResultTable["Impersonation"] = impersonationLevelIdToName(impersonationLevel)
            singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            singleResultTable["Process"] = details.extractStr("LogonProcessName")
            singleResultTable["LID"] = details.extractStr("LID")
            singleResultTable["LGUID"] = extraFieldInfo.extractStr("LogonGuid")
            singleResultTable["SourceComputer"] = details.extractStr("SrcIP")
            let elevatedToken = extraFieldInfo.extractStr("ElevatedToken")
            singleResultTable["ElevatedToken"] = elevatedTokenIdToName(elevatedToken)
            singleResultTable["TargetUserSID"] = extraFieldInfo.extractStr("TargetUserSid")
            singleResultTable["TargetDomainName"] = extraFieldInfo.extractStr("TargetDomainName")
            singleResultTable["TargetLinkedLID"] = extraFieldInfo.extractStr("TargetLinkedLogonId")
            singleResultTable["LogoffTime"] = ""
            singleResultTable["ElapsedTime"] = ""

            seqOfResultsTables.add(singleResultTable)

        #EID 4625 Failed Logon
        if isEID_4625(ruleTitle) == true:
            inc EID_4625_count
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Failed Logon"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            let details = jsonLine["Details"]
            let extraFieldInfo = jsonLine["ExtraFieldInfo"]
            let logonType = details.extractInt("Type")
            singleResultTable["Type"] = logonNumberToString(logonType)
            singleResultTable["Auth"] = details.extractStr("AuthPkg")
            singleResultTable["TargetComputer"] = jsonLine.extractStr("Computer")
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            singleResultTable["Process"] = details.extractStr("Proc")
            singleResultTable["SourceComputer"] = details.extractStr("SrcComp")
            singleResultTable["TargetUserSID"] = extraFieldInfo.extractStr("TargetUserSid") # Don't output as it is always S-1-0-0
            singleResultTable["TargetDomainName"] = extraFieldInfo.extractStr("TargetDomainName")
            singleResultTable["FailureReason"] = logonFailureReason(extraFieldInfo.extractStr("SubStatus"))

            seqOfResultsTables.add(singleResultTable)

        #EID 4634 Logoff
        if ruleTitle == "Logoff":
            inc EID_4647_count
            var singleResultTable = initTable[string, string]()
            singleResultTable["Event"] = "User Initiated Logoff"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            singleResultTable["TargetComputer"] = jsonLine.extractStr("Computer")
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            let details = jsonLine["Details"]
            singleResultTable["TargetUser"] = details.extractStr("User")
            singleResultTable["LID"] = details.extractStr("LID")
            seqOfLogoffEventTables.add(singleResultTable)

        #EID 4647 User Initiated Logoff
        if ruleTitle == "Logoff (User Initiated)":
            inc EID_4647_count
            var singleResultTable = initTable[string, string]()
            singleResultTable["Event"] = "User Initiated Logoff"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            singleResultTable["TargetComputer"] = jsonLine.extractStr("Computer")
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            let details = jsonLine["Details"]
            singleResultTable["TargetUser"] = details.extractStr("User")
            singleResultTable["LID"] = details.extractStr("LID")
            seqOfLogoffEventTables.add(singleResultTable)

        #EID 4648 Explicit Logon
        if ruleTitle == "Explicit Logon" or ruleTitle == "Explicit Logon (Suspicious Process)":
            inc EID_4648_count
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Explicit Logon"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            let details = jsonLine["Details"]
            let extraFieldInfo = jsonLine["ExtraFieldInfo"]
            singleResultTable["TargetComputer"] = details.extractStr("TgtSvr")
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            singleResultTable["SourceUser"] = details.extractStr("SrcUser")
            singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            singleResultTable["Process"] = details.extractStr("Proc")
            singleResultTable["LID"] = details.extractStr("LID")
            singleResultTable["LGUID"] = extraFieldInfo.extractStr("LogonGuid")
            singleResultTable["SourceComputer"] = jsonLine.extractStr("Computer") # 4648 is a little different in that the log is saved on the source computer so Computer will be the source.
            seqOfResultsTables.add(singleResultTable)

    echo ""
    echo "Calculating elapsed time. Please wait."
    echo ""

    # Loop through the results, add the logoff time and calculate the elapsed time for 4624 events
    for tableOfResults in seqOfResultsTables:
        if tableOfResults["EventID"] == "4624":
            var logoffTime = ""
            var logonTime = tableOfResults["Timestamp"]

            for tableOfLogoffEvents in seqOfLogoffEventTables:
                # Check that the Computer name, LID and TargetUser field are equal
                if tableOfResults["LID"] == tableOfLogoffEvents["LID"] and tableOfResults["TargetComputer"] == tableOfLogoffEvents["TargetComputer"] and tableOfResults["TargetUser"] == tableOfLogoffEvents["TargetUser"]:
                    logoffTime = tableOfLogoffEvents["Timestamp"]
            if logoffTime.len > 0:
                tableOfResults[]["LogoffTime"] = logoffTime
                logonTime = logonTime[0 ..< logontime.len - 7]
                logoffTime = logoffTime[0 ..< logofftime.len - 7]
                let parsedLogoffTime = parse(logoffTime, "yyyy-MM-dd HH:mm:ss'.'fff")
                let parsedLogonTime = parse(logonTime, "yyyy-MM-dd HH:mm:ss'.'fff")
                let duration = parsedLogoffTime - parsedLogonTime
                tableOfResults[]["ElapsedTime"] = formatDuration(duration)
            else:
                logoffTime = "n/a"
    echo "before bar finish"
    bar.finish()
    echo "Found logon events:"
    echo "EID 4624 (Successful Logon): " & $EID_4624_count
    echo "EID 4625 (Failed Logon): " & $EID_4625_count
    echo "EID 4634 (Logoff): " & $EID_4634_count
    echo "EID 4647 (User Initiated Logoff): " & $EID_4647_count
    echo "EID 4648 (Explicit Logon): " & $EID_4648_count
    echo ""
    # Open file to save results
    var outputFile = open(output, fmWrite)
    let header = ["Timestamp", "Channel", "EventID", "Event", "LogoffTime", "ElapsedTime", "FailureReason", "TargetComputer", "TargetUser", "SourceComputer", "SourceUser", "SourceIP", "Type", "Impersonation", "ElevatedToken", "Auth", "Process", "LID", "LGUID", "TargetUserSID", "TargetDomainName", "TargetLinkedLID"]
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
    outputFile.close()

    echo "Saved results to " & output
    echo ""

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
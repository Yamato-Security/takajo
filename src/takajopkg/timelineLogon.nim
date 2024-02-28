proc timelineLogon(calculateElapsedTime: bool = true, output: string, outputLogoffEvents: bool = false, outputAdminLogonEvents: bool = false, quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

    echo "Started the Timeline Logon command"
    echo ""
    echo "This command creates a CSV timeline of logon events."
    echo "Elapsed time for successful logons are calculated by default but can be disabled with -c=false."
    echo "Logoff events can be outputted on separate lines with -l, --outputLogoffEvents."
    echo "Admin logon events can be outputted on separate lines with -a, --outputAdminLogonEvents."
    echo ""
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    echo "Creating a logon timeline. Please wait."
    echo ""

    var
        seqOfResultsTables: seq[TableRef[string, string]] # Sequences are immutable so need to create a sequence of pointers to tables so we can update ["ElapsedTime"]
        seqOfLogoffEventTables: seq[Table[string, string]] # This sequence can be immutable
        logoffEvents: Table[string, string] = initTable[string, string]()
        adminLogonEvents: Table[string, string] = initTable[string, string]()
        EID_4624_count = 0 # Successful logon
        EID_4625_count = 0 # Failed logon
        EID_4634_count = 0 # Logoff
        EID_4647_count = 0 # User initiated logoff
        EID_4648_count = 0 # Explicit logon
        EID_4672_count = 0 # Admin logon
        bar: SuruBar = initSuruBar()

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000)
        let jsonLine:HayabusaJson = line.fromJson(HayabusaJson)
        let ruleTitle = jsonLine.RuleTitle

        #EID 4624 Successful Logon
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Successful Logon"
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["EventID"] = "4624"
            let details = jsonLine.Details
            let extraFieldInfo = jsonLine.ExtraFieldInfo
            let logonType = details.extractStr("Type") # Will be Int if field mapping is turned off
            singleResultTable["Type"] = logonType # Needs to be logonNumberToString(logonType) if data field mapping is turned off. TODO
            singleResultTable["Auth"] = extraFieldInfo.extractStr("AuthenticationPackageName")
            singleResultTable["TargetComputer"] = jsonLine.Computer
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            let impersonationLevel = extraFieldInfo.extractStr("ImpersonationLevel")
            singleResultTable["Impersonation"] = impersonationLevelIdToName(impersonationLevel)
            singleResultTable["SourceIP"] = details.extractStr("SrcComp")
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
            singleResultTable["AdminLogon"] = ""

            seqOfResultsTables.add(singleResultTable)

        #EID 4625 Failed Logon
        if isEID_4625(ruleTitle) == true:
            inc EID_4625_count
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Failed Logon"
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["EventID"] = "4625"
            let details = jsonLine.Details
            let extraFieldInfo = jsonLine.ExtraFieldInfo
            let logonType = details.extractStr("Type")
            singleResultTable["Type"] = logonType # Needs to be logonNumberToString(logonType) if data field mapping is turned off. TODO
            singleResultTable["Auth"] = details.extractStr("AuthPkg")
            singleResultTable["TargetComputer"] = jsonLine.Computer
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
            inc EID_4634_count
            # If we want to calculate ElapsedTime
            if calculateElapsedTime == true:
                # Create the key in the format of LID:Computer:User with a value of the timestamp
                let key = jsonLine.Details["LID"].getStr() & ":" & jsonLine.Computer & ":" & jsonLine.Details["User"].getStr()
                let logoffTime = jsonLine.Timestamp
                logoffEvents[key] = logoffTime
            if outputLogoffEvents == true:
                var singleResultTable = newTable[string, string]()
                singleResultTable["Event"] = "User Initiated Logoff"
                singleResultTable["Timestamp"] = jsonLine.Timestamp
                singleResultTable["Channel"] = jsonLine.Channel
                singleResultTable["TargetComputer"] = jsonLine.Computer
                singleResultTable["EventID"] = "4634"
                let details = jsonLine.Details
                singleResultTable["TargetUser"] = details.extractStr("User")
                singleResultTable["LID"] = details.extractStr("LID")
                seqOfResultsTables.add(singleResultTable)

        #EID 4647 User Initiated Logoff
        if ruleTitle == "Logoff (User Initiated)":
            inc EID_4647_count
            # If we want to calculate ElapsedTime
            if calculateElapsedTime == true:
                # Create the key in the format of LID:Computer:User with a value of the timestamp
                let key = jsonLine.Details["LID"].getStr() & ":" & jsonLine.Computer & ":" & jsonLine.Details["User"].getStr()
                let logoffTime = jsonLine.Timestamp
                logoffEvents[key] = logoffTime
            if outputLogoffEvents == true:
                var singleResultTable = newTable[string, string]()
                singleResultTable["Event"] = "User Initiated Logoff"
                singleResultTable["Timestamp"] = jsonLine.Timestamp
                singleResultTable["Channel"] = jsonLine.Channel
                singleResultTable["TargetComputer"] = jsonLine.Computer
                singleResultTable["EventID"] = "4647"
                let details = jsonLine.Details
                singleResultTable["TargetUser"] = details.extractStr("User")
                singleResultTable["LID"] = details.extractStr("LID")
                seqOfResultsTables.add(singleResultTable)

        #EID 4648 Explicit Logon
        if ruleTitle == "Explicit Logon" or ruleTitle == "Explicit Logon (Suspicious Process)":
            inc EID_4648_count
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Explicit Logon"
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["EventID"] = "4648"
            let details = jsonLine.Details
            let extraFieldInfo = jsonLine.ExtraFieldInfo
            singleResultTable["TargetComputer"] = details.extractStr("TgtSvr")
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            singleResultTable["SourceUser"] = details.extractStr("SrcUser")
            singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            singleResultTable["Process"] = details.extractStr("Proc")
            singleResultTable["LID"] = details.extractStr("LID")
            singleResultTable["LGUID"] = extraFieldInfo.extractStr("LogonGuid")
            singleResultTable["SourceComputer"] = jsonLine.Computer # 4648 is a little different in that the log is saved on the source computer so Computer will be the source.
            seqOfResultsTables.add(singleResultTable)

        # EID 4672 Admin Logon
        # When someone logs in with administrator level privileges, there will be two logon sessions created. One for a lower privileged user and one with admin privileges.
        # I am just going to add "Yes" to the "AdminLogon" column in the 4624 (Successful logon) event to save space.
        # The timing will be very close to the 4624 log so I am checking if the Computer, LID and TgtUser are the same and then if the two events happened within 10 seconds.
        if ruleTitle == "Admin Logon":
            inc EID_4672_count
            let key = jsonLine.Details["LID"].getStr() & ":" & jsonLine.Computer & ":" & jsonLine.Details["TgtUser"].getStr()
            let adminLogonTime = jsonLine.Timestamp
            adminLogonEvents[key] = adminLogonTime
            if outputAdminLogonEvents == true:
                var singleResultTable = newTable[string, string]()
                singleResultTable["Event"] = "Admin Logon"
                singleResultTable["Timestamp"] = jsonLine.Timestamp
                singleResultTable["Channel"] = jsonLine.Channel
                singleResultTable["EventID"] = "4672"
                singleResultTable["TargetComputer"] = jsonLine.Computer
                let eventId = jsonLine.EventID
                let details = jsonLine.Details
                singleResultTable["TargetUser"] = details.extractStr("TgtUser")
                singleResultTable["LID"] = details.extractStr("LID")
                seqOfResultsTables.add(singleResultTable)

    bar.finish()

    echo ""
    echo "Calculating logon elapsed time. Please wait."
    echo ""

    # Calculating the logon elapsed time (default)
    if calculateElapsedTime == true:
        for tableOfResults in seqOfResultsTables:
            if tableOfResults["EventID"] == "4624":
                var logoffTime = ""
                var logonTime = tableOfResults["Timestamp"]

                let key = tableOfResults["LID"] & ":" & tableOfResults["TargetComputer"] & ":" & tableOfResults["TargetUser"]
                if logoffEvents.hasKey(key):
                    logoffTime = logoffEvents[key]
                    tableOfResults[]["LogoffTime"] = logoffTime
                    logonTime = logonTime[0 ..< logonTime.len - 7]
                    logoffTime = logoffTime[0 ..< logofftime.len - 7]
                    let parsedLogoffTime = parse(logoffTime, "yyyy-MM-dd HH:mm:ss'.'fff")
                    let parsedLogonTime = parse(logonTime, "yyyy-MM-dd HH:mm:ss'.'fff")
                    let duration = parsedLogoffTime - parsedLogonTime
                    tableOfResults[]["ElapsedTime"] = formatDuration(duration)
                else:
                    logoffTime = "n/a"

    # Find admin logons
    for tableOfResults in seqOfResultsTables:
        if tableOfResults["EventID"] == "4624":
            var logonTime = tableOfResults["Timestamp"]
            logonTime = logonTime[0 ..< logonTime.len - 7] # Remove the timezone
            #echo "4624 logon time: " & logonTime
            let key = tableOfResults["LID"] & ":" & tableOfResults["TargetComputer"] & ":" & tableOfResults["TargetUser"]
            if adminLogonEvents.hasKey(key):
                var adminLogonTime = adminLogonEvents[key]
                adminLogonTime = adminLogonTime[0 ..< adminLogonTime.len - 7] # Remove the timezone
                let parsed_4624_logonTime = parse(logonTime, "yyyy-MM-dd HH:mm:ss'.'fff")
                let parsed_4672_logonTime = parse(adminLogonTime, "yyyy-MM-dd HH:mm:ss'.'fff")
                let duration = parsed_4624_logonTime - parsed_4672_logonTime
                # If the 4624 logon event and 4672 admin logon event are within 10 seconds then flag as an Admin Logon
                if duration.inSeconds < 10:
                    tableOfResults[]["AdminLogon"] = "Yes"

    echo "Found logon events:"
    echo "EID 4624 (Successful Logon): ", EID_4624_count
    echo "EID 4625 (Failed Logon): ", EID_4625_count
    echo "EID 4634 (Logoff): ", EID_4634_count
    echo "EID 4647 (User Initiated Logoff): ", EID_4647_count
    echo "EID 4648 (Explicit Logon): ", EID_4648_count
    echo "EID 4672 (Admin Logon): ", EID_4672_count
    echo ""

    # Save results
    var outputFile = open(output, fmWrite)
    let header = ["Timestamp", "Channel", "EventID", "Event", "LogoffTime", "ElapsedTime", "FailureReason", "TargetComputer", "TargetUser", "AdminLogon", "SourceComputer", "SourceUser", "SourceIP", "Type", "Impersonation", "ElevatedToken", "Auth", "Process", "LID", "LGUID", "TargetUserSID", "TargetDomainName", "TargetLinkedLID"]

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

    echo "Saved results to " & output & " (" & formatFileSize(fileSize) & ")"
    echo ""
    outputElapsedTime(startTime)
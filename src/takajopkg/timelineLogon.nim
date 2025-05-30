const TimelineLogonMsg =
    """
This command creates a CSV timeline of logon events.
Elapsed time for successful logons are calculated by default but can be disabled with -c=false.
Logoff events can be outputted on separate lines with -l, --outputLogoffEvents.
Admin logon events can be outputted on separate lines with -a, --outputAdminLogonEvents."""

type
    TimelineLogonCmd* = ref object of AbstractCmd
        seqOfResultsTables*: seq[TableRef[string,
                string]] # Sequences are immutable so need to create a sequence of pointers to tables so we can update ["ElapsedTime"]
        seqOfLogoffEventTables*: seq[Table[string, string]] # This sequence can be immutable
        logoffEvents*: Table[string, string] = initTable[string, string]()
        rdpLogoffEvents*: Table[string, seq[string]] = initTable[string, seq[string]]()
        adminLogonEvents*: Table[string, string] = initTable[string, string]()
        EID_21_count*: int = 0 # RDP Logon
        EID_23_count*: int = 0 # RDP Logoff
        EID_302_count*: int = 0 # RDS GTW Logon
        EID_303_count*: int = 0 # RDS GTW Logoff
        EID_4624_count* = 0 # Successful logon
        EID_4625_count* = 0 # Failed logon
        EID_4634_count* = 0 # Logoff
        EID_4647_count* = 0 # User initiated logoff
        EID_4648_count* = 0 # Explicit logon
        EID_4672_count* = 0 # Admin logon
        calculateElapsedTime*: bool
        outputLogoffEvents*: bool
        outputAdminLogonEvents*: bool

method filter*(self: TimelineLogonCmd, x: HayabusaJson): bool =
    return x.EventId == 4624 or x.EventId == 4625 or x.EventId == 4634 or
            x.EventId == 4647 or x.EventId == 4648 or x.EventId == 4672 or 
            x.EventId == 21 or x.EventId == 23 or x.EventId == 302 or x.EventId == 303

method analyze*(self: TimelineLogonCmd, x: HayabusaJson) =
    let ruleTitle = x.RuleTitle
    let jsonLine = x
    #EID 4624 Successful Logon
    if isEID_4624(ruleTitle) == true:
        inc self.EID_4624_count
        var singleResultTable = newTable[string, string]()
        singleResultTable["Event"] = "Successful Logon"
        singleResultTable["Timestamp"] = jsonLine.Timestamp
        singleResultTable["Channel"] = jsonLine.Channel
        singleResultTable["EventID"] = "4624"
        let details = jsonLine.Details
        let extraFieldInfo = jsonLine.ExtraFieldInfo
        let logonType = details.extractStr(
                "Type") # Will be Int if field mapping is turned off
        singleResultTable["Type"] = logonType # Needs to be logonNumberToString(logonType) if data field mapping is turned off. TODO
        singleResultTable["Auth"] = extraFieldInfo.extractStr("AuthenticationPackageName")
        singleResultTable["TargetComputer"] = jsonLine.Computer
        singleResultTable["TargetUser"] = details.extractStr("TgtUser")
        let impersonationLevel = extraFieldInfo.extractStr("ImpersonationLevel")
        singleResultTable["Impersonation"] = impersonationLevelIdToName(impersonationLevel)
        singleResultTable["SourceIP"] = details.extractStr("SrcIP")
        singleResultTable["Process"] = details.extractStr("LogonProcessName")
        singleResultTable["LID"] = details.extractStr("LID")
        singleResultTable["LGUID"] = extraFieldInfo.extractStr("LogonGuid")
        singleResultTable["SourceComputer"] = details.extractStr("SrcComp")
        let elevatedToken = extraFieldInfo.extractStr("ElevatedToken")
        singleResultTable["ElevatedToken"] = elevatedTokenIdToName(elevatedToken)
        singleResultTable["TargetUserSID"] = extraFieldInfo.extractStr("TargetUserSid")
        singleResultTable["TargetDomainName"] = extraFieldInfo.extractStr("TargetDomainName")
        singleResultTable["TargetLinkedLID"] = extraFieldInfo.extractStr("TargetLinkedLogonId")
        singleResultTable["LogoffTime"] = ""
        singleResultTable["ElapsedTime"] = ""
        singleResultTable["AdminLogon"] = ""
        self.seqOfResultsTables.add(singleResultTable)

    #EID 4625 Failed Logon
    if isEID_4625(ruleTitle) == true:
        inc self.EID_4625_count
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
        singleResultTable["TargetUserSID"] = extraFieldInfo.extractStr(
                "TargetUserSid") # Don't output as it is always S-1-0-0
        singleResultTable["TargetDomainName"] = extraFieldInfo.extractStr("TargetDomainName")
        singleResultTable["FailureReason"] = logonFailureReason(
                extraFieldInfo.extractStr("SubStatus"))
        self.seqOfResultsTables.add(singleResultTable)

    #EID 4634 Logoff
    if ruleTitle == "Logoff":
        inc self.EID_4634_count
        # If we want to calculate ElapsedTime
        if self.calculateElapsedTime:
            # Create the key in the format of LID:Computer:User with a value of the timestamp
            let key = jsonLine.Details["LID"].getStr() & ":" &
                    jsonLine.Computer & ":" & jsonLine.Details["User"].getStr()
            let logoffTime = jsonLine.Timestamp
            self.logoffEvents[key] = logoffTime
        if self.outputLogoffEvents:
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "User Initiated Logoff"
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["TargetComputer"] = jsonLine.Computer
            singleResultTable["EventID"] = "4634"
            let details = jsonLine.Details
            singleResultTable["TargetUser"] = details.extractStr("User")
            singleResultTable["LID"] = details.extractStr("LID")
            self.seqOfResultsTables.add(singleResultTable)

    #EID 4647 User Initiated Logoff
    if ruleTitle == "Logoff (User Initiated)":
        inc self.EID_4647_count
        # If we want to calculate ElapsedTime
        if self.calculateElapsedTime:
            # Create the key in the format of LID:Computer:User with a value of the timestamp
            let key = jsonLine.Details["LID"].getStr() & ":" &
                    jsonLine.Computer & ":" & jsonLine.Details["User"].getStr()
            let logoffTime = jsonLine.Timestamp
            self.logoffEvents[key] = logoffTime
        if self.outputLogoffEvents:
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "User Initiated Logoff"
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["TargetComputer"] = jsonLine.Computer
            singleResultTable["EventID"] = "4647"
            let details = jsonLine.Details
            singleResultTable["TargetUser"] = details.extractStr("User")
            singleResultTable["LID"] = details.extractStr("LID")
            self.seqOfResultsTables.add(singleResultTable)

    #EID 4648 Explicit Logon
    if ruleTitle == "Explicit Logon" or ruleTitle == "Explicit Logon (Suspicious Process)":
        inc self.EID_4648_count
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
        self.seqOfResultsTables.add(singleResultTable)

    # EID 4672 Admin Logon
    # When someone logs in with administrator level privileges, there will be two logon sessions created. One for a lower privileged user and one with admin privileges.
    # I am just going to add "Yes" to the "AdminLogon" column in the 4624 (Successful logon) event to save space.
    # The timing will be very close to the 4624 log so I am checking if the Computer, LID and TgtUser are the same and then if the two events happened within 10 seconds.
    if ruleTitle == "Admin Logon":
        inc self.EID_4672_count
        let key = jsonLine.Details["LID"].getStr() & ":" & jsonLine.Computer &
                ":" & jsonLine.Details["TgtUser"].getStr()
        let adminLogonTime = jsonLine.Timestamp
        self.adminLogonEvents[key] = adminLogonTime
        if self.outputAdminLogonEvents:
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = "Admin Logon"
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["EventID"] = "4672"
            singleResultTable["TargetComputer"] = jsonLine.Computer
            let details = jsonLine.Details
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            singleResultTable["LID"] = details.extractStr("LID")
            self.seqOfResultsTables.add(singleResultTable)

    #EID 21 Logon
    if ruleTitle == "RDP Logon":
        inc self.EID_21_count
        var singleResultTable = newTable[string, string]()
        singleResultTable["Event"] = ruleTitle
        singleResultTable["Timestamp"] = jsonLine.Timestamp
        singleResultTable["Channel"] = jsonLine.Channel
        singleResultTable["EventID"] = "21"
        let details = jsonLine.Details
        singleResultTable["TargetComputer"] = jsonLine.Computer
        singleResultTable["SourceIP"] = details.extractStr("SrcIP")
        let userDetail = details.extractStr("TgtUser")
        if userDetail.contains("\\"):
            let parts = userDetail.split("\\")
            singleResultTable["TargetDomainName"] = parts[0]
            singleResultTable["TargetUser"] = parts[1]
        else:
            singleResultTable["TargetUser"] = userDetail
        singleResultTable["LID"] = details.extractStr("SessID")
        singleResultTable["LogoffTime"] = ""
        singleResultTable["ElapsedTime"] = ""
        self.seqOfResultsTables.add(singleResultTable)

    #EID 23 RDP Logoff
    if ruleTitle == "RDP Logoff":
        inc self.EID_23_count
        # If we want to calculate ElapsedTime
        let details = jsonLine.Details
        if self.calculateElapsedTime:
            # Create the key in the format of LID:Computer:User with a value of the timestamp
            var tgtUser = details.extractStr("TgtUser")
            if tgtUser.contains("\\"):
                let parts = tgtUser.split("\\")
                tgtUser = parts[1]
            let key = jsonLine.Details["SessID"].getStr() & ":" &
                    jsonLine.Computer & ":" & tgtUser
            let logoffTime = jsonLine.Timestamp
            if self.rdpLogoffEvents.hasKey(key):
                self.rdpLogoffEvents[key].add(logoffTime)
            else:
                self.rdpLogoffEvents[key] = @[logoffTime]
        if self.outputLogoffEvents:
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = ruleTitle
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["TargetComputer"] = jsonLine.Computer
            singleResultTable["EventID"] = "23"
            let userDetail = details.extractStr("TgtUser")
            if userDetail.contains("\\"):
                let parts = userDetail.split("\\")
                singleResultTable["TargetDomainName"] = parts[0]
                singleResultTable["TargetUser"] = parts[1]
            else:
                singleResultTable["TargetUser"] = userDetail
            singleResultTable["LID"] = details.extractStr("SessID")
            self.seqOfResultsTables.add(singleResultTable)

    #EID 302 RDS GTW Logon
    if ruleTitle == "RDS GTW Logon":
        inc self.EID_302_count
        var singleResultTable = newTable[string, string]()
        singleResultTable["Event"] = ruleTitle
        singleResultTable["Timestamp"] = jsonLine.Timestamp
        singleResultTable["Channel"] = jsonLine.Channel
        singleResultTable["EventID"] = "302"
        let details = jsonLine.Details
        singleResultTable["TargetComputer"] = jsonLine.Computer
        singleResultTable["SourceIP"] = details.extractStr("SrcIP")
        singleResultTable["TargetUser"] = details.extractStr("TgtUser")
        let userDetail = details.extractStr("TgtUser")
        if userDetail.contains("\\"):
            let parts = userDetail.split("\\")
            singleResultTable["TargetDomainName"] = parts[0]
            singleResultTable["TargetUser"] = parts[1]
        else:
            singleResultTable["TargetUser"] = userDetail
        singleResultTable["LogoffTime"] = ""
        singleResultTable["ElapsedTime"] = ""
        self.seqOfResultsTables.add(singleResultTable)

    #EID 303 RDS GTW Logoff
    if ruleTitle == "RDS GTW Logoff":
        inc self.EID_303_count
        if self.outputLogoffEvents:
            var singleResultTable = newTable[string, string]()
            singleResultTable["Event"] = ruleTitle
            singleResultTable["Timestamp"] = jsonLine.Timestamp
            singleResultTable["Channel"] = jsonLine.Channel
            singleResultTable["EventID"] = "303"
            let details = jsonLine.Details
            singleResultTable["TargetComputer"] = jsonLine.Computer
            singleResultTable["SourceIP"] = details.extractStr("SrcIP")
            singleResultTable["TargetUser"] = details.extractStr("TgtUser")
            let userDetail = details.extractStr("TgtUser")
            if userDetail.contains("\\"):
                let parts = userDetail.split("\\")
                singleResultTable["TargetDomainName"] = parts[0]
                singleResultTable["TargetUser"] = parts[1]
            else:
                singleResultTable["TargetUser"] = userDetail
            singleResultTable["LogoffTime"] = ""
            singleResultTable["ElapsedTime"] = ""
            self.seqOfResultsTables.add(singleResultTable)


proc calculateDuration(logonTime: string, logoffTime: string, timeFormat: string): Duration =
    let logonTime = if logonTime.endsWith("Z"): logonTime.replace("Z", "") else: logonTime[0 ..< logonTime.len - 7]
    let logoffTime = if logoffTime.endsWith("Z"): logoffTime.replace("Z", "") else: logoffTime[0 ..< logoffTime.len - 7]
    let parsedLogoffTime = parse(padString(logoffTime, '0', timeFormat), timeFormat)
    let parsedLogonTime = parse(padString(logonTime, '0', timeFormat), timeFormat)
    return parsedLogoffTime - parsedLogonTime

method resultOutput*(self: TimelineLogonCmd) =
    if self.displayTable:
        echo ""
        echo "Calculating logon elapsed time. Please wait."
        echo ""
    let timeFormat = getTimeFormat(self.seqOfResultsTables)
    # Calculating the logon elapsed time (default)
    if self.calculateElapsedTime:
        for tableOfResults in self.seqOfResultsTables:
            if tableOfResults["EventID"] == "4624" or tableOfResults["EventID"] == "21":
                var logonTime = tableOfResults["Timestamp"]
                let key = tableOfResults["LID"] & ":" & tableOfResults[
                        "TargetComputer"] & ":" & tableOfResults["TargetUser"]
                if self.logoffEvents.hasKey(key):
                    let logoffTime = self.logoffEvents[key]
                    if logoffTime > logonTime:
                        tableOfResults[]["LogoffTime"] = logoffTime
                        let duration = calculateDuration(logonTime, logoffTime, timeFormat)
                        tableOfResults[]["ElapsedTime"] = formatDuration(duration)
                elif self.rdpLogoffEvents.hasKey(key):
                    var logoffTimes = self.rdpLogoffEvents[key]
                    logoffTimes.sort()
                    for logoffTime in logoffTimes:
                        if logoffTime > logonTime:
                            tableOfResults[]["LogoffTime"] = logoffTime
                            let duration = calculateDuration(logonTime, logoffTime, timeFormat)
                            tableOfResults[]["ElapsedTime"] = formatDuration(duration)
                            break

    # Find admin logons
    for tableOfResults in self.seqOfResultsTables:
        if tableOfResults["EventID"] == "4624":
            var logonTime = tableOfResults["Timestamp"]
            logonTime = if logonTime.endsWith("Z"): logonTime.replace("Z",
                    "") else: logonTime[0 ..< logonTime.len - 7] # Remove the timezone
            #echo "4624 logon time: " & logonTime
            let key = tableOfResults["LID"] & ":" & tableOfResults[
                    "TargetComputer"] & ":" & tableOfResults["TargetUser"]
            if self.adminLogonEvents.hasKey(key):
                var adminLogonTime = self.adminLogonEvents[key]
                adminLogonTime = if adminLogonTime.endsWith(
                        "Z"): adminLogonTime.replace("Z",
                        "") else: adminLogonTime[0 ..< adminLogonTime.len -
                        7] # Remove the timezone
                let parsed_4624_logonTime = parse(padString(logonTime, '0',
                        timeFormat), timeFormat)
                let parsed_4672_logonTime = parse(padString(adminLogonTime, '0',
                        timeFormat), timeFormat)
                let duration = parsed_4624_logonTime - parsed_4672_logonTime
                # If the 4624 logon event and 4672 admin logon event are within 10 seconds then flag as an Admin Logon
                if duration.inSeconds < 10:
                    tableOfResults[]["AdminLogon"] = "Yes"
    let results = "" &
         padString("EID 4624 (Successful Logon): " & intToStr(
                 self.EID_4624_count).insertSep(','), ' ', 100) &
         padString("EID 4625 (Failed Logon): " & intToStr(
                 self.EID_4625_count).insertSep(','), ' ', 100) &
         padString("EID 4634 (Logoff): " & intToStr(
                 self.EID_4634_count).insertSep(','), ' ', 100) &
         padString("EID 4647 (User Initiated Logoff): " & intToStr(
                 self.EID_4647_count).insertSep(','), ' ', 100) &
         padString("EID 4648 (Explicit Logon): " & intToStr(
                 self.EID_4648_count).insertSep(','), ' ', 100) &
         padString("EID 4672 (Admin Logon): " & intToStr(
                 self.EID_4672_count).insertSep(','), ' ', 100) &
         padString("EID 21 (RDP Logon): " & intToStr(
                 self.EID_21_count).insertSep(','), ' ', 100) &
         padString("EID 23 (RDP Logoff): " & intToStr(
                 self.EID_23_count).insertSep(','), ' ', 100) &
         padString("EID 302 (RDS GTW Logon): " & intToStr(
                 self.EID_302_count).insertSep(','), ' ', 100) &
         padString("EID 303 (RDP GTW Logoff): " & intToStr(
                 self.EID_303_count).insertSep(','), ' ', 100)
    
    if self.displayTable:
        echo ""
        echo "Found logon events:"
        echo "EID 4624 (Successful Logon): ", intToStr(
                self.EID_4624_count).insertSep(',')
        echo "EID 4625 (Failed Logon): ", intToStr(
                self.EID_4625_count).insertSep(',')
        echo "EID 4634 (Logoff): ", intToStr(self.EID_4634_count).insertSep(',')
        echo "EID 4647 (User Initiated Logoff): ", intToStr(
                self.EID_4647_count).insertSep(',')
        echo "EID 4648 (Explicit Logon): ", intToStr(
                self.EID_4648_count).insertSep(',')
        echo "EID 4672 (Admin Logon): ", intToStr(
                self.EID_4672_count).insertSep(',')
        echo "EID 21 (RDP Logon): ", intToStr(
                self.EID_21_count).insertSep(',')
        echo "EID 23 (RDP Logoff): ", intToStr(
                self.EID_23_count).insertSep(',')
        echo "EID 302 (RDS GTW Logon): ", intToStr(
                self.EID_302_count).insertSep(',')
        echo "EID 303 (RDP GTW Logoff): ", intToStr(
                self.EID_303_count).insertSep(',')
        echo ""


    # Save results
    var outputFile = open(self.output, fmWrite)
    let header = ["Timestamp", "Channel", "EventID", "Event", "LogoffTime",
            "ElapsedTime", "FailureReason", "TargetComputer", "TargetUser",
            "AdminLogon", "SourceComputer", "SourceUser", "SourceIP", "Type",
            "Impersonation", "ElevatedToken", "Auth", "Process", "LID", "LGUID",
            "TargetUserSID", "TargetDomainName", "TargetLinkedLID"]

    ## Write CSV header
    for h in header:
        outputFile.write(h & ",")
    outputFile.write("\p")

    ## Write contents
    self.seqOfResultsTables.sort(proc(a, b: TableRef[string, string]): int =
        if a["Timestamp"] < b["Timestamp"]: return -1
        if a["Timestamp"] > b["Timestamp"]: return 1
        return 0)
    for table in self.seqOfResultsTables:
        for key in header:
            if table.hasKey(key):
                outputFile.write(escapeCsvField(table[key]) & ",")
            else:
                outputFile.write(",")
        outputFile.write("\p")
    let fileSize = getFileSize(self.output)
    outputFile.close()
    let savedFiles = self.output & " (" & formatFileSize(fileSize) & ")"
    if self.displayTable:
        echo "Saved results to " & savedFiles
    self.cmdResult = CmdResult(results: results, savedFiles: savedFiles)

proc timelineLogon(calculateElapsedTime: bool = true, output: string,
        outputLogoffEvents: bool = false, outputAdminLogonEvents: bool = false,
        skipProgressBar: bool = false, quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
    for timelinePath in filePaths:
        let cmd = TimelineLogonCmd(
                    skipProgressBar: skipProgressBar,
                    timeline: timelinePath,
                    output: output,
                    name: "timeline-logon",
                    msg: TimelineLogonMsg,
                    calculateElapsedTime: calculateElapsedTime,
                    outputLogoffEvents: outputLogoffEvents,
                    outputAdminLogonEvents: outputAdminLogonEvents)
        cmd.analyzeJSONLFile()

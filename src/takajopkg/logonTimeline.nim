proc logonTimeline(timeline:string, quiet: bool = false, output:string): int =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    echo "Loading the Hayabusa JSONL timeline"
    echo ""

    var seqOfResultsTables: seq[Table[string, string]]
    var EID_4624_count = 0 # Successful logon
    var EID_4648_count = 0 # Explicit logon


    for line in lines(timeline):
        let jsonLine = parseJson(line)
        let ruleTitle = jsonLine["RuleTitle"].getStr()

        #EID 4624 Logon Success
        if isEID_4624(ruleTitle) == true:
            inc EID_4624_count
            var singleResultTable = initTable[string, string]()
            singleResultTable["Event"] = "Successful Logon"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            try:
                let logonType = jsonLine["Details"]["Type"].getInt()
                singleResultTable["Type"] = logonNumberToString(logonType)
            except KeyError:
                singleResultTable["Type"] = ""
            try:
                singleResultTable["Auth"] = jsonLine["ExtraFieldInfo"]["AuthenticationPackageName"].getStr()
            except KeyError:
                singleResultTable["Auth"] = ""
            try:
                singleResultTable["TargetComputer"] = jsonLine["Computer"].getStr()
            except KeyError:
                singleResultTable["TargetComputer"] = ""
            try:
                singleResultTable["TargetUser"] = jsonLine["Details"]["TgtUser"].getStr()
            except KeyError:
                singleResultTable["TargetUser"] = ""
            try:
                singleResultTable["Impersonation"] = impersonationLevelIdToName(jsonLine["ExtraFieldInfo"]["ImpersonationLevel"].getStr())
            except KeyError:
                singleResultTable["Impersonation"] = ""
            try:
                singleResultTable["SourceIP"] = jsonLine["Details"]["SrcIP"].getStr()
            except KeyError:
                singleResultTable["SourceIP"] = ""
            try:
                singleResultTable["Process"] = jsonLine["Details"]["LogonProcessName"].getStr()
            except KeyError:
                singleResultTable["Process"] = ""
            try:
                singleResultTable["LID"] = jsonLine["Details"]["LID"].getStr()
            except KeyError:
                singleResultTable["LID"] = ""
            try:
                singleResultTable["LGUID"] = jsonLine["ExtraFieldInfo"]["LogonGuid"].getStr()
            except KeyError:
                singleResultTable["LGUID"] = ""
            try:
                singleResultTable["SourceComputer"] = jsonLine["Details"]["SrcIP"].getStr()
            except KeyError:
                singleResultTable["SourceComputer"] = ""
            try:
                singleResultTable["ElevatedToken"] = elevatedTokenIdToName(jsonLine["ExtraFieldInfo"]["ElevatedToken"].getStr())
            except KeyError:
                singleResultTable["ElevatedToken"] = ""
            try:
                singleResultTable["TargetUserSID"] = jsonLine["ExtraFieldInfo"]["TargetUserSid"].getStr()
            except KeyError:
                singleResultTable["TargetUserSID"] = ""
            try:
                singleResultTable["TargetDomainName"] = jsonLine["ExtraFieldInfo"]["TargetDomainName"].getStr()
            except KeyError:
                singleResultTable["TargetDomainName"] = ""
            try:
                singleResultTable["TargetLinkedLID"] = jsonLine["ExtraFieldInfo"]["TargetLinkedLogonId"].getStr()
            except KeyError:
                singleResultTable["TargetLinkedLID"] = ""
            # Add fields that do not exist in this EID
            singleResultTable["SourceUser"] = ""
            seqOfResultsTables.add(singleResultTable)

        
        #EID 4648 Explicit Logon
        if ruleTitle == "Explicit Logon" or ruleTitle == "Explicit Logon (Suspicious Process)":
            inc EID_4648_count
            var singleResultTable = initTable[string, string]()
            singleResultTable["Event"] = "Explicit Logon"
            singleResultTable["Timestamp"] = jsonLine["Timestamp"].getStr()
            singleResultTable["Channel"] = jsonLine["Channel"].getStr()
            let eventId = jsonLine["EventID"].getInt()
            let eventIdStr = $eventId
            singleResultTable["EventID"] = eventIdStr
            try:
                singleResultTable["TargetComputer"] = jsonLine["Details"]["TgtSvr"].getStr()
            except KeyError:
                singleResultTable["TargetComputer"] = ""
            try:
                singleResultTable["TargetUser"] = jsonLine["Details"]["TgtUser"].getStr()
            except KeyError:
                singleResultTable["TargetUser"] = ""
            try:
                singleResultTable["SourceUser"] = jsonLine["Details"]["SrcUser"].getStr()
            except KeyError:
                singleResultTable["SourceUser"] = ""
            try:
                singleResultTable["SourceIP"] = jsonLine["Details"]["SrcIP"].getStr()
            except KeyError:
                singleResultTable["SourceIP"] = ""
            try:
                singleResultTable["Process"] = jsonLine["Details"]["Proc"].getStr()
            except KeyError:
                singleResultTable["Process"] = ""
            try:
                singleResultTable["LID"] = jsonLine["Details"]["LID"].getStr()
            except KeyError:
                singleResultTable["LID"] = ""
            try:
                singleResultTable["LGUID"] = jsonLine["ExtraFieldInfo"]["LogonGuid"].getStr()
            except KeyError:
                singleResultTable["LGUID"] = ""
            try:
                singleResultTable["SourceComputer"] = jsonLine["Computer"].getStr() # 4648 is a little different in that the log is saved on the source computer so Computer will be the source.
            except KeyError:
                singleResultTable["SourceComputer"] = ""
            # Add fields that do not exist in this EID
            singleResultTable["Type"] = ""
            singleResultTable["Auth"] = ""
            singleResultTable["Impersonation"] = ""
            singleResultTable["ElevatedToken"] = ""
            singleResultTable["ElevatedToken"] = ""
            seqOfResultsTables.add(singleResultTable)    

    echo "Found logon events:"
    echo "EID 4624 (Successful Logon): " & $EID_4624_count
    echo "EID 4648 (Explicit Logon): " & $EID_4648_count
    echo ""
    # Open file to save results
    var outputFile = open(output, fmWrite)
    ## Write CSV header
    outputFile.write("Timestamp,Channel,EventID,Event,TargetComputer,TargetUser,SourceComputer,SourceUser,SourceIP,Type,Impersonation,ElevatedToken,Auth,Process,LID,LGUID,TargetUserSID,TargetDomainName,TargetLinkedLID\p")
    ## Write contents
    for table in seqOfResultsTables:
        outputFile.write(table["Timestamp"] & ",")
        outputFile.write(table["Channel"] & ",")
        outputFile.write(table["EventID"] & ",")
        outputFile.write(table["Event"] & ",")
        outputFile.write(escapeCsvField(table["TargetComputer"]) & ",")
        outputFile.write(escapeCsvField(table["TargetUser"]) & ",")
        outputFile.write(escapeCsvField(table["SourceComputer"]) & ",")
        outputFile.write(escapeCsvField(table["SourceUser"]) & ",")
        outputFile.write(table["SourceIP"] & ",")
        outputFile.write(table["Type"] & ",")
        outputFile.write(table["Impersonation"] & ",")
        outputFile.write(table["ElevatedToken"] & ",")
        outputFile.write(table["Auth"] & ",")
        outputFile.write(escapeCsvField(table["Process"]) & ",")
        outputFile.write(escapeCsvField(table["LID"]) & ",")
        outputFile.write(escapeCsvField(table["LGUID"]) & ",")
        outputFile.write(escapeCsvField(table["TargetUserSID"]) & ",")
        outputFile.write(escapeCsvField(table["TargetDomainName"]) & ",")
        outputFile.write(escapeCsvField(table["TargetLinkedLID"]) & ",")
        outputFile.write("\p")
    outputFile.close()

    echo "Saved results to " & output
    echo ""
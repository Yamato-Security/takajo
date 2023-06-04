import cligen
import os
import terminal
import json
import sequtils
import strformat
import strutils
import tables
import takajopkg/general

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


proc listUndetectedEvtxFiles(timeline: string, evtxDir: string,
        columnName: system.string = "EvtxFile", quiet: bool = false,
                output: string = ""): int =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
    var fileLists: seq[string] = getTargetExtFileLists(evtxDir, ".evtx")

    var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
    detectedPaths = deduplicate(detectedPaths)

    let checkResult = getUnlistedSeq(fileLists, detectedPaths)
    var outputStock: seq[string] = @[]

    echo "Finished. "
    echo "---------------"

    if checkResult.len == 0:
        echo "Great! No undetected evtx files were found."
        echo ""
    else:
        echo "Undetected evtx file identified."
        echo ""
        var numberOfEvtxFiles = 0
        for undetectedFile in checkResult:
            outputStock.add(undetectedFile)
            inc numberOfEvtxFiles
        outputStock.add("")
        let undetectedPercentage = (checkResult.len() / fileLists.len()) * 100
        echo fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections."
        echo fmt"Number of evtx files not detected: {numberOfEvtxFiles}"
        echo ""
    if output != "":
        let f = open(output, fmWrite)
        defer: f.close()
        for line in outputStock:
            f.writeLine(line)
        echo fmt"Saved File {output}"
        echo ""
    else:
        echo outputstock.join("\n")
    discard

proc listUnusedRules(timeline: string, rulesDir: string,
        columnName: string = "RuleFile", quiet: bool = false,
                output: string = ""): int =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
    var fileLists: seq[string] = getTargetExtFileLists(rulesDir, ".yml")
    var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
    detectedPaths = deduplicate(detectedPaths)
    var outputStock: seq[string] = @[]

    echo "Finished. "
    echo "---------------"

    let checkResult = getUnlistedSeq(fileLists, detectedPaths)
    if checkResult.len == 0:
        echo "Great! No unused rule files were found."
        echo ""
    else:
        echo "Unused rule file identified."
        echo ""
        var numberOfUnusedRules = 0
        for undetectedFile in checkResult:
            outputStock.add(undetectedFile)
            inc numberOfUnusedRules
        let undetectedPercentage = (checkResult.len() / fileLists.len()) * 100
        outputStock.add("")
        echo fmt"{ undetectedPercentage :.4}% of the yml rules were not used."
        echo fmt"Number of unused rule files: {numberOfUnusedRules}"
        echo ""
    if output != "":
        let f = open(output, fmWrite)
        defer: f.close()
        for line in outputStock:
            f.writeLine(line)
        echo fmt"Saved File {output}"
        echo ""
    else:
        echo outputstock.join("\n")
    discard

when isMainModule:
    clCfg.version = "2.0.0-dev"
    const examples_1 = "Examples:\n"
    const examples_2 = "  logon-timeline -t ../hayabusa/timeline.jsonl -o logon-timeline.csv\n"
    const examples_3 = "  undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx\n"
    const examples_4 = "  unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules\n"
    clCfg.useMulti = "Usage: takajo.exe <COMMAND>\n\nCommands:\n$subcmds\nCommand help: $command help <COMMAND>\n\n" & examples_1 & examples_2 & examples_3 & examples_4

    if paramCount() == 0:
        styledEcho(fgGreen, outputLogo())
    dispatchMulti(
        [
            logonTimeline, cmdName = "logon-timeline",
            doc = "create a timeline of various logon events (input: JSONL)",
            help = {
                "timeline": "JSONL timeline created by Hayabusa",
                "quiet": "Do not display the launch banner",
                "output": "Save the results to a CSV file.",
            }
        ],
        [
            listUndetectedEvtxFiles, cmdName = "undetected-evtx",
            doc = "list up undetected evtx files (input: CSV, profile: verbose)",
            help = {
                "timeline": "CSV timeline created by Hayabusa with verbose profile",
                "evtxDir": "The directory of .evtx files you scanned with Hayabusa",
                "columnName": "Specify custom column header name",
                "quiet": "Do not display the launch banner",
                "output": "Save the results to a text file. The default is to print to screen.",
            }
        ],
        [
            listUnusedRules, cmdName = "unused-rules",
            doc = "list up unused rules (input: CSV, profile: verbose)",
            help = {
                "timeline": "CSV timeline created by Hayabusa with verbose profile",
                "rulesDir": "Hayabusa rules directory",
                "columnName": "Specify custom column header name",
                "quiet": "Do not display the launch banner",
                "output": "Save the results to a text file. The default is to print to screen.",
            }
        ]
    )

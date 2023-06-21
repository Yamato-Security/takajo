type
    processObject = object
        timeStamp: string
        procName: string
        processID: string
        processGUID: string
        parentProcessGUID: string
        children: seq[processObject]

proc printIndentedProcessTree(p: processObject, indent: string = "",
        stairNum: int = 0): seq[string] =
    ## プロセスオブジェクトからプロセスツリーを画面上に表示するためのプロシージャ

    var ret: seq[string] = @[]
    ret = @[indent & p.procName & " (" & p.timeStamp & " / " &
            p.processID &
            " / " & p.processGUID & ")"]

    var childStairNum = stairNum + 1
    var childPreStairStr = ""
    var cnt = 1

    # プロセスの階層数に応じて、親階層がつながっていることを表現するための`  |`を付与する
    while childStairNum > cnt:
        childPreStairStr &= "  │"
        inc cnt
    for childNum, children in enumerate(p.children):
        # 子プロセスの表示を行う
        var childIndentStr = childPreStairStr
        if len(p.children) == childNum + 1:
            childIndentStr &= "  └ "
        else:
            childIndentStr &= "  ├ "
        ret = concat(ret, printIndentedProcessTree(children, childIndentStr,
                childStairNum))
    return ret

proc sysmonProcessTree(output: string = "", processGuid: string,
        quiet: bool = false, timeline: string) =
    ## Sysmonのプロセスツリーを表示するためのプロシージャ

    # ロゴの表示
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    echo ""
    echo "Running the Process Tree module"
    echo ""

    var processObjectTable = newTable[string, processObject]()

    #var seqOfResultsTables: seq[Table[string, string]]

    var processesFoundCount = 0
    var foundProcessTable = initTable[string, string]()
    var passGuid = initHashSet[string]()
    passGuid.incl(processGuid)
    var addedProcess = initHashSet[string]()

    for line in lines(timeline):
        let
            jsonLine = parseJson(line)
            timeStamp = jsonLine["Timestamp"].getStr()
            channel = jsonLine["Channel"].getStr()
            eventId = jsonLine["EventID"].getInt()
            eventLevel = jsonLine["Level"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
        var eventProcessGUID = ""
        # Found a Sysmon 1 process creation event. This assumes info level events are enabled and there won't be more than one Sysmon 1 event for a process.
        if channel == "Sysmon" and eventId == 1 and (ruleTitle == "Proc Exec" or ruleTitle == "Proc Exec (Sysmon Alert)"):
            try:
                eventProcessGUID = jsonLine["Details"]["PGUID"].getStr()
            except KeyError:
                echo "Could not find the PGUID field. Make sure you ran Hayabusa with the standard profile."
            if eventProcessGUID in passGuid or jsonLine["Details"][
                                "ParentPGUID"].getStr() in passGuid:
                inc processesFoundCount
                let keysToExtract = {
                    "CmdLine": "Cmdline",
                    "Proc": "Proc",
                    "ParentCmdline": "ParentCmdline",
                    "LogonID": "LID",
                    "LogonGUID": "LGUID",
                    "PID": "PID",
                    "ParentPID": "ParentPID",
                    "ParentPGUID": "ParentPGUID",
                    "Hashes": "Hashes"
                }

                for (foundKey, jsonKey) in keysToExtract:
                    try:
                        foundProcessTable[foundKey] = jsonLine["Details"][
                                jsonKey].getStr()
                    except KeyError:
                        foundProcessTable[foundKey] = ""

                let process = processObject(
                        timeStamp: timeStamp,
                        procName: foundProcessTable["Proc"],
                        processID: foundProcessTable["PID"],
                        processGUID: eventProcessGUID,
                        parentProcessGUID: foundProcessTable["ParentPGUID"])
                let key = timeStamp & "-" & process.procName & "-" &
                        process.processGUID & "-" & process.parentProcessGUID
                if not passGuid.contains(eventProcessGUID):
                    passGuid.incl(eventProcessGUID)
                if not addedProcess.contains(key):
                    processObjectTable[process.processGUID] = process
                    addedProcess.incl(key)

                    # Link child processes to their parents
                    for id, process in pairs(processObjectTable):
                        if process.parentProcessGUID in processObjectTable:
                            processObjectTable[
                                    process.parentProcessGUID].children.add(process)
    var outputStrSeq: seq[string] = @[]
    for id, process in pairs(processObjectTable):
        if not processObjectTable.contains(process.parentProcessGUID): # Root process
            outputStrSeq = concat(outputStrSeq, printIndentedProcessTree(process))

    if output != "":
        let f = open(output, fmWrite)
        defer: f.close()
        for line in outputStrSeq:
            f.writeLine(line)
        echo fmt"Saved File {output}"
        echo ""
    else:
        echo outputStrSeq.join("\n")
    discard

    if processesFoundCount == 0:
        echo "The process was not found."
        echo ""
        return

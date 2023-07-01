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

proc moveProcessObjectToChild(mvSourceProcess: processObject,
        searchProcess: var processObject,
                outputProcess: var processObject) =
    ## Procedure for moving a process object to a child process

    var searchChildrenProcess = searchProcess.children
    for idx, childProcess in searchChildrenProcess:
        if childProcess.processGUID == mvSourceProcess.parentProcessGUID:
            # Added to a separate table because assertion errors occur when the number of elements changes during iteration
            outputProcess.children[idx].children.add(mvSourceProcess)
            return
        else:
            var child = childProcess
            moveProcessObjectToChild(mvSourceProcess, child,
                    outputProcess.children[idx])

proc sysmonProcessTree(output: string = "", processGuid: string,
        quiet: bool = false, timeline: string) =
    ## Procedure for displaying Sysmon's process tree

    # Display the logo
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    echo ""
    echo "Running the Process Tree module"
    echo ""

    var stockedProcessObjectTable = newTable[string, processObject]()

    var processesFoundCount = 0
    var foundProcessTable = initTable[string, string]()
    var passGuid = initHashSet[string]()
    passGuid.incl(processGuid)
    var addedProcess = initHashSet[string]()

    for line in lines(timeline):
        var processObjectTable = newTable[string, processObject]()
        let
            jsonLine = parseJson(line)
            timeStamp = jsonLine["Timestamp"].getStr()
            channel = jsonLine["Channel"].getStr()
            eventId = jsonLine["EventID"].getInt()
            eventLevel = jsonLine["Level"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
        var eventProcessGUID = ""
        # Found a Sysmon 1 process creation event. This assumes info level events are enabled and there won't be more than one Sysmon 1 event for a process.
        if channel == "Sysmon" and eventId == 1 and (ruleTitle == "Proc Exec" or
                ruleTitle == "Proc Exec (Sysmon Alert)"):
            try:
                eventProcessGUID = jsonLine["Details"]["PGUID"].getStr()
            except KeyError:
                echo "Could not find the PGUID field. Make sure you ran Hayabusa with the standard profile."
            if eventProcessGUID in passGuid or jsonLine["Details"][
                                "ParentPGUID"].getStr() in passGuid:
                inc processesFoundCount
                let keysToExtract = {
                    #"CmdLine": "Cmdline",
                    "Proc": "Proc",
                    #"ParentCmdline": "ParentCmdline",
                    #"LogonID": "LID",
                    #"LogonGUID": "LGUID",
                    #"ParentPID": "ParentPID",
                    "ParentPGUID": "ParentPGUID",
                    #"Hashes": "Hashes"
                }

                for (foundKey, jsonKey) in keysToExtract:
                    try:
                        foundProcessTable[foundKey] = jsonLine["Details"][
                                jsonKey].getStr()
                    except KeyError:
                        foundProcessTable[foundKey] = ""
                # PID is an integer so getStr will fail
                try:
                    let eventProcessID = jsonLine["Details"]["PID"].getInt()
                    foundProcessTable["PID"] = $eventProcessID
                except KeyError:
                    foundProcessTable["PID"] = "No PID Found"

                let process = processObject(
                        timeStamp: timeStamp,
                        procName: foundProcessTable["Proc"],
                        processID: foundProcessTable["PID"],
                        processGUID: eventProcessGUID,
                        parentProcessGUID: foundProcessTable["ParentPGUID"])
                let key = timeStamp & "-" & process.processID
                if addedProcess.contains(key):
                    continue

                if not passGuid.contains(eventProcessGUID):
                    passGuid.incl(eventProcessGUID)
                if not addedProcess.contains(key):
                    processObjectTable[process.processGUID] = process
                    addedProcess.incl(key)
                # Link child processes to their parents
                if len(stockedProcessObjectTable) != 0 and
                            process.parentProcessGUID in stockedProcessObjectTable:
                    if process.parentProcessGUID == processGUID:
                        stockedProcessObjectTable[processGUID].children.add(process)
                    elif process.processGUID == processGUID:
                        stockedProcessObjectTable[processGUID] = process
                    else:
                        stockedProcessObjectTable[
                                process.parentProcessGUID].children.add(process)
                else:
                    stockedProcessObjectTable[process.processGUID] = process

    var outputStrSeq: seq[string] = @[]
    var outputProcessObjectTable = stockedProcessObjectTable

    # Sort process tree
    for process in stockedProcessObjectTable.keys:
        if process == processGuid:
            continue
        else:
            moveProcessObjectToChild(stockedProcessObjectTable[process],
                    stockedProcessObjectTable[processGuid],
                    outputProcessObjectTable[processGuid])

    # Display process tree for the specified process root
    if outputProcessObjectTable.hasKey(processGuid):
        outputStrSeq = concat(outputStrSeq, printIndentedProcessTree(
                outputProcessObjectTable[processGuid]))

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

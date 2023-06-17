type
    processObject = object
        timeStamp: string
        procName: string
        processGUID: string
        parentProcessGUID: string
        children: seq[processObject]

proc printIndentedProcessTree(p: processObject, indent: string = "",
        stairNum: int = 0) =
    ## プロセスオブジェクトからプロセスツリーを画面上に表示するためのプロシージャ
    echo(indent & p.procName & " (", p.timeStamp, "/", p.processGUID, "/",
            p.parentProcessGUID, ")")

    var childStairNum = stairNum + 1
    var childPreStairStr = ""
    var cnt = 0
    # プロセスの階層数に応じて、親階層がつながっていることを表現するための`  |`を付与する
    while childStairNum > cnt:
        childPreStairStr &= "  │"
        inc cnt
    for childNum, children in enumerate(p.children):
        # 子プロセスの表示を行う
        var childIndentStr = childPreStairStr
        if len(p.children) == childNum + 1:
            childIndentStr &= "  └"
        else:
            childIndentStr &= "  ├"
        printIndentedProcessTree(children, childIndentStr, childStairNum)

proc sysmonProcessTree(output: string, processGuid: string, quiet: bool = false,
        timeline: string) =
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

    for line in lines(timeline):
        let jsonLine = parseJson(line)
        let timeStamp = jsonLine["Timestamp"].getStr()
        let channel = jsonLine["Channel"].getStr()
        let eventId = jsonLine["EventID"].getInt()
        let eventLevel = jsonLine["Level"].getStr()
        var eventProcessGUID = ""
        # Found a Sysmon 1 process creation event. This assumes info level events are enabled and there won't be more than one Sysmon 1 event for a process.
        if channel == "Sysmon" and eventId == 1 and eventLevel == "info":
            try:
                eventProcessGUID = jsonLine["Details"]["PGUID"].getStr()
            except KeyError:
                echo "Could not find the PGUID field. Make sure you ran Hayabusa with the standard profile."
            if eventProcessGUID == processGuid:
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

                let process = processObject(timeStamp: timeStamp,
                        procName: foundProcessTable["Proc"],
                        processGUID: eventProcessGUID,
                        parentProcessGUID: foundProcessTable["ParentPGUID"])
                processObjectTable[process.processGUID] = process

                # Link child processes to their parents
                for id, process in pairs(processObjectTable):
                    if process.parentProcessGUID in processObjectTable:
                        processObjectTable[
                                process.parentProcessGUID].children.add(process)

    for id, process in pairs(processObjectTable):
        if not processObjectTable.contains(process.parentProcessGUID): # Root process
            printIndentedProcessTree(process)

    if processesFoundCount == 0:
        echo "The process was not found."
        echo ""
        return

    if processesFoundCount > 1:
        echo "There are more than 1 instance of this process which should not happen because it should be unique."
        echo "Exiting..."
        echo ""
        return

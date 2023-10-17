type
    processObject = object
        timeStamp: string
        procName: string
        processID: string
        processGUID: string
        parentProcessGUID: string
        children: seq[processObject]

proc `==`*(a, b: processObject): bool =
    return a.processGUID == b.processGUID

proc cmpTimeStamp(a, b: processObject): int =
  cmp(a.timeStamp, b.timeStamp)

proc printIndentedProcessTree(p: processObject, indent: string = "",
        stairNum: int = 0, need_sameStair: seq[bool], parentsStair: bool): seq[string] =
    ## プロセスオブジェクトからプロセスツリーを画面上に表示するためのプロシージャ

    var ret: seq[string] = @[]
    ret = @[indent & p.procName & " (" & p.timeStamp & " / " &
            p.processID &
            " / " & p.processGUID &
            " / " & p.parentProcessGUID &
            ")"]

    var childStairNum = stairNum + 1
    var childPreStairStr = ""
    var cnt = 1

    # プロセスの階層数に応じて、親階層がつながっていることを表現するための`  |`を付与する
    while childStairNum > cnt:
        if need_sameStair[cnt-1] and not parentsStair:
            childPreStairStr &= "  │"
        else:
            childPreStairStr &= "    "
        inc cnt
    for childNum, children in enumerate(p.children):
        # Display chile process
        var childIndentStr = childPreStairStr
        if len(p.children) == childNum + 1:
            childIndentStr &= "  └ "
        else:
            childIndentStr &= "  ├ "
        var next_need_sameStair = need_sameStair
        next_need_sameStair.add(len(children.children) > 1)
        ret = concat(ret, printIndentedProcessTree(children, childIndentStr,
                childStairNum, next_need_sameStair, childNum + 1 == len(p.children)))
    return ret

proc moveProcessObjectToChild(mvSource: processObject,
        target: var processObject, output: var processObject) =
    ## Procedure for moving a process object to a child process
    for i, childProc in target.children:
        let s = output.children.len
        if childProc.processGUID == mvSource.parentProcessGUID and output.children.len - 1 >= i:
            # Added to a separate table because assertion errors occur when the number of elements changes during iteration
            output.children[i].children.add(mvSource)
            output.children[i].children = sorted(deduplicate(output.children[i].children), cmpTimeStamp)
            return
        else:
            if output.children.len - 1 < i:
                continue
            var c = childProc
            moveProcessObjectToChild(mvSource, c, output.children[i])

proc isGUID(processGuid: string): bool =
    let guidRegex = re(r"^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$")
    return processGuid.find(guidRegex) != -1

proc createProcessObj(jsonLine: JsonNode, isParent: bool): processObject =
    var foundProcTbl = initTable[string, string]()
    if isParent:
        try:
            foundProcTbl["ParentImage"] = jsonLine["ExtraFieldInfo"][
                    "ParentImage"].getStr("N/A")
        except KeyError:
            foundProcTbl["ParentImage"] = "N/A"
        return processObject(
                           timeStamp: "N/A",
                           procName: foundProcTbl["ParentImage"],
                           processID: $jsonLine["Details"]["ParentPID"].getInt(),
                           processGUID: jsonLine["Details"][
                                   "ParentPGUID"].getStr("N/A"),
                           parentProcessGUID: "N/A")
    try:
        let eventProcessID = jsonLine["Details"]["PID"].getInt()
        foundProcTbl["PID"] = $eventProcessID
    except KeyError:
        foundProcTbl["PID"] = "No PID Found"
    return processObject(
            timeStamp: jsonLine["Timestamp"].getStr("N/A"),
            procName: jsonLine["Details"]["Proc"].getStr("N/A"),
            processID: foundProcTbl["PID"],
            processGUID: jsonLine["Details"]["PGUID"].getStr("N/A"),
            parentProcessGUID: jsonLine["Details"]["ParentPGUID"].getStr("N/A"))

proc sysmonProcessTree(output: string = "", processGuid: string,
        quiet: bool = false, timeline: string) =
    ## Procedure for displaying Sysmon's process tree
    let startTime = epochTime()
    if not quiet:
        # Display the logo
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    if not isGUID(processGuid):
        echo "The format of the Process GUID specified with the -p option is invalid. Please specify a valid Process GUID."
        quit(1)

    echo ""
    echo "Running the Process Tree module"
    echo ""

    var stockedProcObjTbl = newTable[string, processObject]()
    var parentsProcStocks = newSeq[string]()
    var parentPGUIDTbl = newTable[string, string]()
    var procFoundCount = 0
    var oldestProc: processObject
    var passGuid = initHashSet[string]()
    passGuid.incl(processGuid)

    for line in lines(timeline):
        let
            jsonLine = parseJson(line)
            timeStamp = jsonLine["Timestamp"].getStr("N/A")
            channel = jsonLine["Channel"].getStr("N/A")
            eventId = jsonLine["EventID"].getInt(0)
            ruleTitle = jsonLine["RuleTitle"].getStr("N/A")

        # Found a Sysmon 1 process creation event.
        # This assumes info level events are enabled and there won't be more than one Sysmon 1 event for a process.
        if channel == "Sysmon" and eventId == 1 and (ruleTitle == "Proc Exec" or
                ruleTitle == "Proc Exec (Sysmon Alert)"):
            if jsonLine["Details"]["PGUID"].getStr("N/A") in passGuid or
                    jsonLine["Details"]["ParentPGUID"].getStr("N/A") in passGuid:
                let obj = createProcessObj(jsonLine, false)
                if procFoundCount == 0:
                    let parentObj = createProcessObj(jsonLine, true)
                    stockedProcObjTbl[parentObj.processGUID] = parentObj
                    stockedProcObjTbl[parentObj.processGUID].children.add(obj)
                    parentPGUIDTbl[parentObj.processGUID] = obj.processGUID
                    oldestProc = parentObj
                passGuid.incl(obj.processGUID)
                passGuid.incl(obj.parentProcessGUID)
                # Link child processes to their parents
                stockedProcObjTbl[obj.processGUID] = obj
                if obj.parentProcessGUID == processGUID:
                    stockedProcObjTbl[processGUID].children.add(obj)
                elif obj.parentProcessGUID in stockedProcObjTbl:
                    stockedProcObjTbl[obj.parentProcessGUID].children.add(obj)
                parentPGUIDTbl[obj.parentProcessGUID] = obj.processGUID
                inc procFoundCount
            elif procFoundCount == 0:
                parentsProcStocks.add(line)

    if procFoundCount == 0:
        echo "The process was not found."
        echo ""
        return

    # search ancestor process
    var parentsKey = ""
    for i in countdown(len(parentsProcStocks) - 1, 0):
        let jsonLine = parseJson(parentsProcStocks[i])
        if jsonLine["Details"]["PGUID"].getStr("N/A") in passGuid:
            let obj = createProcessObj(jsonLine, false)
            let child = stockedProcObjTbl[parentPGUIDTbl[obj.processGUID]]
            passGuid.incl(obj.processGUID)
            passGuid.incl(obj.parentProcessGUID)
            stockedProcObjTbl[obj.processGUID] = obj
            stockedProcObjTbl[obj.processGUID].children.add(child)
            parentPGUIDTbl[obj.parentProcessGUID] = obj.processGUID
            parentsKey = obj.processGUID
            oldestProc = obj
            if jsonLine["Details"]["ParentPGUID"].getStr("N/A") in passGuid:
                let parentObj = createProcessObj(jsonLine, true)
                stockedProcObjTbl[parentObj.processGUID] = parentObj
                stockedProcObjTbl[parentObj.processGUID].children.add(obj)
                oldestProc = parentObj
    if processGuid notin stockedProcObjTbl:
        echo "The process was not found."
        echo ""
        return

    # Sort process tree
    var target = processGuid
    if parentsKey != "":
        target = parentsKey
    if oldestProc == stockedProcObjTbl[target]:
        oldestProc = stockedProcObjTbl[target]
    else:
        oldestProc.children.add(stockedProcObjTbl[target])
        oldestProc.children = sorted(deduplicate(oldestProc.children), cmpTimeStamp)

    var outProc = oldestProc
    for mvSrcProc in stockedProcObjTbl.values:
        moveProcessObjectToChild(mvSrcProc, oldestProc, outProc)

    # Display process tree for the specified process root
    var outStrSeq: seq[string] = @[]
    let root_multi_child = outProc.children.len() > 1
    outStrSeq = concat(outStrSeq, printIndentedProcessTree(outProc,
            need_sameStair = @[root_multi_child], parentsStair = false))

    if output != "":
        let f = open(output, fmWrite)
        defer: f.close()
        for line in outStrSeq:
            f.writeLine(line)
        echo fmt"Saved File {output}"
        echo ""
    else:
        for line in outStrSeq:
            if line.contains(fmt" / {processGuid} / "):
                styledEcho(fgGreen, line)
            else:
                echo line
        echo ""

    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " &
            $seconds & " seconds"
    echo ""
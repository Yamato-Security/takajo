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

proc moveProcessObjectToChild(mvSourceProcess: processObject,
        searchProcess: var processObject,
                outputProcess: var processObject) =
    ## Procedure for moving a process object to a child process

    var searchChildrenProcess = searchProcess.children
    for idx, childProcess in searchChildrenProcess:
        if childProcess.processGUID == mvSourceProcess.parentProcessGUID:
            # Added to a separate table because assertion errors occur when the number of elements changes during iteration
            outputProcess.children[idx].children.add(mvSourceProcess)
            outputProcess.children[idx].children = deduplicate(outputProcess.children[idx].children)
            return
        else:
            var child = childProcess
            moveProcessObjectToChild(mvSourceProcess, child,
                    outputProcess.children[idx])

proc isGUID(processGuid: string): bool =
    let guidRegex = re(r"^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$")
    return processGuid.find(guidRegex) != -1

proc createProcessObj(jsonLine:JsonNode): processObject =
    var foundProcTbl = initTable[string, string]()
    for key in ["Proc", "ParentPGUID"]:
        try:
            foundProcTbl[key] = jsonLine["Details"][key].getStr()
        except KeyError:
            foundProcTbl[key] = ""
    try:
        let eventProcessID = jsonLine["Details"]["PID"].getInt()
        foundProcTbl["PID"] = $eventProcessID
    except KeyError:
        foundProcTbl["PID"] = "No PID Found"

    return processObject(
            timeStamp: jsonLine["Timestamp"].getStr(),
            procName: foundProcTbl["Proc"],
            processID: foundProcTbl["PID"],
            processGUID: jsonLine["Details"]["PGUID"].getStr(),
            parentProcessGUID: foundProcTbl["ParentPGUID"])

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
    var passGuid = initHashSet[string]()
    passGuid.incl(processGuid)

    for line in lines(timeline):
        let
            jsonLine = parseJson(line)
            timeStamp = jsonLine["Timestamp"].getStr()
            channel = jsonLine["Channel"].getStr()
            eventId = jsonLine["EventID"].getInt()
            ruleTitle = jsonLine["RuleTitle"].getStr()

        # Found a Sysmon 1 process creation event.
        # This assumes info level events are enabled and there won't be more than one Sysmon 1 event for a process.
        if channel == "Sysmon" and eventId == 1 and (ruleTitle == "Proc Exec" or ruleTitle == "Proc Exec (Sysmon Alert)"):
            if jsonLine["Details"]["PGUID"].getStr() in passGuid or jsonLine["Details"]["ParentPGUID"].getStr() in passGuid:
                inc procFoundCount
                let obj = createProcessObj(jsonLine)
                let key = timeStamp & "-" & obj.processID
                passGuid.incl(obj.processID)
                passGuid.incl(obj.parentProcessGUID)
                # Link child processes to their parents
                if len(stockedProcObjTbl) != 0 and obj.parentProcessGUID in stockedProcObjTbl:
                    if obj.processGUID == processGUID:
                        stockedProcObjTbl[processGUID] = obj
                    elif obj.parentProcessGUID == processGUID:
                        stockedProcObjTbl[processGUID].children.add(obj)
                    else:
                        stockedProcObjTbl[obj.parentProcessGUID].children.add(obj)
                else:
                    stockedProcObjTbl[obj.processGUID] = obj
                parentPGUIDTbl[obj.parentProcessGUID] = obj.processGUID
            elif procFoundCount == 0:
                parentsProcStocks.add(line)

    if procFoundCount == 0:
        echo "The process was not found."
        echo ""
        return

    # search ancestor process
    var parentsExist = false
    var parentsKey = ""

    for i in countdown(len(parentsProcStocks) - 1, 0):
        let jsonLine = parseJson(parentsProcStocks[i])
        if jsonLine["Details"]["PGUID"].getStr() in passGuid:
            let obj = createProcessObj(jsonLine)
            passGuid.incl(obj.processGUID)
            passGuid.incl(obj.parentProcessGUID)
            stockedProcObjTbl[obj.processGUID] = obj
            stockedProcObjTbl[obj.processGUID].children.add(stockedProcObjTbl[parentPGUIDTbl[obj.processGUID]])
            parentPGUIDTbl[obj.parentProcessGUID] = obj.processGUID
            parentsExist = true
            parentsKey = obj.processGUID

    if processGuid notin stockedProcObjTbl:
      echo "The process was not found."
      echo ""
      return

    # Sort process tree
    var outProcObjTbl = stockedProcObjTbl
    for pguid in stockedProcObjTbl.keys:
        if ((not parentsExist) and pguid == processGuid) or (parentsExist and pguid == parentsKey):
            continue
        if parentsExist:
            moveProcessObjectToChild(stockedProcObjTbl[pguid], stockedProcObjTbl[parentsKey], outProcObjTbl[parentsKey])
        else:
            moveProcessObjectToChild(stockedProcObjTbl[pguid], stockedProcObjTbl[processGuid], outProcObjTbl[processGuid])

    # Display process tree for the specified process root
    var outStrSeq: seq[string] = @[]
    if parentsKey != "":
        let root_multi_child = outProcObjTbl[parentsKey].children.len() > 1
        outStrSeq = concat(outStrSeq, printIndentedProcessTree(outProcObjTbl[parentsKey], need_sameStair = @[root_multi_child], parentsStair = false))
    elif outProcObjTbl.hasKey(processGuid):
        outStrSeq = concat(outStrSeq, printIndentedProcessTree(outProcObjTbl[processGuid], need_sameStair = @[false], parentsStair = false))

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

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
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

proc sysmonProcessTree(output: string = "", processGuid: string,
        quiet: bool = false, timeline: string) =
    ## Procedure for displaying Sysmon's process tree

    # Display the logo
    if not quiet:
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

    var stockedProcessObjectTable = newTable[string, processObject]()

    var processesFoundCount = 0
    var foundProcessTable = initTable[string, string]()
    var passGuid = initHashSet[string]()
    passGuid.incl(processGuid)
    var addedProcess = initHashSet[string]()

    var parentsProcessStocks = newSeq[string]()
    var parentsProcesStockDisableFlag = false
    var parentProcessGUIDTable = newTable[string, string]()
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
                parentsProcesStockDisableFlag = true
                inc processesFoundCount
                let keysToExtract = {
                    "Proc": "Proc",
                    "ParentPGUID": "ParentPGUID",
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
                if not passGuid.contains(process.parentProcessGUID):
                    passGuid.incl(process.parentProcessGUID)
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
                parentProcessGUIDTable[process.parentProcessGUID] = process.processGUID
            else:
                if not parentsProcesStockDisableFlag:
                    parentsProcessStocks.add(line)
    # search ancestor process
    var parents_exist = false
    var parents_key = ""

    # echo parentsProcessStocks.len
    parentsProcessStocks.reverse()
    for line in parentsProcessStocks:
        let
            jsonLine = parseJson(line)
            timeStamp = jsonLine["Timestamp"].getStr()
            channel = jsonLine["Channel"].getStr()
            eventId = jsonLine["EventID"].getInt()
            eventLevel = jsonLine["Level"].getStr()
            ruleTitle = jsonLine["RuleTitle"].getStr()
        var eventProcessGUID = ""
        try:
            eventProcessGUID = jsonLine["Details"]["PGUID"].getStr()
        except KeyError:
            echo "Could not find the PGUID field. Make sure you ran Hayabusa with the standard profile."
        if eventProcessGUID in passGuid:
            var processObjectTable = newTable[string, processObject]()
            let keysToExtract = {
                "Proc": "Proc",
                "ParentPGUID": "ParentPGUID",
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
            if not passGuid.contains(eventProcessGUID):
                passGuid.incl(eventProcessGUID)
            if not passGuid.contains(process.parentProcessGUID):
                passGuid.incl(process.parentProcessGUID)
            if not addedProcess.contains(key):
                processObjectTable[process.processGUID] = process
                addedProcess.incl(key)
            stockedProcessObjectTable[process.processGUID] = process
            stockedProcessObjectTable[process.processGUID].children.add(
                    stockedProcessObjectTable[parentProcessGUIDTable[
                            process.processGUID]])
            parentProcessGUIDTable[process.parentProcessGUID] = process.processGUID
            parents_exist = true
            parents_key = process.processGUID

    if processGuid notin stockedProcessObjectTable:
      echo "The process was not found."
      echo ""
      return

    var outputStrSeq: seq[string] = @[]
    var outputProcessObjectTable = stockedProcessObjectTable

    # Sort process tree
    for process in stockedProcessObjectTable.keys:
        if ((not parents_exist) and process == processGuid) or ((
                parents_exist) and process == parents_key):
            continue

        if parents_exist:
            moveProcessObjectToChild(stockedProcessObjectTable[process],
                    stockedProcessObjectTable[parents_key],
                    outputProcessObjectTable[parents_key])
        else:
            moveProcessObjectToChild(stockedProcessObjectTable[process],
                stockedProcessObjectTable[processGuid],
                outputProcessObjectTable[processGuid])


    # Display process tree for the specified process root
    if parents_key != "":
        let root_multi_child = outputProcessObjectTable[parents_key].children.len() > 1
        outputStrSeq = concat(outputStrSeq, printIndentedProcessTree(
                outputProcessObjectTable[parents_key], need_sameStair = @[
                        root_multi_child], parentsStair = false
            ))
    elif outputProcessObjectTable.hasKey(processGuid):
        outputStrSeq = concat(outputStrSeq, printIndentedProcessTree(
                outputProcessObjectTable[processGuid], need_sameStair = @[
                        false], parentsStair = false))

    if output != "":
        let f = open(output, fmWrite)
        defer: f.close()
        for line in outputStrSeq:
            f.writeLine(line)
        echo fmt"Saved File {output}"
        echo ""
    else:
        for line in outputStrSeq:
            if line.contains(fmt" / {processGuid} / "):
                styledEcho(fgGreen, line)
            else:
                echo line
    discard

    if processesFoundCount == 0:
        echo "The process was not found."
        echo ""
        return
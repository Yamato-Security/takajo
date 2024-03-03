proc stackComputers(level: string = "informational", sourceComputers: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Computers", "the Computer field as well as show alert information", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = true
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        var stackKey = x.Computer
        if sourceComputers:
            stackKey = getJsonValue(x.Details, @["SrcComp"])
        return (stackKey, @[])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "Computer", stack, isMinColumns=true)
    outputElapsedTime(startTime)
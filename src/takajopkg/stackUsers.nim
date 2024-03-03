proc stackUsers(level: string = "informational", sourceUsers: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Users", "the User field as well as show alert information", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = true
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        var stackKey = getJsonValue(x.Details, @["User"])
        if stackKey.len() == 0:
            let key = if sourceUsers: "SrcUser" else: "TgtUser"
            stackKey = getJsonValue(x.Details, @[key])
        return (stackKey, @[])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "User", stack, @[], isMinColumns=true)
    outputElapsedTime(startTime)
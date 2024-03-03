proc stackServices(level: string = "informational", ignoreSystem: bool = false, ignoreSecurity: bool = false,output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Services", "service names and paths from System 7045 and Security 4697 events", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = (x.EventID == 7045 and not ignoreSystem and x.Channel == "Sys") or (x.EventID == 4697 and not ignoreSecurity and x.Channel == "Sec")
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        let svc = x.Details["Svc"].getStr("N/A")
        let pat = x.Details["Path"].getStr("N/A")
        let stackKey = svc & " -> " & pat
        return (stackKey, @[svc, pat])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "Service", stack, @["ServiceName", "Path"])
    outputElapsedTime(startTime)
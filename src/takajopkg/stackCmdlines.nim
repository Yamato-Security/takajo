proc stackCmdlines(level: string = "low", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Cmdlines", "executed command lines from Sysmon 1 and Security 4688 events", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = (x.EventID == 1 and x.Channel == "Sysmon" and not ignoreSysmon) or (x.EventID == 4688 and x.Channel == "Sec" and not ignoreSecurity)
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (x.Details["Cmdline"].getStr("N/A"), @[])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "Cmdline", stack)
    outputElapsedTime(startTime)
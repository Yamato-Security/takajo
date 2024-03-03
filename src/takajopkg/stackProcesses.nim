proc stackProcesses(level: string = "low", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Processes", "executed processes from Sysmon 1 and Security 4688 events", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = (x.EventID == 1 and not ignoreSysmon and x.Channel == "Sysmon") or (x.EventID == 4688 and not ignoreSecurity and x.Channel == "Sec")
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (x.Details["Proc"].getStr("N/A"), @[])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "Process", stack)
    outputElapsedTime(startTime)
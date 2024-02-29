proc stackProcesses(level: string = "low", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Processes", "executed processes from Sysmon 1 and Security 4688 events", timeline)
    var
        bar: SuruBar = initSuruBar()
        stack = initTable[string, StackRecord]()
    bar[0].total = totalLines
    bar.setup()
    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()
        let eventId = jsonLine.EventID
        let channel = jsonLine.Channel
        if (eventId == 1 and not ignoreSysmon and channel == "Sysmon") or
           (eventId == 4688 and not ignoreSecurity and channel == "Sec"):
            let stackKey = jsonLine.Details["Proc"].getStr("N/A")
            stackResult(stackKey, stack, level, jsonLine)
    bar.finish()
    outputResult(output, "Process", stack)
    outputElapsedTime(startTime)
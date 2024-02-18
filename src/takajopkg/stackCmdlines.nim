proc stackCmdlines(level: string = "low", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Cmdlines", "executed command lines", timeline)
    var
        bar: SuruBar = initSuruBar()
        stack = initTable[string, StackRecord]()

    bar[0].total = totalLines
    bar.setup()
    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine = parseJson(line)
        let eventId = jsonLine["EventID"].getInt(0)
        let channel = jsonLine["Channel"].getStr("N/A")
        if (eventId == 1 and not ignoreSysmon and channel == "Sysmon") or
           (eventId == 4688 and not ignoreSecurity and channel == "Sec"):
            let stackKey = jsonLine["Details"]["Cmdline"].getStr("N/A")
            stackResult(stackKey, level, jsonLine, stack)
    bar.finish()
    outputResult(output, "Cmdline", stack)
    outputElasptedTime(startTime)
proc stackProcesses(ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline)
    let totalLines = countJsonlAndStartMsg("Processes", "executed processes", timeline)
    var
        bar: SuruBar = initSuruBar()
        stackProcesses = initCountTable[string]()
        stackCount = initTable[string, CountTable[string]]()

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
            let process = jsonLine["Details"]["Proc"].getStr("N/A")
            stackProcesses.inc(process)
            stackRuleCount(jsonLine, stackCount)
    bar.finish()
    outputResult(output, stackProcesses, stackCount)
    outputElasptedTime(startTime)
proc stackServices(level: string = "informational", ignoreSysmon: bool = false, ignoreSecurity: bool = false,output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Services", "service names and paths", timeline)

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
        if (eventId == 7040 and not ignoreSysmon and channel == "Sysmon") or
           (eventId == 4697 and not ignoreSecurity and channel == "Sec"):
            let svc = jsonLine["Details"]["Svc"].getStr("N/A")
            let path = jsonLine["Details"]["Path"].getStr("N/A")
            let stackKey = svc & " -> " & path
            stackResult(stackKey, level, jsonLine, stack)
    bar.finish()
    outputResult(output, "Service", stack)
    outputElasptedTime(startTime)
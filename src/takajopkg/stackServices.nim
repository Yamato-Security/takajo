proc stackServices(level: string = "informational", ignoreSystem: bool = false, ignoreSecurity: bool = false,output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Services", "service names and paths from System 7045 and Security 4697 events", timeline)

    var
        bar: SuruBar = initSuruBar()
        stack = initTable[string, StackRecord]()

    bar[0].total = totalLines
    bar.setup()
    # Loop through JSON lines
    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLine:HayabusaJson = line.fromJson(HayabusaJson)
        let eventId = jsonLine.EventID
        let channel = jsonLine.Channel
        if (eventId == 7045 and not ignoreSystem and channel == "Sys") or
           (eventId == 4697 and not ignoreSecurity and channel == "Sec"):
            let svc = jsonLine.Details["Svc"].getStr("N/A")
            let path = jsonLine.Details["Path"].getStr("N/A")
            let stackKey = svc & " -> " & path
            stackResult(stackKey, stack, level, jsonLine, @[svc, path])
    bar.finish()
    outputResult(output, "Service", stack, @["ServiceName", "Path"])
    outputElapsedTime(startTime)
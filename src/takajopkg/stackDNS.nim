proc stackDNS(level: string = "informational", output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("DNS", "DNS queries and responses from Sysmon 22 events", timeline)
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
        if (eventId == 22 and channel == "Sysmon"):
            let prog = jsonLine.Details["Proc"].getStr("N/A")
            let query = jsonLine.Details["Query"].getStr("N/A")
            let res = jsonLine.Details["Result"].getStr("N/A")
            let stackKey = prog & " -> " & query & " -> " & res
            stackResult(stackKey, stack, level, jsonLine, @[prog, query, res])
    bar.finish()
    outputResult(output, "DNS", stack, @["Image", "Query", "Result"])
    outputElapsedTime(startTime)
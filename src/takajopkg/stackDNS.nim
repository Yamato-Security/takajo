proc stackDNS(output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline)
    let totalLines = countJsonlAndStartMsg("DNS", "DNS queries and responses", timeline)
    var
        bar: SuruBar = initSuruBar()
        stackDNS = initCountTable[string]()
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
        if (eventId == 22 and channel == "Sysmon"):
            let prog = jsonLine["Details"]["Proc"].getStr("N/A")
            let query = jsonLine["Details"]["Query"].getStr("N/A")
            let res = jsonLine["Details"]["Result"].getStr("N/A")
            let result = prog & " -> " & query & " -> " & res
            stackDNS.inc(result)
            stackRuleCount(jsonLine, stackCount)

    bar.finish()
    outputResult(output, stackDNS, stackCount)
    outputElasptedTime(startTime)
proc stackComputers(level: string = "informational", output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Computers", "Alerts count each Computers", timeline)
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
        let stackKey = jsonLine.Computer
        stackResult(stackKey, stack, level, jsonLine)
    bar.finish()
    outputResult(output, "Computer", stack, isStackComputer=true)
    outputElapsedTime(startTime)
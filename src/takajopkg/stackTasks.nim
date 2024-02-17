proc decodeEntity(txt: string): string =
   return txt.replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;","\"").replace("&apos;","'")

proc stackTasks(ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline)
    let totalLines = countJsonlAndStartMsg("Tasks", "new scheduled tasks", timeline)
    var
        bar: SuruBar = initSuruBar()
        stackTasks = initCountTable[string]()
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
        if eventId == 4698 and channel == "Sec":
            let user = jsonLine["Details"]["User"].getStr("N/A")
            let name = jsonLine["Details"]["Name"].getStr("N/A")
            let content = jsonLine["Details"]["Content"].getStr("N/A").replace("\\r\\n", "")
            let node = parseXml(content)
            let commands = node.findAll("Command")
            var commandAndArgs = ""
            if len(commands) > 0:
                commandAndArgs = $commands[0]
                commandAndArgs = commandAndArgs.replace("<Command>", "").replace("</Command>","")
            let arguments = node.findAll("Arguments")
            if len(arguments) > 0:
                commandAndArgs = commandAndArgs & " " & $arguments[0]
                commandAndArgs = commandAndArgs.replace("<Arguments>", "").replace("</Arguments>","")
            let result = user & " -> "  & name & " -> " & decodeEntity(commandAndArgs)
            stackTasks.inc(result)
            stackRuleCount(jsonLine, stackCount)
    bar.finish()
    outputResult(output, stackTasks, stackCount)
    outputElasptedTime(startTime)
proc decodeEntity*(txt: string): string =
   return txt.replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;","\"").replace("&apos;","'")

proc stackTasks(level: string = "informational", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Tasks", "new scheduled tasks from Security 4698 events", timeline)
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
        if eventId == 4698 and channel == "Sec":
            let user = jsonLine.Details["User"].getStr("N/A")
            let name = jsonLine.Details["Name"].getStr("N/A")
            let content = jsonLine.Details["Content"].getStr("N/A").replace("\\r\\n", "")
            let node = parseXml(content)
            let commands = node.findAll("Command")
            var command = ""
            var args = ""
            if len(commands) > 0:
                command = $commands[0]
                command = command.replace("<Command>", "").replace("</Command>","")
            let arguments = node.findAll("Arguments")
            if len(arguments) > 0:
                args = $arguments[0]
                args = args.replace("<Arguments>", "").replace("</Arguments>","")
            let stackKey = user & " -> "  & name & " -> " & decodeEntity(command & " " & args)
            stackResult(stackKey, stack, level, jsonLine, @[name, command, args])
    bar.finish()
    outputResult(output, "Task", stack, @["TaskName", "Command", "Arguments"])
    outputElapsedTime(startTime)
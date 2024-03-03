proc decodeEntity*(txt: string): string =
   return txt.replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;","\"").replace("&apos;","'")

proc stackTasks(level: string = "informational", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Tasks", "new scheduled tasks from Security 4698 events", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = x.EventID == 4698 and x.Channel == "Sec"
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        let user = x.Details["User"].getStr("N/A")
        let name = x.Details["Name"].getStr("N/A")
        let content = x.Details["Content"].getStr("N/A").replace("\\r\\n", "")
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
        return (stackKey, @[name, command, args])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "Task", stack, @["TaskName", "Command", "Arguments"])
    outputElapsedTime(startTime)
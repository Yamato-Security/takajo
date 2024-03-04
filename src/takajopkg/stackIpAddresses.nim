proc stackIpAddresses(level: string = "informational", targetIpAddresses: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("IpAddresses", "the IpAddress field as well as show alert information", timeline)
    let key = if targetIpAddresses: "TgtIP" else: "SrcIP"
    let eventFilter = proc(x: HayabusaJson): bool =
        let ip = getJsonValue(x.Details, @[key])
        return ip != "127.0.0.1" and ip != "::1"
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (getJsonValue(x.Details, @[key]), @[])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "IpAddress", stack, @[], isMinColumns=true)
    outputElapsedTime(startTime)
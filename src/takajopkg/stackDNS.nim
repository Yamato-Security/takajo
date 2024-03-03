proc stackDNS(level: string = "informational", output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("DNS", "DNS queries and responses from Sysmon 22 events", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = x.EventID == 22 and x.Channel == "Sysmon"
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        let pro = x.Details["Proc"].getStr("N/A")
        let que = x.Details["Query"].getStr("N/A")
        let res = x.Details["Result"].getStr("N/A")
        let stackKey = pro & "->" & que & "->" & res
        return (stackKey, @[pro, que, res])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "DNS", stack, @["Image", "Query", "Result"])
    outputElapsedTime(startTime)
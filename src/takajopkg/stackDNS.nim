const StackDNSMsg = "This command will stack the DNS queries and responses from Sysmon 22 events."

type
  StackDNSCmd* = ref object of AbstractCmd
    level* :string
    header* = @["Image", "Query", "Result"]
    stack* = initTable[string, StackRecord]()

method filter*(self: StackDNSCmd, x: HayabusaJson):bool =
    return x.EventID == 22 and x.Channel == "Sysmon"

method analyze*(self: StackDNSCmd, x: HayabusaJson)=
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        let pro = x.Details["Proc"].getStr("N/A")
        let que = x.Details["Query"].getStr("N/A")
        let res = x.Details["Result"].getStr("N/A")
        let stackKey = pro & "->" & que & "->" & res
        return (stackKey, @[pro, que, res])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x, otherColumn)

method resultOutput*(self: StackDNSCmd)=
    outputResult(self.output, self.name, self.stack, self.header)

proc stackDNS(level: string = "informational", skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackDNSCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name: "DNS",
                msg: StackDNSMsg)
    cmd.analyzeJSONLFile()
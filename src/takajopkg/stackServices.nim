const StackServicesMsg = "This command will stack the service names and paths from System 7045 and Security 4697 events"

type
  StackServicesCmd* = ref object of AbstractCmd
    level* :string
    header* = @["ServiceName", "Path"]
    stack* = initTable[string, StackRecord]()
    ignoreSystem:bool
    ignoreSecurity:bool

method filter*(self: StackServicesCmd, x: HayabusaJson):bool =
    return (x.EventID == 7045 and not self.ignoreSystem and x.Channel == "Sys") or (x.EventID == 4697 and not self.ignoreSecurity and x.Channel == "Sec")

method analyze*(self: StackServicesCmd, x: HayabusaJson)=
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        let svc = x.Details["Svc"].getStr("N/A")
        let pat = x.Details["Path"].getStr("N/A")
        let stackKey = svc & " -> " & pat
        return (stackKey, @[svc, pat])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x, otherColumn=otherColumn)

method resultOutput*(self: StackServicesCmd)=
    outputResult(self, self.stack, self.header)

proc stackServices(level: string = "informational", ignoreSystem: bool = false, ignoreSecurity: bool = false, skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackServicesCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name: "Stack Services",
                msg: StackServicesMsg,
                ignoreSystem: ignoreSystem,
                ignoreSecurity: ignoreSecurity)
    cmd.analyzeJSONLFile()
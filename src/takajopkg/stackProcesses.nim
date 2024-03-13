const StackProcessesMsg = "This command will stack the executed processes from Sysmon 1 and Security 4688 events."

type
  StackProcessesCmd* = ref object of AbstractCmd
    level* :string
    stack* = initTable[string, StackRecord]()
    ignoreSysmon:bool
    ignoreSecurity:bool

method filter*(self: StackProcessesCmd, x: HayabusaJson):bool =
    return (x.EventID == 1 and not self.ignoreSysmon and x.Channel == "Sysmon") or (x.EventID == 4688 and not self.ignoreSecurity and x.Channel == "Sec")

method analyze*(self: StackProcessesCmd, x: HayabusaJson)=
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (x.Details["Proc"].getStr("N/A"), @[""])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackProcessesCmd) =
    outputResult(self.output, self.name, self.stack, isMinColumns=true)

proc stackProcesses(level: string = "low", ignoreSysmon: bool = false, ignoreSecurity: bool = false, skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackProcessesCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name: "Processes",
                msg: StackProcessesMsg,
                ignoreSysmon: ignoreSysmon,
                ignoreSecurity: ignoreSecurity)
    cmd.analyzeJSONLFile()
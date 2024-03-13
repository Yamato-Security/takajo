type
  StackCmdlineCmd* = ref object of AbstractCmd
    level* :string
    header* = @[""]
    stack* = initTable[string, StackRecord]()
    ignoreSysmon:bool
    ignoreSecurity:bool

method filter*(self: StackCmdlineCmd, x: HayabusaJson):bool =
    return (x.EventID == 1 and x.Channel == "Sysmon" and not self.ignoreSysmon) or (x.EventID == 4688 and x.Channel == "Sec" and not self.ignoreSecurity)

method analyze*(self: StackCmdlineCmd, x: HayabusaJson) =
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (x.Details["Cmdline"].getStr("N/A"), @[""])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackCmdlineCmd)=
    outputResult(self.output, self.name, self.stack)

proc stackCmdlines(level: string = "low", ignoreSysmon: bool = false, ignoreSecurity: bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackCmdlineCmd(
                level: level,
                timeline: timeline,
                output: output,
                name:"Cmdlines",
                msg: "executed command lines from Sysmon 1 and Security 4688 events",
                ignoreSysmon: ignoreSysmon,
                ignoreSecurity: ignoreSecurity)
    cmd.analyzeJSONLFile()
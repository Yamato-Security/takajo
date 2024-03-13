const StackComputerMsg = "This command will stack the Computer (default) or SrcComp fields as well as show alert information."

type
  StackComputersCmd* = ref object of AbstractCmd
    level* :string
    header* = @[""]
    stack* = initTable[string, StackRecord]()
    sourceComputers:bool

method filter*(self: StackComputersCmd, x: HayabusaJson):bool =
    return true

method analyze*(self: StackComputersCmd, x: HayabusaJson)=
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        var stackKey = x.Computer
        if self.sourceComputers:
            stackKey = getJsonValue(x.Details, @["SrcComp"])
        return (stackKey, @[""])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackComputersCmd)=
    outputResult(self.output, self.name, self.stack, isMinColumns=true)

proc stackComputers(level: string = "informational", sourceComputers: bool = false, skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackComputersCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name: "Computers",
                msg: StackComputerMsg,
                sourceComputers: sourceComputers)
    cmd.analyzeJSONLFile()
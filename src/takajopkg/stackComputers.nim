const StackComputerMsg = "This command will stack the Computer (default) or SrcComp fields as well as show alert information."

type
  StackComputersCmd* = ref object of AbstractCmd
    level*: string
    stack* = initTable[string, StackRecord]()
    sourceComputers: bool

method filter*(self: StackComputersCmd, x: HayabusaJson): bool =
  return true

method analyze*(self: StackComputersCmd, x: HayabusaJson) =
  let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
    var stackKey = x.Computer
    if self.sourceComputers:
      stackKey = getJsonValue(x.Details, @["SrcComp"])
    return (stackKey, @[""])
  let (stackKey, _) = getStackKey(x)
  stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackComputersCmd) =
  outputResult(self, self.stack, isMinColumns = true)

proc stackComputers(level: string = "informational",
    sourceComputers: bool = false, skipProgressBar: bool = false,
    output: string = "", quiet: bool = false, timeline: string) =
  checkArgs(quiet, timeline, level)
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = StackComputersCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                name: "stack-computers",
                msg: StackComputerMsg,
                sourceComputers: sourceComputers)
    cmd.analyzeJSONLFile()

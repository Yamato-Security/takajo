const StackCmdlineMsg = "This command will stack executed command lines from Sysmon 1 and Security 4688 events."

type
  StackCmdlineCmd* = ref object of AbstractCmd
    level*: string
    stack* = initTable[string, StackRecord]()
    ignoreSysmon: bool
    ignoreSecurity: bool

method filter*(self: StackCmdlineCmd, x: HayabusaJson): bool =
  return (x.EventID == 1 and x.Channel == "Sysmon" and not self.ignoreSysmon) or
      (x.EventID == 4688 and x.Channel == "Sec" and not self.ignoreSecurity)

method analyze*(self: StackCmdlineCmd, x: HayabusaJson) =
  let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (x.Details[
      "Cmdline"].getStr("N/A"), @[""])
  let (stackKey, otherColumn) = getStackKey(x)
  stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackCmdlineCmd) =
  outputResult(self, self.stack, isMinColumns = true)

proc stackCmdlines(level: string = "informational", ignoreSysmon: bool = false,
    ignoreSecurity: bool = false, skipProgressBar: bool = false,
    output: string = "", quiet: bool = false, timeline: string) =
  checkArgs(quiet, timeline, level)
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = StackCmdlineCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                name: "stack-cmdlines",
                msg: StackCmdlineMsg,
                ignoreSysmon: ignoreSysmon,
                ignoreSecurity: ignoreSecurity)
    cmd.analyzeJSONLFile()

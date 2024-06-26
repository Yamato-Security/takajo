const StackTasksMsg = "This command will stack new scheduled tasks from Security 4698 events"

type
  StackTasksCmd* = ref object of AbstractCmd
    level*: string
    header* = @["TaskName", "Command", "Arguments"]
    stack* = initTable[string, StackRecord]()

method filter*(self: StackTasksCmd, x: HayabusaJson): bool =
  return x.EventID == 4698 and x.Channel == "Sec"

proc decodeEntity*(txt: string): string =
  return txt.replace("&amp;", "&").replace("&lt;", "<").replace("&gt;",
      ">").replace("&quot;", "\"").replace("&apos;", "'")

method analyze*(self: StackTasksCmd, x: HayabusaJson) =
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
      command = command.replace("<Command>", "").replace("</Command>", "")
    let arguments = node.findAll("Arguments")
    if len(arguments) > 0:
      args = $arguments[0]
      args = args.replace("<Arguments>", "").replace("</Arguments>", "")
    let stackKey = user & " -> " & name & " -> " & decodeEntity(command & " " & args)
    return (stackKey, @[name, command, args])
  let (stackKey, otherColumn) = getStackKey(x)
  stackResult(stackKey, self.stack, self.level, x, otherColumn = otherColumn)

method resultOutput*(self: StackTasksCmd) =
  outputResult(self, self.stack, self.header)

proc stackTasks(level: string = "informational", skipProgressBar: bool = false,
    output: string = "", quiet: bool = false, timeline: string) =
  checkArgs(quiet, timeline, level)
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = StackTasksCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                name: "stack-tasks",
                msg: StackTasksMsg)
    cmd.analyzeJSONLFile()
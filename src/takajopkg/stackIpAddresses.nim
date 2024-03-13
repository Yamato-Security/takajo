const StackIpAddressesMsg = "This command will stack the SrcIP (default) or TgtIP fields as well as show alert information."

type
  StackIpAddressesCmd* = ref object of AbstractCmd
    level* :string
    header* = @[""]
    stack* = initTable[string, StackRecord]()
    targetIpAddresses:bool

method filter*(self: StackIpAddressesCmd, x: HayabusaJson):bool =
    let key = if self.targetIpAddresses: "TgtIP" else: "SrcIP"
    let ip = getJsonValue(x.Details, @[key])
    return ip != "127.0.0.1" and ip != "::1"

method analyze*(self: StackIpAddressesCmd, x: HayabusaJson)=
    let key = if self.targetIpAddresses: "TgtIP" else: "SrcIP"
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) = (getJsonValue(x.Details, @[key]), @[""])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackIpAddressesCmd)=
    outputResult(self.output, self.name, self.stack, isMinColumns=true)

proc stackIpAddresses(level: string = "informational", targetIpAddresses: bool = false, skipProgressBar:bool = false, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackIpAddressesCmd(
                level: level,
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name: "IpAddresses",
                msg: StackIpAddressesMsg,
                targetIpAddresses: targetIpAddresses)
    cmd.analyzeJSONLFile()
# 以下MSドキュメントを参考にシステムアカウントを列挙
# https://learn.microsoft.com/ja-jp/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions?view=sql-server-ver16
const SYSTEM_ACCOUNTS = toHashSet([
    "NT AUTHORITY\\LOCAL SERVICE","NT AUTHORITY\\NETWORK SERVICE","NT AUTHORITY\\SYSTEM","BUILTIN\\Administrators",
    "NT-AUTORITÄT\\LOKALER DIENST","NT-AUTORITÄT\\NETZWERKDIENST","NT-AUTORITÄT\\SYSTEM","VORDEFINIERT\\Administratoren",
    "AUTORITE NT\\SERVICE LOCAL","AUTORITE NT\\SERVICE RÉSEAU","AUTORITE NT\\SYSTEM","BUILTIN\\Administrators",
    "NT AUTHORITY\\SERVIZIO LOCALE","NT AUTHORITY\\SERVIZIO DI RETE","NT AUTHORITY\\SYSTEM","BUILTIN\\Administrators",
    "NT AUTHORITY\\SERVICIO LOC","NT AUTHORITY\\SERVICIO DE RED","NT AUTHORITY\\SYSTEM","BUILTIN\\Administradores",
    "NT AUTHORITY\\LOCAL SERVICE","NT AUTHORITY\\NETWORK SERVICE","NT AUTHORITY\\СИСТЕМА","BUILTIN\\Администраторы",
    "Window Manager\\DWM-1",
    "LOCAL SERVICE",
    "IIS APPPOOL\\DefaultAppPool"
])

const StackUsersMsg = "This command will stack the TgtUser (default) or SrcUser fields as well as show alert information"

type
  StackUsersCmd* = ref object of AbstractCmd
    level* :string
    header* = @[""]
    stack* = initTable[string, StackRecord]()
    sourceUsers:bool
    filterComputerAccounts:bool
    filterSystemAccounts:bool

method filter*(self: StackUsersCmd, x: HayabusaJson):bool =
    return true

method analyze*(self: StackUsersCmd, x: HayabusaJson)=
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        var stackKey = getJsonValue(x.Details, @["User"])
        if stackKey.len() == 0:
            let key = if self.sourceUsers: "SrcUser" else: "TgtUser"
            stackKey = getJsonValue(x.Details, @[key])
        if self.filterComputerAccounts and stackKey.endsWith("$"):
            stackKey = ""
        if self.filterSystemAccounts:
            for excludeAccount in SYSTEM_ACCOUNTS:
                if cmpIgnoreCase(stackKey, excludeAccount) == 0:
                    stackKey = ""
                    continue
        return (stackKey, @[""])
    let (stackKey, otherColumn) = getStackKey(x)
    stackResult(stackKey, self.stack, self.level, x)

method resultOutput*(self: StackUsersCmd) =
    outputResult(self.output, self.name, self.stack, self.header, isMinColumns=true)

proc stackUsers(level: string = "informational", sourceUsers: bool = false, filterComputerAccounts: bool = true, filterSystemAccounts: bool = true, output: string = "", quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, level)
    let cmd = StackUsersCmd(
                level: level,
                timeline: timeline,
                output: output,
                name: "Users",
                msg: StackUsersMsg,
                sourceUsers: sourceUsers,
                filterSystemAccounts: filterSystemAccounts,
                filterComputerAccounts: filterComputerAccounts)
    cmd.analyzeJSONLFile()
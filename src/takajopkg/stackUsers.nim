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

proc stackUsers(level: string = "informational", sourceUsers: bool = false, filterComputerAccounts: bool = true, filterSystemAccounts: bool = true, output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, level)
    let totalLines = countJsonlAndStartMsg("Users", "the TgtUser (default) or SrcUser fields as well as show alert information", timeline)
    let eventFilter = proc(x: HayabusaJson): bool = true
    let getStackKey = proc(x: HayabusaJson): (string, seq[string]) =
        var stackKey = getJsonValue(x.Details, @["User"])
        if stackKey.len() == 0:
            let key = if sourceUsers: "SrcUser" else: "TgtUser"
            stackKey = getJsonValue(x.Details, @[key])
        if filterComputerAccounts and stackKey.endsWith("$"):
            stackKey = ""
        if filterSystemAccounts:
            for excludeAccount in SYSTEM_ACCOUNTS:
                if cmpIgnoreCase(stackKey, excludeAccount) == 0:
                    stackKey = ""
                    continue
        return (stackKey, @[])
    let stack = processJSONL(eventFilter, getStackKey, totalLines, timeline, level)
    outputResult(output, "User", stack, @[], isMinColumns=true)
    outputElapsedTime(startTime)
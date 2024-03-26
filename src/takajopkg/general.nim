import json
import re
import std/os
import std/parsecsv
import std/sequtils
import std/strformat
import std/strutils
import std/tables
import terminal
import times
import takajoTerminal

from std/streams import newFileStream


proc getJsonValue*(jsonResponse: JsonNode, keys: seq[string],
        default: string = "Unknown"): string =
    var value = jsonResponse
    for key in keys:
        if value.kind == JObject and value.hasKey(key):
            value = value[key]
        else:
            return default
    if value.kind == JInt:
        return $value.getInt() # Convert to string
    elif value.kind == JString:
        return value.getStr()
    else:
        return default # If it's neither a string nor an integer, return default


proc getJsonDate*(jsonResponse: JsonNode, keys: seq[string]): string =
    try:
        var node = jsonResponse
        for key in keys:
            node = node[key]
        let epochDate = fromUnix(node.getInt()).utc
        return epochDate.format("yyyy-MM-dd HH:mm:ss")
    except KeyError:
        return "Unknown"

proc getUnlistedSeq*(targetSeq: seq[string], compareSeq: seq[string]): seq[string] =
    ## get element not in compareSeq
    var output: seq[string] = @[]
    for target in targetSeq:
        if not(target in compareSeq):
            output.add(target)
    return output

proc getFileNameWithExt*(targetPath: string): string =
    ## get file name with ext from path
    var (_, file, ext) = splitFile(targetPath)
    file &= ext
    return file

proc getTargetExtFileLists*(targetDirPath: string, targetExt: string,
        fullPathOutput: bool): seq[string] =
    ## extract yml file name seq to specified directory path
    var r: seq[string] = @[]
    if fileExists(targetDirPath):
        if targetDirPath.endsWith(targetExt):
            if fullPathOutput:
                r.insert(targetDirPath)
            else:
                r.insert(getFileNameWithExt(targetDirPath))
    for f in walkDirRec(targetDirPath):
        if f.endsWith(targetExt):
            if fullPathOutput:
                r.insert(f)
            else:
                r.insert(getFileNameWithExt(f))
    # removed duplicated file name from seq
    r = deduplicate(r)
    if r.len() == 0:
        quit("Target file does not exist in specified directory. Please check your option parameters.")
    else:
        r

proc getHayabusaCsvData*(csvPath: string, columnName: string): Tableref[string,
        seq[string]] =
    ## procedure for Hayabusa output csv read data.

    var s = newFileStream(csvPath, fmRead)
    # if csvPath is not valid, error output and quit.
    if s == nil:
        quit("Cannot open the file. Please check that the file format is CSV. FilePath: " & csvPath)

    # parse csv
    var p: CsvParser
    try:
        open(p, s, csvPath)
        p.readHeaderRow()
    except CatchableError:
        quit("Failed to open '" & csvPath & "' because it is not in CSV format.\nPlease specify a CSV that has been created with the Hayabusa csv-timeline command.")
    let r = newTable[string, seq[string]]()
    # initialize table
    for h in items(p.headers):
        r[h] = @[]

    # insert csv data to table
    while p.readRow():
        for h in items(p.headers):
            r[h].add(p.rowEntry(h))
    if not r.contains(columnName):
        quit(fmt"Coud not find the {column_name} column. Please run hayabusa with the verbose profile (-p option).")

    return r

proc formatDuration*(d: Duration): string =
    let
        days = d.inDays
        hours = d.inHours mod 24
        minutes = d.inMinutes mod 60
        seconds = d.inSeconds mod 60
        milliseconds = d.inMilliseconds mod 1000
    return $days & "d " & $hours & "h " & $minutes & "m " & $seconds & "s " &
            $milliseconds & "ms"

proc extractStr*(jsonObj: JsonNode, key: string): string =
    let value = jsonObj.hasKey(key)
    if value and jsonObj[key].kind == JString:
        return jsonObj[key].getStr()
    else:
        return ""

proc extractInt*(jsonObj: JsonNode, key: string): int =
    if jsonObj.hasKey(key) and jsonObj[key].kind == JInt:
        return jsonObj[key].getInt()
    else:
        return -1

proc isEID_4624*(msgLogonRule: string): bool =
    case msgLogonRule
    of
        "Logon (System) - Bootup", "Logon (Interactive) *Creds in memory*",
        "Logon (Network)", "Logon (Batch)", "Logon (Service)",
        "Logon (Unlock)", "Logon (NetworkCleartext)",
        "Logon (NewCredentials) *Creds in memory*",
        "Logon (RemoteInteractive (RDP)) *Creds in memory*",
        "Logon (CachedInteractive) *Creds in memory*",
        "Logon (CachedRemoteInteractive) *Creds in memory*",
        "Logon (CachedUnlock) *Creds in memory*":
        result = true
    else:
        result = false

proc logonNumberToString*(msgLogonType: int): string =
    case msgLogonType:
        of 0: result = "0 - System"
        of 2: result = "2 - Interactive"
        of 3: result = "3 - Network"
        of 4: result = "4 - Batch"
        of 5: result = "5 - Service"
        of 7: result = "7 - Unlock"
        of 8: result = "8 - NetworkCleartext"
        of 9: result = "9 - NewCredentials"
        of 10: result = "10 - RemoteInteractive"
        of 11: result = "11 - CachedInteractive"
        of 12: result = "12 - CachedRemoteInteractive"
        of 13: result = "13 - CachedUnlock"
        else: result = "Unknown - " & $msgLogonType
    return result

proc isEID_4625*(msgLogonRule: string): bool =
    case msgLogonRule
    of
        "Logon Failure (User Does Not Exist)",
        "Logon Failure (Unknown Reason)",
        "Logon Failure (Wrong Password)":
        result = true
    else:
        result = false


proc escapeCsvField*(s: string): string =
    # If the field contains a quote, comma, or newline, enclose it in quotes
    # and replace any internal quotes with double quotes.
    if '"' in s or ',' in s or '\n' in s:
        result = "\"" & s.replace("\"", "\"\"") & "\""
    else:
        result = s

proc impersonationLevelIdToName*(impersonationLevelId: string): string =
    case impersonationLevelId:
        of "%%1832": result = "Identification"
        of "%%1833": result = "Impersonation"
        of "%%1840": result = "Delegation"
        of "%%1841": result = "Denied by Process Trust Label ACE"
        of "%%1842": result = "Yes"
        of "%%1843": result = "No"
        of "%%1844": result = "System"
        of "%%1845": result = "Not Available"
        of "%%1846": result = "Default"
        of "%%1847": result = "DisallowMmConfig"
        of "%%1848": result = "Off"
        of "%%1849": result = "Auto"
        of "": result = ""
        else: result = "Unknown - " & impersonationLevelId
    return result

proc logonFailureReason*(subStatus: string): string =
    case subStatus:
        of "0xc0000064": result = "Non-existant User"
        of "0xc000006a": result = "Wrong Password"
        of "": result = ""
        else: result = "Unknown - " & subStatus
    return result

proc elevatedTokenIdToName*(elevatedTokenId: string): string =
    case elevatedTokenId:
        of "%%1842": result = "Yes"
        of "%%1843": result = "No"
        of "": result = ""
        else: result = "Unknown - " & elevatedTokenId
    return result

proc getYAMLpathes*(rulesDir: string): seq[string] =
    var pathes: seq[string] = @[]
    for entry in walkDirRec(rulesDir):
        if entry.endsWith(".yml"):
            pathes.add(entry)
    return pathes


proc formatFileSize*(fileSize: BiggestInt): string =
    let
        kilo = 1024
        mega = kilo * kilo
        giga = kilo * mega
    var fileSizeStr = ""

    if fileSize >= giga:
        var gb = fileSize.float / giga.float
        fileSizeStr = $gb.formatFloat(ffDecimal, 2) & " GB"
    elif fileSize >= mega:
        var mb = fileSize.float / mega.float
        fileSizeStr = $mb.formatFloat(ffDecimal, 2) & " MB"
    elif fileSize >= kilo:
        var kb = fileSize.float / kilo.float
        fileSizeStr = $kb.formatFloat(ffDecimal, 2) & " KB"
    else:
        fileSizeStr = $fileSize & " Bytes"
    return fileSizeStr

proc countLinesInTimeline*(filePath: string, quiet: bool = false): int =
    echo "File: " & filePath & " (" & formatFileSize(getFileSize(filePath)) & ")"
    if not quiet:
        echo "Counting total lines. Please wait."
    const BufferSize = 4 * 1024 * 1024 # 4 MiB
    var buffer = newString(BufferSize)
    var file = open(filePath)
    var count = 0

    while true:
        let bytesRead = file.readChars(buffer.toOpenArray(0, BufferSize - 1))
        if bytesRead == 0:
            break
        for i in 0 ..< bytesRead:
            if buffer[i] == '\n':
                inc(count)
    inc(count)
    file.close()
    if not quiet:
        echo "Total lines: ", intToStr(count).insertSep(',')
        echo ""
    return count

proc isMinLevel*(levelInLog: string, userSetLevel: string): bool =
    case userSetLevel
        of "critical":
            return levelInLog == "crit"
        of "high":
            return levelInLog == "crit" or levelInLog == "high"
        of "medium":
            return levelInLog == "crit" or levelInLog == "high" or levelInLog == "med"
        of "low":
            return levelInLog == "crit" or levelInLog == "high" or levelInLog ==
                    "med" or levelInLog == "low"
        of "informational":
            return levelInLog == "crit" or levelInLog == "high" or levelInLog ==
                    "med" or levelInLog == "low" or levelInLog == "info"
        else:
            return false

proc isPrivateIP*(ip: string): bool =
    let
        ipv4Private = re"^(10\.\d{1,3}\.\d{1,3}\.\d{1,3})$|^(192\.168\.\d{1,3}\.\d{1,3})$|^(172\.(1[6-9]|2\d|3[01])\.\d{1,3}\.\d{1,3})$|^(127\.\d{1,3}\.\d{1,3}\.\d{1,3})$"
        ipv4MappedIPv6Private = re"^::ffff:(10\.\d{1,3}\.\d{1,3}\.\d{1,3})$|^::ffff:(192\.168\.\d{1,3}\.\d{1,3})$|^::ffff:(172\.(1[6-9]|2\d|3[01])\.\d{1,3}\.\d{1,3})$|^::ffff:(127\.\d{1,3}\.\d{1,3}\.\d{1,3})$"
        ipv6Private = re"^fd[0-9a-f]{2}:|^fe80:"

    if ip =~ ipv4Private or ip =~ ipv4MappedIPv6Private or ip =~ ipv6Private:
        return true
    else:
        return false

proc isMulticast*(address: string): bool =
    # Define regex for IPv4 multicast addresses
    let ipv4MulticastPattern = re"^(224\.0\.0\.0|22[5-9]\.|23[0-9]\.)"

    # Define regex for IPv6 multicast addresses
    let ipv6MulticastPattern = re"(?i)^ff[0-9a-f]{2}:"
    # check if the address matches either of the multicast patterns
    if address.find(ipv4MulticastPattern) >= 0 or address.find(
            ipv6MulticastPattern) >= 0:
        return true
    return false

proc isLoopback*(address: string): bool =
    # Define regex for IPv4 loopback addresses
    let ipv4LoopbackPattern = re"^127\.0\.0\.1$"

    # Define regex for IPv6 loopback addresses
    let ipv6LoopbackPattern = re"^(?:0*:)*?:?0*1$"

    # Check if the address matches either of the loopback patterns
    if address.find(ipv4LoopbackPattern) >= 0 or address.find(
            ipv6LoopbackPattern) >= 0:
        return true
    return false

proc isIpAddress*(s: string): bool =
    let ipRegex = re(r"\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}")
    return s.find(ipRegex) != -1

proc extractDomain*(domain: string): string =
    let doubleTLDs = ["co.jp", "co.uk", "com.au", "org.au", "net.au", "com.br",
        "net.br", "com.cn", "net.cn",
        "com.mx", "net.mx", "ac.nz", "co.nz", "net.nz", "co.za", "net.za",
        "co.in", "net.in", "ac.uk", "gov.uk"]
    let parts = domain.split('.')
    if parts.len >= 3:
        let lastTwo = parts[^2] & '.' & parts[^1]
        if doubleTLDs.contains(lastTwo):
            return parts[^3] & '.' & lastTwo
    if parts.len >= 2:
        return parts[^2] & '.' & parts[^1]
    return domain

proc isLocalIP*(ip: string): bool =
    return ip == "127.0.0.1" or ip == "-" or ip == "::1"

proc isJsonConvertible*(timeline: string): bool =
    var
        file: File
        firstLine: string
        jsonLine: JsonNode
    if file.open(timeline):
        try:
            firstLine = file.readLine()
            jsonLine = parseJson(firstLine)
            return true
        except CatchableError:
            echo "Failed to open '" & timeline & "' because it is not in JSONL format."
            echo "Please specify a JSONL-formatted file that has been created with the Hayabusa json-timeline command and -L or --JSONL-output option."
            echo ""
            return false
        finally:
            close(file)
    echo "Failed to open '" & timeline & "'. Please specify a valid file path.\p"
    return false

proc outputElapsedTime*(startTime: float) =
    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo ""
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " &
            $seconds & " seconds"
    echo ""

proc checkArgs*(quiet: bool = false, timeline: string, level: string) =
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let fileInfo = getFileInfo(timeline)
    if ((fileInfo.kind == pcDir or fileInfo.kind == pcLinkToDir) and
            not os.dirExists(timeline)) or ((fileInfo.kind ==
            pcFile or fileInfo.kind == pcLinkToFile) and
            not os.fileExists(timeline)):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
        quit(1)

    if level != "critical" and level != "high" and level != "medium" and
            level != "low" and level != "informational":
        echo "You must specify a minimum level of critical, high, medium, low or informational. (default: low)"
        echo ""
        quit(1)


proc countJsonlAndStartMsg*(cmdName: string, msg: string,
        timeline: string): int =
    echo "Started the " & cmdName & " command"
    echo ""
    echo msg
    echo ""

    let totalLines = countLinesInTimeline(timeline)
    echo "Scanning the Hayabusa timeline. Please wait."
    echo ""
    return totalLines

proc padString*(s: string, padChar: char, length: int): string =
    if s.len > length:
        return s[0..length]
    let padding = repeat($padChar, length - len(s))
    return s & padding

proc padString*(s: string, padChar: char, format: string): string =
    let s = s.replace(", ", ",")
    let format = format.replace("'", "")
    let length = format.len
    if s.len > length:
        return strip(s[0..length])
    let padding = repeat($padChar, length - len(s))
    return strip(s & padding)

proc getTimeFormat*(ts: seq[TableRef[string, string]]): string =
    if ts.len() == 0:
        return ""
    let t = ts[0]["Timestamp"]
    let length = t.len()
    if t.endsWith("Z"): # --ISO-8601
        return "yyyy-MM-dd'T'HH:mm:ss'.'ffffff"
    elif t.contains("AM") or t.contains("PM"): # --US-time
        return "MM-dd-yyyy HH:mm:ss'.'fff tt"
    elif t.contains(","): # --RFC-2822
        return "ddd,d MMM yyyy HH:mm:ss"
    elif t.count(' ') == 1: # --RFC-3339
        return "yyyy-MM-dd HH:mm:ss'.'ffffff"
    elif t[4] == '-': # -UTC
        return "yyyy-MM-dd HH:mm:ss'.'fff"
    # --European-time/--US-military-timeは月以外のフォーマットは同じなので、パースエラーの有無でタイムフォーマットを判定
    for s in ts:
        try:
            let timeFormat = "MM-dd-yyyy HH:mm:ss'.'fff"
            let x = parse(padString(s["Timestamp"], '0', timeFormat), timeFormat)
        except CatchableError:
            return "dd-MM-yyyy HH:mm:ss'.'fff" # --European-time
    return "MM-dd-yyyy HH:mm:ss'.'fff" # --US-military-time

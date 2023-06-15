import json
import math
import std/os
import std/parsecsv
import std/sequtils
import std/strformat
import std/strutils
import std/tables
import times
from std/streams import newFileStream

proc outputLogo*(): string =
    let logo = """
╔════╦═══╦╗╔═╦═══╗ ╔╦═══╗
║╔╗╔╗║╔═╗║║║╔╣╔═╗║ ║║╔═╗║
╚╝║║╚╣║ ║║╚╝╝║║ ║║ ║║║ ║║
  ║║ ║╚═╝║╔╗╖║╚═╝╠╗║║║ ║║
 ╔╝╚╗║╔═╗║║║╚╣╔═╗║╚╝║╚═╝║
 ╚══╝╚╝ ╚╩╝╚═╩╝ ╚╩══╩═══╝
  by Yamato Security
"""
    return logo

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

proc getTargetExtFileLists*(targetDirPath: string, targetExt: string): seq[string] =
    ## extract yml file name seq to specified directory path
    var r: seq[string] = @[]
    for f in walkDirRec(targetDirPath):
        if f.endsWith(targetExt):
            r.insert(getFileNameWithExt(f))
    # removed duplicated file name from seq
    r = deduplicate(r)
    if r.len() == 0:
        quit("Target file does not exist in specified directory. Please check your option parameters.")
    else:
        r

proc getHayabusaCsvData*(csvPath: string, columnName: string): Tableref[string, seq[string]] =
    ## procedure for Hayabusa output csv read data.

    var s = newFileStream(csvPath, fmRead)
    # if csvPath is not valid, error output and quit.
    if s == nil:
        quit("Cannot open the file. Please check that the file format is CSV. FilePath: " & csvPath)

    # parse csv
    var p: CsvParser
    open(p, s, csvPath)
    p.readHeaderRow()

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
    return $days & "d " & $hours & "h " & $minutes & "m " & $seconds & "s " & $milliseconds & "ms"

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

proc countLinesInTimeline*(filePath: string): int =
    #[
    var count = 0
    for _ in filePath.lines():
        inc count
    return count
    ]#
    const BufferSize = 4 * 1024 * 1024  # 4 MiB
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

    file.close()
    return count



proc formatFileSize*(fileSize: BiggestInt): string =
    let
        kilo = 1024
        mega = kilo * kilo
        giga = kilo * mega
    var fileSizeStr = ""

    if fileSize >= giga:
        var gb = fileSize.float / giga.float
        gb = round(gb, 1)
        fileSizeStr = $gb & " GB"
    elif fileSize >= mega:
        var mb = fileSize.float / mega.float
        mb = round(mb, 1)
        fileSizeStr = $mb & " MB"
    elif fileSize >= kilo:
        var kb = fileSize.float / kilo.float
        kb = round(kb, 1)
        fileSizeStr = $kb & " KB"
    else:
        fileSizeStr = $fileSize & " Bytes"
    return fileSizeStr

proc isMinLevel*(levelInLog: string, userSetLevel: string): bool =
    case userSetLevel
        of "critical":
            return levelInLog == "crit"
        of "high":
            return levelInLog == "crit" or levelInLog == "high"
        of "medium":
            return levelInLog == "crit" or levelInLog == "high" or levelInLog == "med"
        of "low":
            return levelInLog == "crit" or levelInLog == "high" or levelInLog == "med" or levelInLog == "low"
        of "informational":
            return levelInLog == "crit" or levelInLog == "high" or levelInLog == "med" or levelInLog == "low" or levelInLog == "info"
        else:
            return false
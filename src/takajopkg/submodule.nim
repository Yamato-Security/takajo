import std/os
import std/parsecsv
import std/sequtils
import std/strformat
import std/strutils
import std/tables
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

proc getHayabusaCsvData*(csvPath: string, columnName: string): Tableref[string,
        seq[string]] =
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
        else: result = "Unknown"
    return result

proc checkLogonRule*(msgLogonRule: string): bool =
    case msgLogonRule:
        of "Logon (System) - Bootup": result = true  # 0
        of "Logon (Interactive) *Creds in memory*": result = true # 2
        of "Logon (Network)": result = true # 3
        of "Logon (Batch)": result = true # 4
        of "Logon (Service)": result = true # 5
        of "Logon (Unlock)": result = true # 7
        of "Logon (NetworkCleartext)": result = true # 8
        of "Logon (NewCredentials) *Creds in memory*": result = true # 9
        of "Logon (RemoteInteractive (RDP)) *Creds in memory*": result = true # 10
        of "Logon (CachedInteractive) *Creds in memory*": result = true # 11
        of "Logon (CachedRemoteInteractive) *Creds in memory*": result = true # 12
        of "Logon (CachedUnlock) *Creds in memory*": result = true # 13
        else: result = false
    return result
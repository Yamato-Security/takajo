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
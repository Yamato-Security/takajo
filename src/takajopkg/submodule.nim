# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import takajopkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.

import std/tables
import std/parsecsv
import std/os
import std/strutils
import std/sequtils
from std/streams import newFileStream

proc getYMLLists*(targetDirPath: string): seq[string] =
  ## extract yml file name seq to specified directory path
  var r: seq[string] = @[]
  for f in walkDirRec(targetDirPath):
    if f.endsWith(".yml"):
      var (_, file, ext) = splitFile(f)
      file &= ext
      r.insert(file)
  # removed duplicated file name from seq
  return deduplicate(r)

proc getHayabusaCsvData*(csvPath: string): Tableref[string, seq[string]] =
  ## procedure for Hayabusa output csv read data.

  var s = newFileStream(csvPath, fmRead)
  # if csvPath is not valid, error output and quit.
  if s == nil:
    quit("cannot open the file. Please check file format is csv. FilePath: " & csvPath)

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
  return r

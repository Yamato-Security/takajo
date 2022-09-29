# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import falconerpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.

import std/tables
import std/parsecsv
from std/streams import newFileStream

proc getWelcomeMessage*(): string = "Hello, World!"
proc getHayabusaCsvData*(csvPath: string): Table =
  ## procedure for Hayabusa output csv read data.
  var ret = initTable[string, string[]]();
  var s = newFileStream(csvPath, fmRead)
  if s == nil:
    quit("cannot open the file. Please check file format is csv. FilePath: " & csvPath)

  # parse csv
  var p: CsvParser
  open(p, s, csvPath)
  var header = true
  p.readHeaderRow()

  # initialize table
  for h in items(p.headers):
    ret[h] = []

  while p.readRow():
    for h in items(p.headers):
      ret[h] = p.rowEntry(h)

  ret

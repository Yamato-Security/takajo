# TODO
# Get hashes from sysmon ID 7 (Image Loaded)
const ListHashesMsg =
  """
This command will extract out unique MD5, SHA1, SHA256 and Import hashes from Sysmon 1 process creation events.
By default, a minimum level of high will be used to extract only hashes of processes with a high likelihood of being malicious.
You can change the minimum level of alerts with -l, --level (ex: -l low).
For example, -l=informational for a minimum level of informational, which will extract out all hashes."""

type
  ListHashesCmd* = ref object of AbstractCmd
    level: string
    md5hashes*, sha1hashes*, sha256hashes*, impHashes * = initHashSet[string]()
    md5hashCount*, sha1hashCount*, sha256hashCount*, impHashCount * = 0

method filter*(self: ListHashesCmd, x: HayabusaJson): bool =
  return x.Channel == "Sysmon" and x.EventID == 1 and isMinLevel(x.Level, self.level)

method analyze*(self: ListHashesCmd, x: HayabusaJson) =
  try:
    let hashes = x.Details["Hashes"].getStr() # Hashes are not enabled by default so this field may not exist.
    let pairs = hashes.split(",") # Split the string into key-value pairs. Ex: MD5=DE9C75F34F47B60A71BBA03760F0579E,SHA256=12F06D3B1601004DB3F7F1A07E7D3AF4CC838E890E0FF50C51E4A0C9366719ED,IMPHASH=336674CB3C8337BDE2C22255345BFF43
    for pair in pairs:
      let keyVal = pair.split("=")
      case keyVal[0]:
        of "MD5":
          self.md5hashes.incl(keyVal[1])
          inc self.md5hashCount
        of "SHA1":
          self.sha1hashes.incl(keyVal[1])
          inc self.sha1hashCount
        of "SHA256":
          self.sha256hashes.incl(keyVal[1])
          inc self.sha256hashCount
        of "IMPHASH":
          self.impHashes.incl(keyVal[1])
          inc self.impHashCount
  except KeyError:
    discard

method resultOutput*(self: ListHashesCmd) =
  let output = self.output
  let md5outputFilename = output & "-MD5.txt"
  var md5outputFile = open(md5outputFilename, fmWrite)
  for hash in self.md5hashes:
    md5outputFile.write(hash & "\p")
  md5outputFile.close()
  let md5FileSize = getFileSize(md5outputFilename)

  # Save SHA1 results
  let sha1outputFilename = self.output & "-SHA1.txt"
  var sha1outputFile = open(sha1outputFilename, fmWrite)
  for hash in self.sha1hashes:
    sha1outputFile.write(hash & "\p")
  sha1outputFile.close()
  let sha1FileSize = getFileSize(sha1outputFilename)

  # Save SHA256 results
  let sha256outputFilename = output & "-SHA256.txt"
  var sha256outputFile = open(sha256outputFilename, fmWrite)
  for hash in self.sha256hashes:
    sha256outputFile.write(hash & "\p")
  sha256outputFile.close()
  let sha256FileSize = getFileSize(sha256outputFilename)

  # Save IMPHASH results
  let impHashOutputFilename = output & "-ImportHashes.txt"
  var impHashOutputFile = open(impHashOutputFilename, fmWrite)
  for hash in self.impHashes:
    impHashOutputFile.write(hash & "\p")
  impHashOutputFile.close()
  let impHashFileSize = getFileSize(impHashOutputFilename)
  let savedFiles = "" &
      padString(md5outputFilename & " (" & formatFileSize(md5FileSize) & ")",
          ' ', 80) &
      padString(sha1outputFilename & " (" & formatFileSize(sha1FileSize) & ")",
          ' ', 80) &
      padString(sha256outputFilename & " (" & formatFileSize(sha256FileSize) &
          ")", ' ', 80) &
      padString(impHashOutputFilename & " (" & formatFileSize(impHashFileSize) &
          ")", ' ', 80)
  let results = "" &
      padString("MD5: " & intToStr(self.md5hashCount).insertSep(','), ' ', 80) &
      padString("SHA1: " & intToStr(self.sha1hashCount).insertSep(','), ' ',
          80) &
      padString("SHA256: " & intToStr(self.sha256hashCount).insertSep(','), ' ',
          80) &
      padString("Import: " & intToStr(self.impHashCount).insertSep(','), ' ', 80)
  if self.displayTable:
    echo ""
    echo "Saved files:"
    echo md5outputFilename & " (" & formatFileSize(md5FileSize) & ")"
    echo sha1outputFilename & " (" & formatFileSize(sha1FileSize) & ")"
    echo sha256outputFilename & " (" & formatFileSize(sha256FileSize) & ")"
    echo impHashOutputFilename & " (" & formatFileSize(impHashFileSize) & ")"
    echo ""
    echo "Hashes:"
    echo "MD5: ", intToStr(self.md5hashCount).insertSep(',')
    echo "SHA1: ", intToStr(self.sha1hashCount).insertSep(',')
    echo "SHA256: ", intToStr(self.sha256hashCount).insertSep(',')
    echo "Import: ", intToStr(self.impHashCount).insertSep(',')
    echo ""
  self.cmdResult = CmdResult(results: results, savedFiles: savedFiles)

proc listHashes(level: string = "high", skipProgressBar: bool = false,
    output: string, quiet: bool = false, timeline: string) =
  checkArgs(quiet, timeline, level)
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = ListHashesCmd(
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                level: level,
                output: output,
                name: "list-hashes",
                msg: ListHashesMsg)
    cmd.analyzeJSONLFile()

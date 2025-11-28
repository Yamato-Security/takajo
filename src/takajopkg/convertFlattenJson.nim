import json, streams, strutils, sequtils

const ConvertFlattenJsonMsg = "Convert and flatten Hayabusa JSONL files by merging nested fields and concatenating arrays."

type
  ConvertFlattenJsonCmd* = ref object of AbstractCmd
    outputFile: File

# Function to concatenate arrays using " ¦ " as the separator
proc concatArray(jsonObj: JsonNode, key: string): string =
  if key in jsonObj and jsonObj[key].kind == JArray:
    let concatenated = jsonObj[key].getElems().mapIt(it.getStr()).join(" ¦ ")
    if concatenated.len > 0:
      return concatenated  # Return the concatenated string if not empty
  return ""  # Return empty string if key is missing or array is empty

# Function to flatten a JSON object
proc flattenJson(jsonObj: JsonNode): JsonNode =
  var flatJson = newJObject()

  # Copy top-level fields except "Details", "ExtraFieldInfo", and array fields
  for key, value in jsonObj.pairs:
    if key notin ["Details", "ExtraFieldInfo", "OtherTags", "MitreTags", "MitreTactics"]:
      flatJson[key] = value

  # Merge "Details" fields into the root
  if "Details" in jsonObj:
    for key, value in jsonObj["Details"].pairs:
      flatJson[key] = value

  # Merge "ExtraFieldInfo" fields into the root
  if "ExtraFieldInfo" in jsonObj:
    for key, value in jsonObj["ExtraFieldInfo"].pairs:
      flatJson[key] = value

  # Concatenate arrays only if they have data
  for key in ["OtherTags", "MitreTags", "MitreTactics"]:
    let concatenated = concatArray(jsonObj, key)
    if concatenated.len > 0:  # Only add if non-empty
      flatJson[key] = %concatenated
  return flatJson

method filter*(self: ConvertFlattenJsonCmd, x: HayabusaJson): bool =
  return true

method analyze*(self: ConvertFlattenJsonCmd, x: HayabusaJson) =
  var jsonObj = %* {
    "Timestamp": x.Timestamp,
    "RuleTitle": x.RuleTitle,
    "Computer": x.Computer,
    "Channel": x.Channel,
    "Level": x.Level,
    "EventID": x.EventID,
    "RuleAuthor": x.RuleAuthor,
    "RuleModifiedDate": x.RuleModifiedDate,
    "Status": x.Status,
    "RecordID": x.RecordID,
    "Details": x.Details,
    "ExtraFieldInfo": x.ExtraFieldInfo,
    "Provider": x.Provider,
    "RuleCreationDate": x.RuleCreationDate,
    "RuleFile": x.RuleFile,
    "EvtxFile": x.EvtxFile,
    "MitreTags": %x.MitreTags,
    "MitreTactics": %x.MitreTactics,
    "OtherTags": %x.OtherTags
  }
  let flattened = flattenJson(jsonObj)
  self.outputFile.writeLine($flattened)

method resultOutput*(self: ConvertFlattenJsonCmd) =
  self.outputFile.close()

proc convertFlattenJson(output: string = "", quiet: bool = false, skipProgressBar: bool = false, timeline: string) =
  checkArgs(quiet, timeline, "informational")
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for timelinePath in filePaths:
    let cmd = ConvertFlattenJsonCmd(
                skipProgressBar: skipProgressBar,
                timeline: timelinePath,
                output: output,
                name: "convert-flatten-json",
                msg: ConvertFlattenJsonMsg)
    cmd.outputFile = open(output, fmWrite)
    cmd.analyzeJSONLFile()

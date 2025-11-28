import general
import json, streams, strutils, sequtils

const ConvertFlattenJsonMsg = "Convert and flatten Hayabusa JSONL files by merging nested fields and concatenating arrays."

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

proc convertFlattenJson(output: string = "", quiet: bool = false, skipProgressBar: bool = false, timeline: string) =
  checkArgs(quiet, timeline, "informational")
  var filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  let outputStream = newFileStream(output, fmWrite)
  defer:
    outputStream.close()

  let startTime = epochTime()
  var bar: SuruBar
  if not skipProgressBar:
    bar = initSuruBar()
    bar[0].total = countJsonlAndStartMsg("convert-flatten-json", ConvertFlattenJsonMsg, timeline)
    bar.setup()

  let fileInfo = getFileInfo(timeline)
  if (fileInfo.kind == pcDir or fileInfo.kind == pcLinkToDir):
    filePaths = getTargetExtFileLists(timeline, ".jsonl", true)
  for path in filePaths:
    for line in lines(path):
      if not skipProgressBar:
        inc bar
        bar.update(1000000000)
      try:
        let jsonObj = parseJson(line)
        let flattenedJson = flattenJson(jsonObj)
        outputStream.writeLine(flattenedJson)
      except:
        echo "Skipping invalid JSON line: ", line
  if not skipProgressBar:
    bar.finish()
  outputElapsedTime(startTime)
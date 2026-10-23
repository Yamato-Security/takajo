import json

type
  HtmlTimelineRecordError* = object of ValueError

  HtmlTimelineRecord* = object
    timestamp*: string
    ruleTitle*: string
    level*: string
    computer*: string
    channel*: string
    eventId*: int
    recordId*: string
    ruleFile*: string
    evtxFile*: string
    ruleAuthor*: string
    ruleModifiedDate*: string
    ruleCreationDate*: string
    status*: string

proc requiredString(jsonObj: JsonNode, key: string): string =
  if jsonObj.kind != JObject:
    raise newException(HtmlTimelineRecordError, "record must be a JSON object")
  if key notin jsonObj:
    raise newException(HtmlTimelineRecordError, "missing required field: " & key)
  if jsonObj[key].kind != JString:
    raise newException(HtmlTimelineRecordError, "field must be a string: " & key)
  return jsonObj[key].getStr()

proc optionalString(jsonObj: JsonNode, key: string): string =
  if jsonObj.kind == JObject and key in jsonObj and jsonObj[key].kind == JString:
    return jsonObj[key].getStr()
  return ""

proc eventIdValue(jsonObj: JsonNode): int =
  if jsonObj.kind != JObject or "EventID" notin jsonObj:
    raise newException(HtmlTimelineRecordError, "missing required field: EventID")
  # Hayabusa count rules may use "-" instead of a numeric EventID. Keep the
  # existing HTML import behavior of normalizing those records to 0.
  return jsonObj["EventID"].getInt()

proc recordIdValue(jsonObj: JsonNode): string =
  if jsonObj.kind != JObject or "RecordID" notin jsonObj:
    return ""

  case jsonObj["RecordID"].kind
  of JString:
    return jsonObj["RecordID"].getStr()
  of JInt:
    return $jsonObj["RecordID"].getInt()
  else:
    return ""

proc hasVerboseProfileFields*(jsonObj: JsonNode): bool =
  return jsonObj.kind == JObject and "RuleFile" in jsonObj and "EvtxFile" in jsonObj

proc toHtmlTimelineRecord*(jsonObj: JsonNode): HtmlTimelineRecord =
  result = HtmlTimelineRecord(
    timestamp: requiredString(jsonObj, "Timestamp"),
    ruleTitle: requiredString(jsonObj, "RuleTitle"),
    level: requiredString(jsonObj, "Level"),
    computer: requiredString(jsonObj, "Computer"),
    channel: requiredString(jsonObj, "Channel"),
    eventId: eventIdValue(jsonObj),
    recordId: recordIdValue(jsonObj),
    ruleFile: requiredString(jsonObj, "RuleFile"),
    evtxFile: requiredString(jsonObj, "EvtxFile"),
    ruleAuthor: optionalString(jsonObj, "RuleAuthor"),
    ruleModifiedDate: optionalString(jsonObj, "RuleModifiedDate"),
    ruleCreationDate: optionalString(jsonObj, "RuleCreationDate"),
    status: optionalString(jsonObj, "Status")
  )

proc parseHtmlTimelineRecord*(line: string): HtmlTimelineRecord =
  return toHtmlTimelineRecord(parseJson(line))

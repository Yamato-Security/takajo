import general
import json
import jsony
import std/options

type HayabusaJson* = ref object
    Timestamp*: string
    RuleTitle*: string
    Computer*: string
    Channel*: string
    Level*: string
    EventID*: int
    RuleAuthor*: string
    RuleModifiedDate*: string
    Status*: string
    RecordID*: int
    Details*: JsonNode
    ExtraFieldInfo*: JsonNode
    Provider*: string
    RuleCreationDate*: string
    RuleFile*: string
    EvtxFile*: string
    MitreTags*: seq[string]
    MitreTactics*: seq[string]
    OtherTags*: seq[string]

proc convertJsonNodeToSeq(jsonNode: JsonNode, key:string): seq[string] =
    var res: seq[string] = @[]
    if key in jsonNode:
        for element in jsonNode[key]:
            res.add(element.getStr())
    return res

proc parseLine*(line:string): Option[HayabusaJson] =
  try:
      return some(line.fromJson(HayabusaJson))
  except CatchableError:
      # countルールは、EventID: "-" となりint型に変換できないため、EventID:0のHayabusaJsonオブジェクトを作成
      try:
          let jsonLine = parseJson(line)
          let x = HayabusaJson(
                Timestamp: getJsonValue(jsonLine, @["Timestamp"]),
                RuleTitle: getJsonValue(jsonLine, @["RuleTitle"]),
                Computer: getJsonValue(jsonLine, @["Computer"]),
                Channel: getJsonValue(jsonLine, @["Channel"]),
                Level: getJsonValue(jsonLine, @["Level"]),
                EventID: 0,
                RuleAuthor: getJsonValue(jsonLine, @["RuleAuthor"]),
                RuleModifiedDate: getJsonValue(jsonLine, @["RuleModifiedDate"]),
                Status: getJsonValue(jsonLine, @["Status"]),
                RecordID: 0,
                Details: jsonLine["Details"],
                ExtraFieldInfo: jsonLine["ExtraFieldInfo"],
                Provider: getJsonValue(jsonLine, @["Provider"]),
                RuleCreationDate: getJsonValue(jsonLine, @["RuleCreationDate"]),
                RuleFile: getJsonValue(jsonLine, @["RuleFile"]),
                EvtxFile: getJsonValue(jsonLine, @["EvtxFile"]),
                MitreTags: convertJsonNodeToSeq(jsonLine, "MitreTags"),
                MitreTactics: convertJsonNodeToSeq(jsonLine, "MitreTactics"))
          return some(x)
      except CatchableError:
          return none(HayabusaJson)
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

proc parseLine*(line:string): Option[HayabusaJson] =
  try:
      return some(line.fromJson(HayabusaJson))
  except CatchableError:
      return none(HayabusaJson)
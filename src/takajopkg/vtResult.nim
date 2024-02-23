import json
import std/tables

type VirusTotalResult* = ref object
    resTable*: TableRef[string, string]
    resJson*: JsonNode
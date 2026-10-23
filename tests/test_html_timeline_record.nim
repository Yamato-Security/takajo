import std/json
import unittest

import takajopkg/htmlTimelineRecord

const correlationRecord = """{"Timestamp":"2026-01-02 03:04:05.678 +00:00","RuleTitle":"User Guessing","Level":"med","Computer":"host.example.test","Channel":"Sec","EventID":4625,"Details":{"Count":5,"TargetUserName":"user-a,user-b","IpAddress":"192.0.2.10"},"ExtraFieldInfo":{},"RuleFile":"correlation_rule.yml","RuleID":"00000000-0000-0000-0000-000000000001","EvtxFile":"/evidence/host/Security.evtx"}"""

test "HTML timeline parser accepts correlation records without RecordID":
  let record = parseHtmlTimelineRecord(correlationRecord)
  check record.recordId == ""
  check record.timestamp == "2026-01-02 03:04:05.678 +00:00"
  check record.eventId == 4625

test "HTML timeline parser preserves numeric and string RecordID values":
  let jsonObj = parseJson(correlationRecord)

  jsonObj["RecordID"] = newJInt(12345)
  check toHtmlTimelineRecord(jsonObj).recordId == "12345"

  jsonObj["RecordID"] = newJString("12346")
  check toHtmlTimelineRecord(jsonObj).recordId == "12346"

test "HTML timeline parser accepts the count-rule EventID placeholder":
  let jsonObj = parseJson(correlationRecord)
  jsonObj["EventID"] = newJString("-")
  check toHtmlTimelineRecord(jsonObj).eventId == 0

test "HTML timeline parser distinguishes JSON syntax and schema errors":
  expect JsonParsingError:
    discard parseHtmlTimelineRecord("{")

  let jsonObj = parseJson(correlationRecord)
  jsonObj.delete("Timestamp")
  expect HtmlTimelineRecordError:
    discard toHtmlTimelineRecord(jsonObj)

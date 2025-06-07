import json
import prologue
import db_connector/db_sqlite
import strutils
import yaml

proc getDBPath(ctx: Context) : string =
    let settings = getOrDefault(ctx.gScope.settings, "prologue")
    return settings["appName"].getStr()

proc list*(ctx: Context) {.async.} =

    #
    # query to DB
    #
    try:
        let path = getDBPath(ctx)
        let db = open(path , "", "", "")

        let query = """SELECT alert_title, rule_path FROM rule_files"""
        let rules = db.getAllRows(sql query) 

        let response = %* {
            "rules": rules
        }
        resp jsonResponse(%* response, Http200)

    except Exception as e:
        echo e.msg
        let response = %*{"message": "error"}
        resp jsonResponse(response, Http400)


proc getRuleContent*(ctx: Context) {.async.} =
  #
  # Get rule_path from DB and read YAML content
  #
  try:
    let path = getDBPath(ctx)
    let db = open(path, "", "", "")

    let query = """SELECT rule_path FROM rule_files WHERE alert_title = ?"""
    let alertTitle = ctx.request.queryParams["alert_title"]
    if alertTitle.isNil:
      let response = %*{"message": "alert_title parameter is required"}
      resp jsonResponse(response, Http400)
      return

    let rulePathRow = db.getRow(sql query, alertTitle)
    if rulePathRow.len == 0:
      let response = %*{"message": "No rule found for the given alert_title"}
      resp jsonResponse(response, Http404)
      return

    let rulePath = rulePathRow[0]
    let yamlContent = readFile(rulePath)

    let response = %*{
      "alert_title": alert_title,
      "rule_path": rulePath,
      "yaml_content": yamlContent
    }
    resp jsonResponse(%* response, Http200)

  except Exception as e:
    echo e.msg
    let response = %*{"message": "error"}
    resp jsonResponse(response, Http400)

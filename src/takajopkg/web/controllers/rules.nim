import json
import prologue
import db_connector/db_sqlite
import strutils

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

import json
import prologue
import db_connector/db_sqlite
import strutils
import times

proc getDBPath(ctx: Context) : string =
    let settings = getOrDefault(ctx.gScope.settings, "prologue")
    return settings["appName"].getStr()

proc computer*(ctx: Context) {.async.} =

    #
    # required parameters
    #
    let computer = ctx.request.queryParams.getOrDefault("computer", "")
    if computer == "":
        let response = %*{"message": "Invalid Request: missing computer parameter"}
        resp jsonResponse(response, Http400)
        return

    var params: seq[string] = @[]
    var custom_query = " computer = ? "
    params.add(computer)

    #
    # optional parameters
    #
    ## Past 30 days
    let pastdays = ctx.request.queryParams.getOrDefault("pastdays", "")
    if pastdays == "":

        let start_date = ctx.request.queryParams.getOrDefault("start_date", "")
        if start_date != "":
            custom_query &= " AND timestamp >= ? "
            params.add(start_date & " 00:00:00")

        let end_date = ctx.request.queryParams.getOrDefault("end_date", "")
        if end_date != "":
            custom_query &= " AND timestamp <= ?"
            params.add(end_date & " 23:59:59")

    else:
        custom_query &= " AND timestamp >= ? "
        let thirtyDaysAgo = now() - (30.days)
        params.add(format(thirtyDaysAgo, "yyyy-MM-dd") & " 00:00:00")
        

    let rule_title = ctx.request.queryParams.getOrDefault("rule_title", "")
    if rule_title != "":
        let rule_title_list = rule_title.split(",")
        custom_query &= " AND rule_title IN ("
        var count = 0
        let rule_title_list_last = len(rule_title_list) - 1
        for rule_title in rule_title_list:
            #custom_query &= "'" & rule_title & "'"
            custom_query &= "?"
            if count != rule_title_list_last:
                custom_query &= ","
            count += 1
            params.add(rule_title)
        custom_query &= ")"
        

    let severities = ctx.request.queryParams.getOrDefault("severities", "")
    if severities != "":
        var severity_query = ""
        let severity_ary = severities.split(",")
        for severity in severity_ary:
            if severity_query.len > 0:
                severity_query &= ", "
            severity_query &= dbQuote(severity)
        custom_query &= " AND level IN (" & severity_query & ")"

    echo custom_query
    echo params

    #
    # query to DB
    #
    try:
        let path = getDBPath(ctx)
        let db = open(path , "", "", "")

        var query = """select rule_title, rule_file, level, level_order, computer, min(datetime(timestamp, 'localtime')) as start_date, max(datetime(timestamp, 'localtime')) as end_date, count(*) as count
                        from timelines
                        where """ & custom_query &  """
                        group by rule_title, level, computer
                        order by level_order
                        """
        var alerts = db.getAllRows(sql query, params) 

        query = """SELECT
                    SUM(CASE WHEN level = 'crit' THEN 1 ELSE 0 END) AS critical_count,
                    SUM(CASE WHEN level = 'high' THEN 1 ELSE 0 END) AS high_count,
                    SUM(CASE WHEN level = 'med' THEN 1 ELSE 0 END) AS medium_count,
                    SUM(CASE WHEN level = 'low' THEN 1 ELSE 0 END) AS low_count,
                    SUM(CASE WHEN level = 'info' THEN 1 ELSE 0 END) AS informational_count
                    FROM timelines
                    where """ & custom_query &  """
                    """
        let computer_counts = db.getRow(sql query, params) 

        query = """select level, level_order, date(datetime(timestamp, 'localtime')) AS date, count(*) as count
                        from timelines
                        where """ & custom_query &  """
                        group by date, level_order
                        order by date, level_order
                        """
        let graph_data = db.getAllRows(sql query, params) 

        let response = %* {
            "alerts": alerts,
            "computer_counts": computer_counts,
            "graph_data": graph_data
        }
        resp jsonResponse(response, Http200)

    except Exception as e:
        echo e.msg
        let response = %*{"message": "error"}
        resp jsonResponse(response, Http400)


proc sidemenu*(ctx: Context) {.async.} =

    #
    # query to DB
    #
    try:
        let path = getDBPath(ctx)
        let db = open(path , "", "", "")

        var query = sql"""SELECT 
                            level as severity,
                            rule_title,
                            computer,
                            COUNT(computer) AS computer_total,
                            MIN(datetime(timestamp, 'localtime')) AS first_date,
                            MAX(datetime(timestamp, 'localtime')) AS last_date
                        FROM timelines
                        GROUP BY level_order, rule_title, computer
                        ORDER BY level_order, rule_title, computer;
                    """
        var sidemenu = db.getAllRows(query)
        let response = %* {
            "sidemenu": sidemenu
        }
        resp jsonResponse(response, Http200)

    except Exception as e:
        echo e.msg
        let response = %*{"message": "error"}
        resp jsonResponse(response, Http400)


#
# Computer Summary
#
proc summary*(ctx: Context) {.async.} =
    #
    # query to DB
    #
    try:
        let path = getDBPath(ctx)
        let db = open(path , "", "", "")

        var query = sql"""SELECT
                        computer,
                        SUM(CASE WHEN level = 'crit' THEN 1 ELSE 0 END) AS "Critical Alerts",
                        SUM(CASE WHEN level = 'high' THEN 1 ELSE 0 END) AS "High Alerts",
                        SUM(CASE WHEN level = 'med' THEN 1 ELSE 0 END) AS "Medium Alerts",
                        SUM(CASE WHEN level = 'low' THEN 1 ELSE 0 END) AS "Low Alerts",
                        SUM(CASE WHEN level = 'info' THEN 1 ELSE 0 END) AS "Informational Alerts"
                    FROM
                        timelines
                    GROUP BY
                        computer
                    ORDER BY
                        "Critical Alerts" DESC,
                        "High Alerts" DESC,
                        "Medium Alerts" DESC,
                        "Low Alerts" DESC,
                        "Informational Alerts" DESC;
                    """
        var summary = db.getAllRows(query)
        let response = %* {
            "summary": summary
        }
        resp jsonResponse(response, Http200)

    except Exception as e:
        echo e.msg
        let response = %*{"message": "error"}
        resp jsonResponse(response, Http400)

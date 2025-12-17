import json
import prologue
import db_connector/db_sqlite
import strutils
import times

proc getDBPath(ctx: Context) : string =
    let settings = getOrDefault(ctx.gScope.settings, "prologue")
    return settings["appName"].getStr()

proc list*(ctx: Context) {.async.} =

    #
    # optional parameters
    #
    var custom_query = " 1=1 "
    var params: seq[string] = @[]

    # Computer Name
    let computer = ctx.request.queryParams.getOrDefault("computer", "")
    if computer != "":
        custom_query &= " AND computer = ? "
        params.add(computer)

    ## Past 30 days
    let pastdays = ctx.request.queryParams.getOrDefault("date", "")
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
        custom_query &= " AND rule_title = ?"
        params.add(rule_title)

    let severities = ctx.request.queryParams.getOrDefault("severities", "")
    if severities != "":
        var severity_query = ""
        let severity_ary = severities.split(",")
        for severity in severity_ary:
            if severity_query.len > 0:
                severity_query &= ", "
            severity_query &= dbQuote(severity)
        custom_query &= " AND level IN (" & severity_query & ")"

    # echo custom_query

    #
    # query to DB
    #
    try:
        let path = getDBPath(ctx)
        let db = open(path , "", "", "")

        var query = """SELECT level,
                        COUNT(*) AS total_detections,
                        COUNT(DISTINCT rule_title) AS unique_detections,
                        ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM timelines) * 100, 2) AS total_percent,
                        ROUND(CAST(COUNT(DISTINCT rule_title) AS FLOAT) / (SELECT COUNT(DISTINCT rule_title) FROM timelines) * 100, 2) AS unique_percent
                        FROM timelines
                        WHERE """ & custom_query &  """
                        GROUP BY level
                        ORDER BY CASE level
                            WHEN 'crit' THEN 1
                            WHEN 'high' THEN 2
                            WHEN 'med' THEN 3
                            WHEN 'low' THEN 4
                            WHEN 'info' THEN 5
                            ELSE 6
                        END;
                        """
        var summary = db.getAllRows(sql query, params) 

        query = """WITH max_detections AS (
                    SELECT
                        level,
                        DATE(timestamp) AS detection_date,
                        COUNT(*) AS detection_count
                    FROM timelines
                    GROUP BY level, detection_date
                ),
                max_date_per_level AS (
                    SELECT
                        level,
                        detection_date,
                        detection_count,
                        ROW_NUMBER() OVER (PARTITION BY level ORDER BY detection_count DESC) AS rn
                    FROM max_detections
                )
                SELECT
                    level AS Severity,
                    detection_date AS "Number of detections",
                    detection_count AS "Detection rate"
                FROM max_date_per_level
                WHERE rn = 1
                ORDER BY CASE level
                    WHEN 'crit' THEN 1
                    WHEN 'high' THEN 2
                    WHEN 'med' THEN 3
                    WHEN 'low' THEN 4
                    WHEN 'info' THEN 5
                    ELSE 6
                END;
                """
        var dates_with_most_total_detections = db.getAllRows(sql query, params) 

        query = """SELECT level, level_order, rule_title, computer, COUNT(*) AS alert_count, 
                    MIN(date(dateime(timestamp))) AS first_seen, MAX(date(dateime(timestamp))) AS last_seen
                    FROM timelines
                    GROUP BY level, rule_title, computer
                    ORDER BY level_order DESC
                """
        var all_alerts = db.getAllRows(sql query, params) 

        let response = %* {
            "summary": summary,
            "dates_with_most_total_detections": dates_with_most_total_detections,
            "all_alerts": all_alerts
        }
        resp jsonResponse(%* response, Http200)

    except Exception as e:
        echo e.msg
        let response = %*{"message": "error"}
        resp jsonResponse(response, Http400)

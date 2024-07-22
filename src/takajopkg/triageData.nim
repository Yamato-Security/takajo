import db_connector/db_sqlite
import streams

# output: save results to a SQLite database
# timeline: Hayabusa JSONL timeline file or directory
proc triageData*(output: string, quiet: bool = false, timeline: string) =

    # create sqlite file or open exist database file.
    let db = open(output, "", "", "")
    try:
        echo "Database file opened"

        # create timelines table
        let createTableSQL = sql"""CREATE TABLE IF NOT EXISTS timelines (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            rule_title TEXT,
            level TEXT,
            level_order INTEGER,
            computer TEXT,
            channel TEXT,
            event_id INTEGER,
            record_id TEXT,
            rule_file TEXT,
            evtx_file TEXT,
            rule_author TEXT,
            rule_modified_date TEXT,
            rule_creation_date TEXT,
            status TEXT
        )"""
        db.exec(createTableSQL)

        # read from timeline file
        # open timeline file
        var fileStream = newFileStream(timeline, fmRead)

        if fileStream == nil:
            echo "Failed to open file: ", timeline
        
        while not fileStream.atEnd:
            let line = fileStream.readLine()
            if line.len > 0:
                try:
                    #
                    # write to sqlite
                    #

                    # common parameters
                    let jsonObj = parseJson(line)
                    let timestamp = jsonObj["Timestamp"].getStr()
                    let rule_title = jsonObj["RuleTitle"].getStr()
                    let level = jsonObj["Level"].getStr()
                    let computer = jsonObj["Computer"].getStr()
                    let channel = jsonObj["Channel"].getStr()
                    let event_id = jsonObj["EventID"].getInt()
                    let record_id = jsonObj["RecordID"].getInt()
                    let rule_file = jsonObj["RuleFile"].getStr()
                    let evtx_file = jsonObj["EvtxFile"].getStr()

                    var level_order = 0
                    if level == "critical":
                        level_order = 5
                    elif level == "high":
                        level_order = 4
                    elif level == "med":
                        level_order = 3
                    elif level == "low":
                        level_order = 2
                    elif level == "info":
                        level_order = 1

                    # extra params
                    var rule_author = ""
                    var rule_modified_date = ""
                    var status = ""
                    var rule_creation_date = ""

                    if "RuleAuthor" in jsonObj:
                        rule_author = jsonObj["RuleAuthor"].getStr()
                    
                    if "RuleModifiedDate" in jsonObj:
                        rule_modified_date = jsonObj["RuleModifiedDate"].getStr()

                    if "Status" in jsonObj:
                        status = jsonObj["Status"].getStr()
                    
                    if "RuleCreationDate" in jsonObj:
                        rule_creation_date = jsonObj["RuleCreationDate"].getStr()

                    let insertSQL = """INSERT INTO timelines (
                        timestamp,
                        rule_title,
                        level,
                        level_order,
                        computer,
                        channel,
                        event_id,
                        record_id,
                        rule_file,
                        evtx_file,
                        rule_author,
                        rule_modified_date,
                        rule_creation_date,
                        status
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"""
                    
                    var stmt = db.prepare(insertSQL)
                    stmt.bindParams(timestamp, 
                        rule_title, 
                        level, 
                        level_order,
                        computer, 
                        channel, 
                        event_id, 
                        record_id, 
                        rule_file, 
                        evtx_file, 
                        rule_author, 
                        rule_modified_date, 
                        rule_creation_date, 
                        status)
                    let bres = db.tryExec(stmt)
                                        
                    doAssert(bres)
                    finalize(stmt)
                    
                except CatchableError:
                    echo "Invalid JSON line: ", line

        fileStream.close()

    except:
        discard
    

    # start analysis timeline
    # obtain datas from SQLite
    let query = sql"""select rule_title, level, computer, min(timestamp) as start_date, max(timestamp) as end_date, count(*) as count
                        from timelines
                        group by rule_title, level, computer
                        order by level_order, rule_title, computer
                        """

    var alerts = db.getAllRows(query)
    
    # close sqlite file
    db.close()

    # データの整形
    type
        Computer = tuple[name: string, count: int, start_date: string, end_date: string]
        Alert = tuple[title: string, count: int, computers: seq[Computer]]
        Level = tuple[level: string, alerts: seq[Alert]]
    
    var levels = initTable[string, seq[Alert]]()

    proc findAlert(alerts: seq[Alert], rule_title: string): int =
        for i, alert in alerts:
            if alert.title == rule_title:
                return i
        return -1


    for row in alerts:
        let rule_title = row[0]
        let level = row[1]
        let computer = row[2]
        let start_date = row[3]
        let end_date = row[4]
        let count = row[5].parseInt

        if not levels.hasKey(level):
            levels[level] = @[]

        var alertIndex = findAlert(levels[level], rule_title)
        if alertIndex == -1:
            levels[level].add((rule_title, 0, @[]))
            alertIndex = levels[level].len - 1

        levels[level][alertIndex].count += count
        levels[level][alertIndex].computers.add((computer, count, start_date, end_date))

    #
    # create a side menu
    #
    proc printSideMenu(levels: Table[string, seq[Alert]]): string =
        var ret = ""

        for level, alerts in pairs(levels):    
            var totalAlerts = 0
            for alert in alerts:
                totalAlerts += alert.count
            ret &= "<li><h3 class=\"font-semibold\">" & level & " alerts (" & totalAlerts.intToStr & ")</h3><ul>"

            for alert in alerts:
                ret &= "<li class=\"font-semibold\">■" & alert.title & " (" & alert.count.intToStr & ")<ul>"
            
                for computer in alert.computers:
                    ret &= "<li style=\"border-bottom:3px;\"><a href=\"\" class=\"inline-flex items-center gap-2 rounded-lg px-2 py-1 text-sm font-semibold text-slate-600 transition hover:bg-indigo-100 hover:text-indigo-900\">" & computer.name & " (" & computer.count.intToStr & ") (" & computer.start_date & " ~ " & computer.end_date & ")</a><li>"

                ret &= "</ul></li>"
            ret &= "</ul></li>"
        return ret

    let sidemenu = printSideMenu(levels)
    

    # Data structure of Summary
    type
        SummaryInfo = object
            totalCount: int
            totalPercent: float
            uniqueCount: int
            uniquePercent: float
            mostTotalDate: string
            mostTotalCount: int

    var summaryData = initTable[string, SummaryInfo]()

    # データを集計
    proc collectSummaryData(levels: Table[string, seq[Alert]]) =
    
        var totalDetections = 0
        var uniqueDetections = 0
        var dateCounts = initTable[string, int]()

        for level, alerts in pairs(levels):
            var totalCount = 0
            var uniqueCount = alerts.len
            var dateCounts = initTable[string, int]()  # 各レベルごとにリセット

            for alert in alerts:
                totalCount += alert.count
            
                for computer in alert.computers:
                    let date = computer.start_date.split(" ")[0]
                    if dateCounts.hasKey(date):
                        dateCounts[date] += computer.count
                    else:
                        dateCounts[date] = computer.count

            # 最大値を手動で取得
            var mostTotalDate = ""
            var mostTotalCount = -1
            for date, count in dateCounts.pairs:
                if count > mostTotalCount:
                    mostTotalDate = date
                    mostTotalCount = count

            summaryData[level] = SummaryInfo(
                totalCount: totalCount,
                totalPercent: float(totalCount) / float(totalDetections) * 100,
                uniqueCount: uniqueCount,
                uniquePercent: float(uniqueCount) / float(uniqueDetections) * 100,
                mostTotalDate: mostTotalDate,
                mostTotalCount: mostTotalCount
            )

            totalDetections += totalCount
            uniqueDetections += uniqueCount

        # 最後に全体のパーセンテージを再計算
        for level, info in pairs(summaryData):
            summaryData[level].totalPercent = float(info.totalCount) / float(totalDetections) * 100
            summaryData[level].uniquePercent = float(info.uniqueCount) / float(uniqueDetections) * 100

    collectSummaryData(levels)


    # データの出力
    proc printSummaryData(data: Table[string, SummaryInfo]): string =

        let order = @["critical", "high", "med", "low", "info"]
        var ret = "<h3 class=\"mb-1 font-semibold\">Total detections:</h3>"
        echo "Total detections:"
        
        for level in order:
            if data.hasKey(level):
                let info = data[level]
                echo "  ", level, ": ", info.totalCount, " (", info.totalPercent, "%)"
                ret &= "<p>" & level & ": " & info.totalCount.intToStr & " (" & $info.totalPercent & "%)</p>"
            
        echo "Unique detections:"
        ret &= "<h3 style=\"margin-top:16px;\" class=\"mb-1 font-semibold\">Unique detections:</h3>"
        for level in order:
            if data.hasKey(level):
                let info = data[level]
                echo "  ", level, ": ", info.uniqueCount, " (", info.uniquePercent, "%)"
                ret &= "<p>" & level & ": " & info.uniqueCount.intToStr & " (" & $info.uniquePercent & "%)</p>"
  
        echo "Dates with most total detections:"
        ret &= "<h3 style=\"margin-top:16px;\" class=\"mb-1 font-semibold\">Dates with most total detections:</h3>"
        for level in order:
            if data.hasKey(level):
                let info = data[level]
                echo "  ", level, ": ", info.mostTotalDate, " (", info.mostTotalCount, ")"
                ret &= "<p>" & level & ": " & info.mostTotalDate & " (" & info.mostTotalCount.intToStr & ")</p>"

        return ret

    let summaryHtml = printSummaryData(summaryData)
    
    # read template file
    var f: File = open("./templates/index.html", FileMode.fmRead)
    
    var html = ""
    while f.endOfFile == false :
        html &= f.readLine()
    f.close()

    # replace HTML
    html = html.replace("[%PAGE_TITLE%]", "Summary")
    html = html.replace("[%SIDE_MENU%]", sidemenu)
    html = html.replace("[%CONTENT%]", summaryHtml)    
    

    # output HTML
    let output_path = "./output" 
    if not dirExists(output_path):
        try:
            createDir(output_path)
        except OSError as e:
            echo "Failed to create directory: ", e.msg

    var write: File = open(output_path & "/index.html", FileMode.fmWrite)
    write.writeLine(html)
    write.close()

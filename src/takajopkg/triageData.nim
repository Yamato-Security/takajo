import db_connector/db_sqlite
import streams

# output: save results to a SQLite database
# timeline: Hayabusa JSONL timeline file or directory
proc triageData*(output: string, quiet: bool = false, timeline: string, rulepath: string = "") =

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

                    var level_order = -1
                    if level == "critical":
                        level_order = 4
                    elif level == "high":
                        level_order = 3
                    elif level == "med":
                        level_order = 2
                    elif level == "low":
                        level_order = 1
                    elif level == "info":
                        level_order = 0
                    else:
                        continue # exclude

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
    let query = sql"""select rule_title, rule_file, level, level_order, computer, min(timestamp) as start_date, max(timestamp) as end_date, count(*) as count
                        from timelines
                        group by rule_title, level, computer
                        order by level_order
                        """

    var alerts = db.getAllRows(query)
    
    # close sqlite file
    db.close()

    # data formatting
    type
        Computer = tuple[name: string, count: int, start_date: string, end_date: string]
        Alert = tuple[title: string, rule_file: string, level: string, count: int, computers: seq[Computer]]
        Level = tuple[level_order: int, alerts: seq[Alert]]
    
    var levels = initTable[int, seq[Alert]]()

    proc findAlert(alerts: seq[Alert], rule_title: string): int =
        for i, alert in alerts:
            if alert.title == rule_title:
                return i
        return -1

    proc extractDate(ts: string): string =
        let spacePos = ts.find(' ')
        if spacePos != -1:
            return ts[0..spacePos-1]
        return ts

    for row in alerts:
        let rule_title = row[0]
        let rule_file = row[1]
        let level = row[2]
        let level_order = row[3].parseInt
        let computer = row[4]
        let start_date = extractDate(row[5])
        let end_date = extractDate(row[6])
        let count = row[7].parseInt

        if not levels.contains(level_order):
            levels[level_order] = @[]

        var alertIndex = findAlert(levels[level_order], rule_title)
        if alertIndex == -1:
            levels[level_order].add((rule_title, rule_file, level, 0, @[]))
            alertIndex = levels[level_order].len - 1

        levels[level_order][alertIndex].count += count
        levels[level_order][alertIndex].computers.add((computer, count, start_date, end_date))

    #
    # obtain rule file path
    #  
    proc findRuleFileWithName(dir: string, fileName: string) :string =
        var result = ""
        for entry in walkDir(dir):
            let path = os.lastPathPart(entry.path)
            
            if entry.kind == pcFile and path == fileName:
                result = "../" & entry.path
                break
            elif entry.kind == pcDir:
                result = findRuleFileWithName(entry.path, fileName)
                if result != "":
                    break
        
        return result

    const severity_order = @["info", "low", "med", "high", "critical"]
    const severity_color = @["emerald", "blue", "purple", "amber", "pink"]

    var rulepath_list = initTable[string, string]()

    #
    # create a side menu
    #
    proc printSideMenu(levels: Table[int, seq[Alert]], rulepath: string, rulepath_list: var Table[string, string]): string =
        var ret = ""

        for level_order, alerts in pairs(levels):
            
            # do not display info for sidebar
            if level_order == 0: 
                continue

            var totalAlerts = 0
            for alert in alerts:
                totalAlerts += alert.count
            ret &= "<li><h3 class=\"font-semibold\">" & severity_order[level_order] & " alerts (" & totalAlerts.intToStr & ")</h3><ul>"

            for alert in alerts:
                var rule_file_path = ""
                if rulepath != "":
                    rule_filepath = findRuleFileWithName(rulepath, alert.rule_file)
                    if not rulepath_list.hasKey(alert.title):
                        rulepath_list[alert.title] = rule_filepath

                ret &= "<li class=\"font-semibold\"><a href=\"" & rule_filepath & "\">■" & alert.title & " (" & alert.count.intToStr & ")</a><ul>"
            
                for computer in alert.computers:
                    ret &= "<li style=\"border-bottom:3px;\"><a href=\"./" & computer.name & ".html\" class=\"inline-flex items-center gap-2 rounded-lg px-2 py-1 text-sm font-semibold text-slate-600 transition hover:bg-indigo-100 hover:text-indigo-900\">" & computer.name & " (" & computer.count.intToStr & ") (" & computer.start_date & " ~ " & computer.end_date & ")</a><li>"

                ret &= "</ul></li>"
            ret &= "</ul></li>"
        return ret

    let sidemenu = printSideMenu(levels, rulepath, rulepath_list)

    # Data structure of Summary
    type
        SummaryInfo = object
            totalCount: int
            totalPercent: float
            uniqueCount: int
            uniquePercent: float
            mostTotalDate: string
            mostTotalCount: int

    var summaryData = initTable[int, SummaryInfo]()

    # data aggregation
    proc collectSummaryData(levels: Table[int, seq[Alert]]) =
    
        var totalDetections = 0
        var uniqueDetections = 0
        var dateCounts = initTable[string, int]()

        for level_order, alerts in pairs(levels):
            var totalCount = 0
            var uniqueCount = alerts.len
            var dateCounts = initTable[string, int]()

            for alert in alerts:
                totalCount += alert.count
            
                for computer in alert.computers:
                    let date = computer.start_date.split(" ")[0]
                    if dateCounts.hasKey(date):
                        dateCounts[date] += computer.count
                    else:
                        dateCounts[date] = computer.count

            var mostTotalDate = ""
            var mostTotalCount = -1
            for date, count in dateCounts.pairs:
                if count > mostTotalCount:
                    mostTotalDate = date
                    mostTotalCount = count

            summaryData[level_order] = SummaryInfo(
                totalCount: totalCount,
                totalPercent: float(totalCount) / float(totalDetections) * 100,
                uniqueCount: uniqueCount,
                uniquePercent: float(uniqueCount) / float(uniqueDetections) * 100,
                mostTotalDate: mostTotalDate,
                mostTotalCount: mostTotalCount
            )

            totalDetections += totalCount
            uniqueDetections += uniqueCount

        for level_order, info in pairs(summaryData):
            summaryData[level_order].totalPercent = float(info.totalCount) / float(totalDetections) * 100
            summaryData[level_order].uniquePercent = float(info.uniqueCount) / float(uniqueDetections) * 100

    collectSummaryData(levels)


    # create a summary
    proc printSummaryData(data: Table[int, SummaryInfo]): string =

        var ret = "<h3 class=\"mb-1 font-semibold\">Total detections:</h3>"
        for level_order, alerts in pairs(levels):
            let info = data[level_order]
            ret &= "<p>" & severity_order[level_order] & ": " & info.totalCount.intToStr & " (" & $info.totalPercent & "%)</p>"
            
        ret &= "<h3 style=\"margin-top:16px;\" class=\"mb-1 font-semibold\">Unique detections:</h3>"
        for level_order, alerts in pairs(levels):
            let info = data[level_order]
            ret &= "<p>" & severity_order[level_order] & ": " & info.uniqueCount.intToStr & " (" & $info.uniquePercent & "%)</p>"
  
        ret &= "<h3 style=\"margin-top:16px;\" class=\"mb-1 font-semibold\">Dates with most total detections:</h3>"
        for level_order, alerts in pairs(levels):
            let info = data[level_order]
            ret &= "<p>" & severity_order[level_order] & ": " & info.mostTotalDate & " (" & info.mostTotalCount.intToStr & ")</p>"

        return ret

    let summaryHtml = printSummaryData(summaryData)
    
    # read template file
    var f: File = open("./templates/index.template", FileMode.fmRead)
    
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

    ### each Computer output
    type
        ComputerSummary = object
            totalDetections: Table[int, int]
            detectionsByDate: Table[string, seq[int]]
            detectedRules: seq[(string, string, int)]

    var computerSummaries = initTable[string, ComputerSummary]()
    
    for level_order, alerts in pairs(levels):
        for alert in alerts:
            for computer in alert.computers:
                let compName = computer.name

                if not computerSummaries.hasKey(compName):
                    computerSummaries[compName] = ComputerSummary(
                        totalDetections: initTable[int, int](),
                        detectionsByDate: initTable[string, seq[int]](),
                        detectedRules: @[]
                    )
                    for key in 0..4:
                        computerSummaries[compName].totalDetections[key] = 0

                var compSummary = computerSummaries[compName]

                # Calculate the total for each level
                compSummary.totalDetections[level_order] += computer.count

                # List of detected levels by date
                let date = computer.start_date.split(" ")[0]  # only the date portion is acquired.
                if not compSummary.detectionsByDate.hasKey(date):
                    compSummary.detectionsByDate[date] = @[]
                if not level_order in compSummary.detectionsByDate[date]:
                    compSummary.detectionsByDate[date].add(level_order)
                
                # List of detected rules
                if not ((alert.title, alert.rule_file, level_order) in compSummary.detectedRules):
                    compSummary.detectedRules.add((alert.title, alert.rule_file, level_order))

                computerSummaries[compName] = compSummary



    for compName, summary in pairs(computerSummaries):
        echo compName

        # read template file
        var f: File = open("./templates/content.template", FileMode.fmRead)
    
        var html = ""
        while f.endOfFile == false :
            html &= f.readLine()
        f.close()

        # replace HTML
        html = html.replace("[%PAGE_TITLE%]", compName)
        html = html.replace("[%SIDE_MENU%]", sidemenu)
    
        # html = html.replace("[%CONTENT%]", summaryHtml)

        for level_order, count in pairs(summary.totalDetections):
            html = html.replace("[%" & severity_order[level_order].toUpper & "_NUM%]", count.intToStr)

        echo "Detections by date:"
        for date, levels in pairs(summary.detectionsByDate):
            echo "  ", date, ": ", levels
  
        echo "Detected rules:"
        var temp_html = "<table class=\"min-w-full align-middle text-sm\">"
        temp_html &= "<thead><tr class=\"border-b-2 border-slate-100\">"
        temp_html &= "<th class=\"min-w-[180px] py-3 pe-3 text-start text-sm font-semibold uppercase tracking-wider text-slate-700\">Alert Title</th>"
        temp_html &= "<th class=\"min-w-[180px] py-3 pe-3 text-start text-sm font-semibold uppercase tracking-wider text-slate-700\">Rule Path</th>"
        temp_html &= "<th class=\"min-w-[180px] py-3 pe-3 text-start text-sm font-semibold uppercase tracking-wider text-slate-700\">severity</th>"
        temp_html &= "</tr></thead><tbody>"
        
        # sort by severity order
        proc compare(a, b: (string, string, int)): int =
            cmp(a[2], b[2])
        let detectedRules = summary.detectedRules.sorted(compare, Descending)
        
        for rule in detectedRules:
            var rule_filepath = ""
            if rulepath_list.hasKey(rule[0]):
                rule_filepath = rulepath_list[rule[0]]
            else:
                # In the case of info, there is no data, so make here
                rule_filepath = findRuleFileWithName(rulepath, rule[0])
                rulepath_list[rule[0]] = rule_filepath

            # let rule_filepath = rulepath_list[rule[0]]
            temp_html &= "<tr class=\"border-b border-gray-100\">"
            temp_html &= "<td class=\"p-3 font-medium\">" & rule[0] & "</td>"
            temp_html &= "<td><a href=\"" & rulefile_path & "\" class=\"text-indigo-500 hover:text-indigo-700\">" & rule[1] & "</a></td>"
            temp_html &= "<td><div class=\"inline-block rounded-full bg-" & severity_color[rule[2]] & "-100 px-2 py-1 text-xs font-semibold leading-4 text-" & severity_color[rule[2]] & "-800\">" & severity_order[rule[2]] & "</td>"
            temp_html &= "</tr>"
        temp_html &= "</tbody></table>"
        html = html.replace("[%CONTENT%]", temp_html)

        var write: File = open(output_path & "/" & compName & ".html", FileMode.fmWrite)
        write.writeLine(html)
        write.close()


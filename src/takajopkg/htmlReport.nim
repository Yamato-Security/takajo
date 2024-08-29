import db_connector/db_sqlite
import streams

const HtmlReportMsg = "This command will create HTML summary reports for rules and computers with detections"

import os, strutils

proc copyDirectory(src: string, dest: string) =
    if not dirExists(src):
        return

    if not dirExists(dest):
        createDir(dest)

    for entry in walkDir(src):
        let path = os.lastPathPart(entry.path)
        let destPath = joinPath(dest, path)

        if entry.kind == pcFile:
            copyFile(entry.path, destPath)
        elif entry.kind == pcDir:
            createDir(destPath)
            


# output: HTML reports directory name
# sqliteoutput: save results to a SQLite database
# timeline: Hayabusa JSONL timeline file or directory
proc htmlReport*(output: string, quiet: bool = false, timeline: string, rulepath: string = "", clobber: bool = false, sqliteoutput: string = "html-report.sqlite", skipProgressBar: bool = false, ) =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if fileExists(sqliteoutput) and clobber == false:
        echo sqliteoutput & " already exists. Please add the -C, --clobber option to overwrite the file."
        return

    # create sqlite file or open exist database file.
    let db = open(sqliteoutput, "", "", "")
    try:
        try:
            let dropTableSQL = sql"""DROP TABLE timelines"""
            db.exec(dropTableSQL)
        except:
            discard

        # create timelines table
        let createTableSQL = sql"""CREATE TABLE timelines (
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
        
        var bar: SuruBar
        if not skipProgressBar:
            bar = initSuruBar()
            bar[0].total = countJsonlAndStartMsg("html-report", HtmlReportMsg, timeline)
            bar.setup()

        db.exec(sql"BEGIN")
        var recordCount = 0
        while not fileStream.atEnd:
            let line = fileStream.readLine()
            if line.len > 0:
                try:
                    #
                    # write to sqlite
                    #

                    let jsonObj = parseJson(line)

                    # parameter check
                    if "RuleFile" notin jsonObj or "EvtxFile" notin jsonObj:
                        bar.finish()
                        echo ""
                        echo "Takajo needs information that is not included in the JSONL results."
                        echo "Please re-run Hayabusa with \"-p verbose\" or \"-p super-verbose\" profiles."
                        return

                    # common parameters
                    let timestamp = jsonObj["Timestamp"].getStr()
                    let rule_title = jsonObj["RuleTitle"].getStr()
                    let level = jsonObj["Level"].getStr()
                    let computer = jsonObj["Computer"].getStr()
                    let channel = jsonObj["Channel"].getStr()
                    let event_id = jsonObj["EventID"].getInt()
                    let record_id = jsonObj["RecordID"].getStr()
                    let rule_file = jsonObj["RuleFile"].getStr()
                    let evtx_file = jsonObj["EvtxFile"].getStr()

                    var level_order = -1
                    if level == "crit":
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
                    recordCount += 1
                    if not skipProgressBar:
                        inc bar
                        bar.update(1000000000)

                    if recordCount %% 10000 == 0:
                        db.exec(sql"COMMIT")
                        db.exec(sql"BEGIN")
                    
                except CatchableError as e:
                    echo "Invalid JSON line: ", line

        db.exec(sql"COMMIT")
        fileStream.close()
        if not skipProgressBar:
            bar.finish()

        echo ""
        echo "Database file created."
    except CatchableError as e:
        echo "Error: Database file not created!, ", e.msg
        discard
        return
    
    echo "Creating HTML report. Please wait.\p"

    # start analysis timeline
    # obtain datas from SQLite
    var query = sql"""select rule_title, rule_file, level, level_order, computer, min(timestamp) as start_date, max(timestamp) as end_date, count(*) as count
                        from timelines
                        group by rule_title, level, computer
                        order by level_order
                        """

    var alerts = db.getAllRows(query)


    # obtain computer summary from SQLite
    query = sql"""select computer, COUNT(*) AS count
                        from timelines
                        group by computer
                        having COUNT(*) > 1
                        order by count desc
                        """
    var computers = db.getAllRows(query)
    
    # close sqlite file
    db.close()
    

    # data formatting
    type
        Computer = tuple[name: string, count: int, start_date: string, end_date: string]
        Alert = tuple[title: string, rule_file: string, level: string, count: int, computers: seq[Computer]]
    
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
        
        var foundPath = ""
        for entry in walkDir(dir):
            let path = os.lastPathPart(entry.path)
            
            if entry.kind == pcFile and path == fileName:
                foundPath = absolutePath(entry.path)
                break
            elif entry.kind == pcDir:
                foundPath = findRuleFileWithName(entry.path, fileName)
                if foundPath != "":
                    break
        
        return foundPath

    const severity_order = @["info", "low", "med", "high", "critical"]
    const severity_color = @["blue", "green", "yellow", "orange", "red"]

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
            ret &= "<li><button class=\"toggle-btn\" data-severity=\"" & severity_order[level_order] & "\" ><i class=\"icon fas fa-chevron-right\"></i>" & severity_order[level_order] & " alerts (" & totalAlerts.intToStr & ")</button><ul class=\"submenu\">"

            for alert in alerts:
                var rule_file_path = ""
                if rulepath != "":
                    rule_filepath = findRuleFileWithName(rulepath, alert.rule_file)
                    if not rulepath_list.hasKey(alert.title):
                        rulepath_list[alert.title] = rule_filepath

                ret &= "<li class=\"font-semibold\"><a style=\"font-size:10pt !important;\" href=\"" & rule_filepath & "\">■" & alert.title & " (" & alert.count.intToStr & ")</a><ul>"
            
                for computer in alert.computers:
                    ret &= "<li style=\"border-bottom:3px;\"><a data-class=\"" & severity_order[level_order] & "\" style=\"font-size:10pt !important;\" href=\"./" & computer.name & ".html\" class=\"sidemenu link inline-flex items-center gap-2 rounded-lg px-2 py-1 text-sm font-semibold text-slate-600 transition hover:bg-indigo-100 hover:text-indigo-900\">" & computer.name & " (" & computer.count.intToStr & ") (" & computer.start_date & " ~ " & computer.end_date & ")</a><li>"

                ret &= "</ul></li>"
            ret &= "</ul></li>"
        return ret

    let sidemenu = printSideMenu(levels, rulepath, rulepath_list)

    proc printSideMenuComputer(computers: seq[seq[string]]): string = 
        var ret = ""
        for computer in computers:
            ret &= "<li><a data-class=\"computer\" style=\"font-size:10pt !important;\" href=\"./" & computer[0] & ".html\" class=\"sidemenu inline-flex items-center gap-2 rounded-lg px-2 py-1 text-sm font-semibold text-slate-600 transition hover:bg-indigo-100 hover:text-indigo-900\">" & computer[0] & "(" & computer[1] & ")</a></li>"
        
        return ret

    let sidemenucomputers = printSideMenuComputer(computers)

    # Data structure of Summary
    type
        SummaryInfo = object
            totalCount: int
            totalPercent: float
            uniqueCount: int
            uniquePercent: float
            mostTotalDate: string
            mostTotalCount: int

    #
    # data aggregation
    #
    proc collectSummaryData(levels: Table[int, seq[Alert]]): Table[int, SummaryInfo] =
    
        var totalDetections = 0
        var uniqueDetections = 0
        var summaryData = initTable[int, SummaryInfo]()

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

        return summaryData

    var summaryData = collectSummaryData(levels)

    #
    # create a summary
    #
    proc printSummaryData(data: Table[int, SummaryInfo]): (string, string, string) =

        var total_detections = ""
        
        for level_order in countdown(4, 0):
            if not data.hasKey(level_order):
                continue 
            let info = data[level_order]
            let tmp_total_percent = info.totalPercent.formatFloat(ffDecimal, 2)
            total_detections &= "<tr class=\"border-b border-gray-100\">"
            total_detections &= "<td class=\"p-3 font-medium\"><div class=\"inline-block rounded-full bg-" & severity_color[level_order] & "-100 px-2 py-1 text-xs font-semibold leading-4 text-" & severity_color[level_order] & "-800\">" & severity_order[level_order] & "</td>"
            total_detections &= "<td class=\"p-3 font-medium\">" & $info.totalCount & "</td>"
            total_detections &= "<td class=\"p-3 font-medium\">" & $tmp_total_percent & "%</td>"
            total_detections &= "</tr>"

        var unique_detections = ""
        for level_order in countdown(4, 0):
            if not data.hasKey(level_order):
                continue 
            let info = data[level_order]
            let tmp_unique_percent = info.uniquePercent.formatFloat(ffDecimal, 2)
            unique_detections &= "<tr class=\"border-b border-gray-100\">"
            unique_detections &= "<td class=\"p-3 font-medium\"><div class=\"inline-block rounded-full bg-" & severity_color[level_order] & "-100 px-2 py-1 text-xs font-semibold leading-4 text-" & severity_color[level_order] & "-800\">" & severity_order[level_order] & "</td>"
            unique_detections &= "<td class=\"p-3 font-medium\">" & $info.uniqueCount & "</td>"
            unique_detections &= "<td class=\"p-3 font-medium\">" & $tmp_unique_percent & "%</td>"
            unique_detections &= "</tr>"
  
        var date_with_most_total_detections = ""
        for level_order in countdown(4, 0):
            if not data.hasKey(level_order):
                continue 
            let info = data[level_order]
            date_with_most_total_detections &= "<tr class=\"border-b border-gray-100\">"
            date_with_most_total_detections &= "<td class=\"p-3 font-medium\"><div class=\"inline-block rounded-full bg-" & severity_color[level_order] & "-100 px-2 py-1 text-xs font-semibold leading-4 text-" & severity_color[level_order] & "-800\">" & severity_order[level_order] & "</td>"
            date_with_most_total_detections &= "<td class=\"p-3 font-medium\">" & info.mostTotalDate & "</td>"
            date_with_most_total_detections &= "<td class=\"p-3 font-medium\">" & $info.mostTotalCount & "</td>"
            date_with_most_total_detections &= "</tr>"

        return (total_detections, unique_detections, date_with_most_total_detections)

    let (total_detections, unique_detections, date_with_most_total_detections) = printSummaryData(summaryData)
    
    # read template file
    var f: File = open("./templates/index.template", FileMode.fmRead)
    
    var html = ""
    while f.endOfFile == false :
        html &= f.readLine()
    f.close()

    # replace HTML
    html = html.replace("[%PAGE_TITLE%]", "Rule Summary")
    html = html.replace("[%SIDE_MENU%]", sidemenu)
    html = html.replace("[%SIDE_MENU_COMPUTER%]", sidemenucomputers)
    html = html.replace("[%TOTAL_DETECTIONS%]", total_detections)
    html = html.replace("[%UNIQUE_DETECTIONS%]", unique_detections)
    html = html.replace("[%DATE_WITH_MOST_TOTAL_DETECTIONS%]", date_with_most_total_detections)
    
    # output HTML
    let output_path = "./" & output 
    if not dirExists(output_path):
        try:
            createDir(output_path)
        except OSError as e:
            echo "Failed to create directory: ", e.msg
            return
 
    var write: File = open(output_path & "/index.html", FileMode.fmWrite)
    write.writeLine(html)
    write.close()

    # each Computer output
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
                    compSummary.detectionsByDate[date] = @[0, 0, 0, 0, 0]
                
                compSummary.detectionsByDate[date][level_order] += computer.count
                
                # List of detected rules
                if not ((alert.title, alert.rule_file, level_order) in compSummary.detectedRules):
                    compSummary.detectedRules.add((alert.title, alert.rule_file, level_order))

                computerSummaries[compName] = compSummary



    for compName, summary in pairs(computerSummaries):
        
        # read template file
        var f: File = open("./templates/content.template", FileMode.fmRead)
    
        var html = ""
        while f.endOfFile == false :
            html &= f.readLine()
        f.close()

        # replace HTML
        html = html.replace("[%PAGE_TITLE%]", compName)
        html = html.replace("[%SIDE_MENU%]", sidemenu)
        html = html.replace("[%SIDE_MENU_COMPUTER%]", sidemenucomputers)
    
        # html = html.replace("[%CONTENT%]", summaryHtml)

        for level_order, count in pairs(summary.totalDetections):
            html = html.replace("[%" & severity_order[level_order].toUpper & "_NUM%]", count.intToStr)

        proc parseDate(dateStr: string): DateTime =
            result = parse(dateStr, "yyyy-MM-dd")

        var items = toSeq(summary.detectionsByDate.pairs())
        
        let sortedDates = summary.detectionsByDate.keys.toSeq.map(proc(key: string): tuple[original: string, parsed: DateTime] = (key, parseDate(key))).sorted(proc(a, b: tuple[original: string, parsed: DateTime]): int = cmp(a.parsed, b.parsed))

        # Display data in sorted order
        let length = len(summary.detectionsByDate)
        var date_html = ""
        var datasets_html = @["", "", "", "", ""]
        for i, date in sortedDates:
            date_html &= "'" & date.original & "'"

            for index in 0..4:
                datasets_html[index] &= $summary.detectionsByDate[date.original][index]

            if i != length-1:
                date_html &= ","
                for index in 0..4:
                    datasets_html[index] &= ","

        html = html.replace("[%DATE_STR%]", date_html)
        html = html.replace("[%CRITICAL_GRAPH%]", datasets_html[4])
        html = html.replace("[%HIGH_GRAPH%]", datasets_html[3])
        html = html.replace("[%MEDIUM_GRAPH%]", datasets_html[2])
        html = html.replace("[%LOW_GRAPH%]", datasets_html[1])
        html = html.replace("[%INFO_GRAPH%]", datasets_html[0])

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

    var sourceFile = "./templates/alpinejs.3.14.1.js"
    var destinationFile = "./" & output & "/alpinejs.3.14.1.js"
    copyFile(sourceFile, destinationFile)

    sourceFile = "./templates/tailwind.3.4.js"
    destinationFile = "./" & output & "/tailwind.3.4.js"
    copyFile(sourceFile, destinationFile)

    sourceFile = "./templates/font-awesome.6.0.css"
    destinationFile = "./" & output & "/font-awesome.6.0.css"
    copyFile(sourceFile, destinationFile)

    let sourceDir = "./templates/webfonts"
    let destinationDir = "./" & output & "/webfonts"
    copyDirectory(sourceDir, destinationDir)
    
    echo "HTML report completed."
    echo ""
    echo "Please open \"./" & output & "/index.html\""
    echo ""


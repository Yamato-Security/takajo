import prologue
import urls

const rulesUrl = "https://github.com/Yamato-Security/hayabusa-rules/blob/main"

#
# obtain rule file path
#  
proc findRuleFileWithName(dir: string, fileName: string) :string =
    
    var rule_url = ""
    for entry in walkDir(dir):
        let path = os.lastPathPart(entry.path)
        
        if entry.kind == pcFile and path == fileName:
            rule_url = rulesUrl & "/" & entry.path
            break
        elif entry.kind == pcDir:
            rule_url = findRuleFileWithName(entry.path, fileName)
            if rule_url != "":
                break
    
    return rulesUrl

proc createSQLite*(quiet: bool = false, timeline: string, rulepath: string, clobber: bool = false, sqliteoutput: string = "html-report.sqlite", skipProgressBar: bool = false): bool =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if fileExists(sqliteoutput) and clobber == false:
        echo sqliteoutput & " already exists. Please add the -C, --clobber option to overwrite the file."
        return false

    # create sqlite file or open exist database file.
    let db = open(sqliteoutput, "", "", "")
    try:

        # drop tables
        try:
            var dropTableSQL = sql"""DROP TABLE timelines"""
            db.exec(dropTableSQL)
        
            dropTableSQL = sql"""DROP TABLE rule_files"""
            db.exec(dropTableSQL)
        except:
            discard


        # create timelines table
        var createTableSQL = sql"""CREATE TABLE timelines (
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

        # create rule_files table
        createTableSQL = sql"""CREATE TABLE rule_files (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            alert_title TEXT,
            rule_path TEXT
        )"""
        db.exec(createTableSQL)

        # read from timeline file
        # open timeline file
        var fileStream = newFileStream(timeline, fmRead)

        if fileStream == nil:
            echo "Failed to open file: ", timeline
            return false
        
        var bar: SuruBar
        if not skipProgressBar:
            bar = initSuruBar()
            bar[0].total = countJsonlAndStartMsg("html-report", HtmlReportMsg, timeline)
            bar.setup()

        db.exec(sql"BEGIN")
        var recordCount = 0
        var alert_title_list: seq[string] = @[]

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

                    if not (rule_title in alert_title_list):
                        alert_title_list.add(rule_title)

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

        var rule_path = ""
        for value in alert_title_list:
            let insertSQL = """INSERT INTO rule_files (
                alert_title,
                rule_path
            ) VALUES (?, ?)"""

            rule_path = findRuleFileWithName(rulepath, value)
                    
            var stmt = db.prepare(insertSQL)
            stmt.bindParams(value, rule_path)
            let bres = db.tryExec(stmt)
            doAssert(bres)
            finalize(stmt)

        db.exec(sql"COMMIT")
        fileStream.close()
        if not skipProgressBar:
            bar.finish()

        echo ""
        echo "Database file created."
    except CatchableError as e:
        echo "Error: Database file not created!, ", e.msg
        discard
        return false
    
    return true


#
#
#
proc initialServer(port: int) =

    var f = open("./templates/common.js", FileMode.fmRead)

    var html = ""
    while f.endOfFile == false :
        html &= f.readLine() & "\n"
    f.close()

    html = html.replace("[%PORT%]", $port)
    
    var write = open("./src/takajopkg/web/static/js/common.js", FileMode.fmWrite)
    write.writeLine(html)
    write.close()


#
# Server Settings
# 
proc htmlServer*(port: int = 8089, quiet: bool = false, timeline: string, rulepath: string = "", clobber: bool = false, sqliteoutput: string = "html-report.sqlite", skipProgressBar: bool = false) =
    
    let ret = createSQLite(quiet, timeline, rulepath, clobber, sqliteoutput, skipProgressBar)
    if ret == false:
        return
    

    if fileExists(sqliteoutput) == false:
        echo "Not found sqlite file: " & sqliteoutput
        return

    initialServer(port)

    let settings = newSettings(
        appName = sqliteoutput,
        debug = true,
        port = Port(port)
    )

    let app = newApp(settings = settings)
    app.addRoute(urls.urlPatterns, "")    
    app.run()


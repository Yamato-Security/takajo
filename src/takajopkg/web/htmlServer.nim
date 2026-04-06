import prologue
import urls

const HtmlServerMsg = "This command will create a web server that hosts a dynamic summaries for rules and computers with detections."

#
# obtain rule file path
#
proc findRuleFileWithName(original_dir: string, dir: string, fileName: string) :string =

    var l_rule_url = ""
    for entry in walkDir(dir):
        let path = os.lastPathPart(entry.path)
        if entry.kind == pcFile and path == fileName:
            l_rule_url = entry.path
            break
        elif entry.kind == pcDir:
            l_rule_url = findRuleFileWithName(original_dir, entry.path, fileName)
            if l_rule_url != "":
                break

    return l_rule_url

proc createDatabase*(quiet: bool = false, timeline: string, rulepath: string, clobber: bool = false, dboutput: string = "html-report.duckdb", sqlite: bool = false, skipProgressBar: bool = false): bool =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    let backend = if sqlite: backendSQLite else: backendDuckDB
    let actualDbOutput = if dboutput != "":
                           dboutput
                         elif sqlite:
                           "html-report.sqlite"
                         else:
                           "html-report.duckdb"

    if fileExists(actualDbOutput) and clobber == false:
        echo actualDbOutput & " already exists. It looks like you have already processed the JSONL file. Do you want to use this file (Y/n):"

        while true:
            let input = stdin.readLine().strip()
            if input == "" or input.toLowerAscii() == "y":
                return true # use already existing database file
            elif input.toLowerAscii() == "n":
                break # create new database file
            else:
                echo "Invalid input"

    # create database file
    var db = openDb(actualDbOutput, backend)
    try:

        # drop tables
        db.exec("DROP TABLE IF EXISTS timelines")
        db.exec("DROP TABLE IF EXISTS rule_files")

        # create timelines table
        db.createTimelinesTable()

        # create rule_files table
        db.createRuleFilesTable()

        # read from timeline file
        # open timeline file
        var fileStream = newFileStream(timeline, fmRead)

        if fileStream == nil:
            echo "Failed to open file: ", timeline
            return false

        var bar: SuruBar
        if not skipProgressBar:
            bar = initSuruBar()
            bar[0].total = countJsonlAndStartMsg("html-server", HtmlServerMsg, timeline)
            bar.setup()

        db.beginTransaction()
        var recordCount = 0
        var alert_title_list: seq[(string, string)] = @[]


        while not fileStream.atEnd:
            let line = fileStream.readLine()
            if line.len > 0:
                try:
                    #
                    # write to database
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
                    var record_id = ""
                    if "RecordID" in jsonObj:
                        record_id = jsonObj["RecordID"].getStr()
                    let rule_file = jsonObj["RuleFile"].getStr()
                    let evtx_file = jsonObj["EvtxFile"].getStr()

                    if (rule_title, rule_file) notin alert_title_list:
                        alert_title_list.add((rule_title, rule_file))


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

                    let bres = db.insertRow(insertSQL, timestamp,
                        rule_title,
                        level,
                        $level_order,
                        computer,
                        channel,
                        $event_id,
                        record_id,
                        rule_file,
                        evtx_file,
                        rule_author,
                        rule_modified_date,
                        rule_creation_date,
                        status)

                    doAssert(bres)
                    recordCount += 1
                    if not skipProgressBar:
                        inc bar
                        bar.update(1000000000)

                    if recordCount %% 10000 == 0:
                        db.commitTransaction()
                        db.beginTransaction()

                except CatchableError:
                    echo "Invalid JSON line: ", line

        for (rule_title, rule_file) in alert_title_list:
            let insertSQL = """INSERT INTO rule_files (
                alert_title,
                rule_path
            ) VALUES (?, ?)"""

            var local_rule_path = findRuleFileWithName(rulepath, rulepath, rule_file)
            let bres = db.insertRow(insertSQL, rule_title, local_rule_path)
            doAssert(bres)

        db.commitTransaction()
        fileStream.close()
        if not skipProgressBar:
            bar.finish()

        echo ""
        echo "Database file created."
    except CatchableError as e:
        echo "Error: Database file not created!, ", e.msg
        discard
        return false

    db.closeDb()
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

    var write = open("./templates/static/js/common.js", FileMode.fmWrite)
    write.writeLine(html)
    write.close()


#
# Server Settings
#
proc htmlServer*(port: int = 8823, quiet: bool = false, timeline: string, rulepath: string = "", clobber: bool = false, dboutput: string = "", sqlite: bool = false, skipProgressBar: bool = false) =

    let backend = if sqlite: backendSQLite else: backendDuckDB
    let actualDbOutput = if dboutput != "":
                           dboutput
                         elif sqlite:
                           "html-report.sqlite"
                         else:
                           "html-report.duckdb"

    let ret = createDatabase(quiet, timeline, rulepath, clobber, actualDbOutput, sqlite, skipProgressBar)
    if ret == false:
        return


    if fileExists(actualDbOutput) == false:
        echo "Not found database file: " & actualDbOutput
        return

    initialServer(port)

    let settings = newSettings(
        appName = actualDbOutput,
        debug = false,
        port = Port(port)
    )
    echo "You can access the HTML summary reports at http://localhost:" & $port

    let app = newApp(settings = settings)
    app.addRoute(urls.urlPatterns, "")
    app.run()

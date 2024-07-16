import general
import json
import db_connector/db_sqlite
import streams
import strutils

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
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"""
                    
                    var stmt = db.prepare(insertSQL)
                    stmt.bindParams(timestamp, 
                        rule_title, 
                        level, 
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
    
    # close sqlite file
    db.close()

    return
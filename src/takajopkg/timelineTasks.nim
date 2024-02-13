proc extractText(allXmlNodes:XmlNode, tag:string): string =
    let xmlNodes = allXmlNodes.findAll(tag)
    if len(xmlNodes) > 0:
        var xml = $xmlNodes[0]
        return decodeEntity(xml.replace("<" & tag & ">", "").replace("</" & tag & ">",""))
    return ""

proc timelineTasks(output: string, outputLogoffEvents: bool = false, quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
            quit(1)

    echo "Started the Timeline Logon command"
    echo ""
    echo "This command creates a CSV timeline of scheduled tasks."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    echo "Creating a logon timeline. Please wait."
    echo ""

    var
        bar: SuruBar = initSuruBar()
        results = newSeq[array[9, string]]()

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000)
        let jsonLine = parseJson(line)
        let eventId = jsonLine["EventID"].getInt(0)
        let channel = jsonLine["Channel"].getStr("N/A")
        if eventId == 4698 and channel == "Sec":
            let ts = jsonLine["Timestamp"].getStr("N/A")
            let taskName = jsonLine["Details"]["Name"].getStr("N/A")
            let subjectUserName = jsonLine["Details"]["User"].getStr("N/A")
            let subjectUserSid = jsonLine["ExtraFieldInfo"]["SubjectUserSid"].getStr("N/A")
            let subjectDomainName = jsonLine["ExtraFieldInfo"]["SubjectDomainName"].getStr("N/A")
            let subjectLogonId = jsonLine["Details"]["LID"].getStr("N/A")
            let content = jsonLine["Details"]["Content"].getStr("N/A").replace("\\r\\n", "")
            let node = parseXml(content)
            let commands = extractText(node, "Command")
            let arguments = extractText(node, "Arguments")
            results.add([ts, subjectUserName, taskName, commands, arguments, subjectUserSid, subjectDomainName, subjectLogonId, content])

    bar.finish()


    # Save results
    var outputFile = open(output, fmWrite)
    let header = ["Timestamp", "SubjectUserName", "TaskName", "Command", "Arguments","SubjectUserSid", "SubjectDomainName", "SubjectLogonId", "TaskContent"]

    ## Write CSV header
    for h in header:
        outputFile.write(h & ",")
    outputFile.write("\p")

    ## Write contents
    for row in results:
        for column in row:
            outputFile.write(escapeCsvField(column) & ",")
        outputFile.write("\p")
    let fileSize = getFileSize(output)
    outputFile.close()

    echo ""
    echo "Saved results to " & output & " (" & formatFileSize(fileSize) & ")"
    echo ""

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
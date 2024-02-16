proc extractText(allXmlNodes:XmlNode, tag:string): string =
    let xmlNodes = allXmlNodes.findAll(tag)
    if len(xmlNodes) > 0:
        var xml = $xmlNodes[0]
        return decodeEntity(xml.replace("<" & tag & ">", "").replace("</" & tag & ">",""))
    return ""

proc walkXml(node:XmlNode, tagName: string, resuls: var OrderedTable[string, string]) =
  if node.len == 0 and node.innerText.len != 0:
      resuls[tagName] = node.innerText
      return
  for child in node:
      if tagName != tag(node):
          walkXml(child, tagName & ":" & tag(node), resuls)
      else:
          walkXml(child, tag(node), resuls)

proc timelineTasks(output: string, outputLogoffEvents: bool = false, quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    if not isJsonConvertible(timeline):
            quit(1)

    echo "Started the Timeline Tasks command"
    echo ""
    echo "This command creates a CSV timeline of scheduled task events."
    echo ""

    echo "Counting total lines. Please wait."
    echo ""
    let totalLines = countLinesInTimeline(timeline)
    echo "Total lines: ", totalLines
    echo ""

    echo "Creating a scheduled tasks timeline. Please wait."
    echo ""

    var
        bar: SuruBar = initSuruBar()
        rowData = newSeq[(OrderedTable[string, string], OrderedTable[string, string])]()

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
            var basicTable = initOrderedTable[string, string]()
            basicTable["Timestamp"] = ts
            basicTable["TaskName"] = taskName
            basicTable["User"] = subjectUserName
            basicTable["SubjectUserSid"] = subjectUserSid
            basicTable["SubjectDomainName"] = subjectDomainName
            basicTable["SubjectLogonId"] = subjectLogonId
            var detailedTable = initOrderedTable[string, string]()
            try:
                let rootNode = parseXml(content)
                basicTable["Command"] = extractText(rootNode, "Command")
                basicTable["Arguments"] = extractText(rootNode, "Arguments")
                for tagName in ["Triggers", "Principal", "Settings", "RegistrationInfo"]:
                    for i, node in enumerate(rootNode.findAll(tagName)):
                        if i == 0:
                            walkXml(node, tagName , detailedTable)
                        else:
                            walkXml(node, tagName & "[" & intToStr(i) & "]", detailedTable)
            except XmlError:
                continue
            rowData.add((basicTable, detailedTable))

    bar.finish()

    if rowData.len == 0:
        echo ""
        echo "No scheduled task events were found."
        echo ""
    else:
        var allDetailedKeys = initOrderedSet[string]()
        for (_, detailedTable) in rowData:
            for key in detailedTable.keys:
                allDetailedKeys.incl(key)
        let basicHeader = @["Timestamp", "TaskName", "User", "SubjectUserSid", "SubjectDomainName", "SubjectLogonId", "Command", "Arguments"]
        let detailedHeader = toSeq(allDetailedKeys)

        # Save results
        var outputFile = open(output, fmWrite)

        ## Write CSV header
        let header = concat(basicHeader, detailedHeader)
        for h in header:
            outputFile.write(h & ",")
        outputFile.write("\p")

        ## Write contents
        for (basicTable, detailedTable) in rowData:
            for i, columnName in enumerate(header):
                if columnName in basicHeader:
                    outputFile.write(basicTable[columnName] & ",")
                elif i > basicHeader.len - 1:
                    if columnName in detailedTable:
                        outputFile.write(escapeCsvField(detailedTable[columnName]) & ",")
                    else:
                        outputFile.write(",")
            outputFile.write("\p")
        outputFile.close()
        let fileSize = getFileSize(output)

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
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
    checkArgs(quiet, timeline, "informational")

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
        let jsonLine:HayabusaJson = line.fromJson(HayabusaJson)
        let eventId = jsonLine.EventID
        let channel = jsonLine.Channel
        if eventId == 4698 and channel == "Sec":
            let ts = jsonLine.Timestamp
            let taskName = jsonLine.Details["Name"].getStr("N/A")
            let subjectUserName = jsonLine.Details["User"].getStr("N/A")
            let subjectUserSid = jsonLine.ExtraFieldInfo["SubjectUserSid"].getStr("N/A")
            let subjectDomainName = jsonLine.ExtraFieldInfo["SubjectDomainName"].getStr("N/A")
            let subjectLogonId = jsonLine.Details["LID"].getStr("N/A")
            let content = jsonLine.Details["Content"].getStr("N/A").replace("\\r\\n", "")
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
        let detailedHeader = toSeq(allDetailedKeys).sorted

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
        outputElapsedTime(startTime)
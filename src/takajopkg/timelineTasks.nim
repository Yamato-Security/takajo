const TimelineTasksMsg = "This command creates a CSV timeline of scheduled task events."

type
  TimelineTasksCmd* = ref object of AbstractCmd
      rowData* = newSeq[(OrderedTable[string, string], OrderedTable[string, string])]()
      outputLogoffEvents: bool

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

method filter*(self: TimelineTasksCmd, x: HayabusaJson):bool =
    return x.EventId == 4698 and x.Channel == "Sec"

method analyze*(self: TimelineTasksCmd, x: HayabusaJson) =
      let ts = x.Timestamp
      let taskName = x.Details["Name"].getStr("N/A")
      let subjectUserName = x.Details["User"].getStr("N/A")
      let subjectUserSid = x.ExtraFieldInfo["SubjectUserSid"].getStr("N/A")
      let subjectDomainName = x.ExtraFieldInfo["SubjectDomainName"].getStr("N/A")
      let subjectLogonId = x.Details["LID"].getStr("N/A")
      let content = x.Details["Content"].getStr("N/A").replace("\\r\\n", "")
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
          return
      self.rowData.add((basicTable, detailedTable))

method resultOutput*(self: TimelineTasksCmd)=
    var savedFiles = "n/a"
    var results = "n/a"
    if self.rowData.len == 0:
        echo ""
        echo "No scheduled task events were found."
    else:
        var allDetailedKeys = initOrderedSet[string]()
        for (_, detailedTable) in self.rowData:
            for key in detailedTable.keys:
                allDetailedKeys.incl(key)
        let basicHeader = @["Timestamp", "TaskName", "User", "SubjectUserSid", "SubjectDomainName", "SubjectLogonId", "Command", "Arguments"]
        let detailedHeader = toSeq(allDetailedKeys).sorted

        # Save results
        var outputFile = open(self.output, fmWrite)

        ## Write CSV header
        let header = concat(basicHeader, detailedHeader)
        for h in header:
            outputFile.write(h & ",")
        outputFile.write("\p")

        ## Write contents
        for (basicTable, detailedTable) in self.rowData:
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
        let fileSize = getFileSize(self.output)
        savedFiles = self.output & " (" & formatFileSize(fileSize) & ")"
        results = "Events:" & intToStr(self.rowData.len).insertSep(',')
        if self.displayTable:
            echo ""
            echo "Saved results to " & savedFiles
    self.cmdResult = CmdResult(results:results, savedFiles:savedFiles)

proc timelineTasks(skipProgressBar:bool = false, output: string, outputLogoffEvents: bool = false, quiet: bool = false, timeline: string) =
    checkArgs(quiet, timeline, "informational")
    let cmd = TimelineTasksCmd(
                skipProgressBar: skipProgressBar,
                timeline: timeline,
                output: output,
                name:"timeline-tasks",
                msg: TimelineTasksMsg,
                outputLogoffEvents: outputLogoffEvents)
    cmd.analyzeJSONLFile()
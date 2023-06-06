type
    processObject = ref object
        processGUID: string
        parentProcessGUID: string
        children: seq[processObject]

proc printIndentedProcessTree(p: processObject, indent: string = "") =
  echo(indent & "Process ", p.processGUID)
  for child in p.children:
    printIndentedProcessTree(child, indent & "  ")

proc printProcessTree(timeline: string, quiet: bool = false, output: string, processGuid: string): int =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    echo ""
    echo "Running the Process Tree module"
    echo ""


    
    var processObjectTable = newTable[string, processObject]()

    var seqOfResultsTables: seq[Table[string, string]]

    var processesFoundCount = 0
    var foundProcessTable = initTable[string, string]()

    for line in lines(timeline):
        let jsonLine = parseJson(line)
        let channel = jsonLine["Channel"].getStr()
        let eventId = jsonLine["EventID"].getInt()
        let eventLevel = jsonLine["Level"].getStr()
        var eventProcessGUID = ""
        # Found a Sysmon 1 process creation event
        if channel == "Sysmon" and eventId == 1 and eventLevel == "info":
            try:
                eventProcessGUID = jsonLine["Details"]["PGUID"].getStr()
            except KeyError:
                echo "Could not find the PGUID field. Make sure you ran Hayabusa with the standard profile."
            if eventProcessGUID == processGuid:
                inc processesFoundCount
                try:
                    foundProcessTable["CmdLine"] = jsonLine["Details"]["Cmdline"].getStr()
                except Keyerror:
                    foundProcessTable["CmdLine"] = ""
                try:
                    foundProcessTable["ParentCmdline"] = jsonLine["Details"]["ParentCmdline"].getStr()
                except Keyerror:
                    foundProcessTable["ParentCmdLine"] = ""                
                try:
                    foundProcessTable["LogonID"] = jsonLine["Details"]["LID"].getStr()
                except Keyerror:
                    foundProcessTable["LogonID"] = ""
                try:
                    foundProcessTable["LogonGUID"] = jsonLine["Details"]["LGUID"].getStr()
                except Keyerror:
                    foundProcessTable["LogonGUID"] = ""   
                try:
                    foundProcessTable["ParentPGUID"] = jsonLine["Details"]["ParentPGUID"].getStr()
                except Keyerror:
                    foundProcessTable["ParentPGUID"] = ""  
                try:
                    foundProcessTable["Company"] = jsonLine["Details"]["Company"].getStr()
                except Keyerror:
                    foundProcessTable["Company"] = "" 
                try:
                    foundProcessTable["User"] = jsonLine["Details"]["User"].getStr()
                except Keyerror:
                    foundProcessTable["User"] = "" 
                try:
                    foundProcessTable["Description"] = jsonLine["Details"]["Description"].getStr()
                except Keyerror:
                    foundProcessTable["Description"] = "" 
                try:
                    foundProcessTable["Product"] = jsonLine["Details"]["Product"].getStr()
                except Keyerror:
                    foundProcessTable["Product"] = "" 
                try:
                    foundProcessTable["IntegrityLevel"] = jsonLine["Details"]["IntegrityLevel"].getStr()
                except Keyerror:
                    foundProcessTable["IntegrityLevel"] = "" 
                try:
                    foundProcessTable["Hashes"] = jsonLine["Details"]["Hashes"].getStr()
                except Keyerror:
                    foundProcessTable["Hashes"] = "" 
                let process = processObject(processGUID: eventProcessGUID, parentProcessGUID: foundProcessTable["ParentPGUID"])
                processObjectTable[process.processGUID] = process

                # Link child processes to their parents
                for id, process in pairs(processObjectTable):
                    if process.parentProcessGUID in processObjectTable:
                        processObjectTable[process.parentProcessGUID].children.add(process)

    if processesFoundCount == 0:
        echo "The process was not found."
        echo ""
        return

    if processesFoundCount > 1:
        echo "There are more than 1 instance of this process which should not happen because it should be unique."
        echo "Exiting..."
        echo ""
        return

   # for id, process in pairs(processObjectTable):
   #     if not processObjectTable.contains(process.parentProcessGUID):  # Root process
   #         printIndentedProcessTree(process)
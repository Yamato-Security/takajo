proc changeByteOrder(vsnStr:string): string =
    var res: seq[string]
    for i, ch in vsnStr:
        if i mod 2 != 0:
            res.add(vsnStr[i - 1] & vsnStr[i])
    return join(res.reversed, "")

proc extractVSN(jsonLine: HayabusaJson) : array[4, string] =
    var res:array[4, string] = ["n/a", "n/a", "n/a", "n/a"]
    if "PartitionStyle" notin jsonLine.ExtraFieldInfo or jsonLine.ExtraFieldInfo["PartitionStyle"].getInt() != 0:
        return res
    for i, vbrNo in ["Vbr0", "Vbr1", "Vbr2", "Vbr3"]:
        if vbrNo notin jsonLine.ExtraFieldInfo:
            continue
        let vbr = jsonLine.ExtraFieldInfo[vbrNo].getStr()
        if vbr.len < 18:
            res[i] = ""
            continue
        let sig = vbr[6..17]
        var vsnLittleEndian = ""
        if sig == "4D53444F5335" and jsonLine.ExtraFieldInfo[vbrNo].getStr().len > 141: # FAT32
            vsnLittleEndian = jsonLine.ExtraFieldInfo[vbrNo].getStr()[134..141]
        elif sig == "455846415420" and jsonLine.ExtraFieldInfo[vbrNo].getStr().len > 207: #ExFAT
            vsnLittleEndian = jsonLine.ExtraFieldInfo[vbrNo].getStr()[200..207]
        elif sig == "4E5446532020" and jsonLine.ExtraFieldInfo[vbrNo].getStr().len > 151: # NTFS
            vsnLittleEndian = jsonLine.ExtraFieldInfo[vbrNo].getStr()[144..151]
        if vsnLittleEndian != "":
            res[i] = changeByteOrder(vsnLittleEndian)
    return res


proc timelinePartitionDiagnostic(output: string = "", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    checkArgs(quiet, timeline, "informational")

    echo "Started the Timeline partition diagnostic command"
    echo "This command will create a CSV timeline of partition diagnostic."
    echo ""

    let totalLines = countLinesInTimeline(timeline)

    var
        bar: SuruBar = initSuruBar()
        seqOfResultsTables: seq[Table[string, string]]

    bar[0].total = totalLines
    bar.setup()

    for line in lines(timeline):
        inc bar
        bar.update(1000000000) # refresh every second
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()
        let eventId = jsonLine.EventID
        let channel = jsonLine.Channel

        if eventId != 1006 or channel != "MS-Win-Partition/Diagnostic":
            continue
        var singleResultTable = initTable[string, string]()
        singleResultTable["Timestamp"] = jsonLine.Timestamp
        singleResultTable["Computer"] = jsonLine.Computer
        singleResultTable["Manufacturer"] = jsonLine.Details["Manufacturer"].getStr()
        singleResultTable["Model"] = jsonLine.Details["Model"].getStr()
        singleResultTable["Revision"] = jsonLine.Details["Revision"].getStr()
        singleResultTable["SerialNumber"] = jsonLine.Details["SerialNumber"].getStr()
        for i, vsn in extractVSN(jsonLine):
            var val = "n/a"
            if vsn != "":
                val = vsn
            singleResultTable["VSN" & intToStr(i)] = val
        seqOfResultsTables.add(singleResultTable)
    bar.finish()

    let header = ["Timestamp", "Computer", "Manufacturer", "Model", "Revision", "SerialNumber", "VSN0", "VSN1", "VSN2", "VSN3"]
    if output != "":
        # Open file to save results
        var outputFile = open(output, fmWrite)

        ## Write CSV header
        outputFile.write(header.join(",") & "\p")

        ## Write contents
        for table in seqOfResultsTables:
            for i, key in enumerate(header):
                if table.hasKey(key):
                    if i < header.len() - 1:
                        outputFile.write(escapeCsvField(table[key]) & ",")
                    else:
                        outputFile.write(escapeCsvField(table[key]))
                else:
                    outputFile.write(",")
            outputFile.write("\p")
        outputFile.close()
        let fileSize = getFileSize(output)
        echo ""
        echo "Saved results to " & output & " (" & formatFileSize(fileSize) & ")"
        echo ""
    else:
        echo ""
        var table: TerminalTable
        table.add header
        for t in seqOfResultsTables:
            table.add t[header[0]], t[header[1]], t[header[2]], t[header[3]], t[header[4]], t[header[5]], t[header[6]], t[header[7]], t[header[8]], t[header[9]]
        table.echoTableSepsWithStyled(seps = boxSeps)
        echo ""
    outputElapsedTime(startTime)
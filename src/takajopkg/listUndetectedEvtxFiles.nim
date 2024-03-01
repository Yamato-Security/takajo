proc listUndetectedEvtxFiles(columnName: system.string = "EvtxFile", evtxDir: string, output: string = "", quiet: bool = false, timeline: string) =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
    var fileLists: seq[string] = getTargetExtFileLists(evtxDir, ".evtx")

    var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
    detectedPaths = deduplicate(detectedPaths)

    let checkResult = getUnlistedSeq(fileLists, detectedPaths)
    var outputStock: seq[string] = @[]

    echo "Finished. "
    echo "---------------"

    if checkResult.len == 0:
        echo "Great! No undetected evtx files were found."
        echo ""
    else:
        echo "Undetected evtx file identified."
        echo ""
        var numberOfEvtxFiles = 0
        for undetectedFile in checkResult:
            outputStock.add(undetectedFile)
            inc numberOfEvtxFiles
        outputStock.add("")
        let undetectedPercentage = (checkResult.len() / fileLists.len()) * 100
        let numberOfEvtxFilesStr = intToStr(numberOfEvtxFiles).insertSep(',')
        echo fmt"{ undetectedPercentage :.4}% of the evtx files did not have any detections."
        echo fmt"Number of evtx files not detected: {numberOfEvtxFilesStr}"
        echo ""
    if output != "":
        let f = open(output, fmWrite)
        defer: f.close()
        for line in outputStock:
            f.writeLine(line)
        echo fmt"Saved File {output}"
        echo ""
    else:
        echo outputstock.join("\n")
    discard
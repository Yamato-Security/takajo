proc listUnusedRules(columnName: string = "RuleFile", output: string = "", quiet: bool = false, rulesDir: string, timeline: string) =
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if not os.fileExists(timeline):
        echo "The file '" & timeline & "' does not exist. Please specify a valid file path."
        quit(1)

    let csvData: TableRef[string, seq[string]] = getHayabusaCsvData(timeline, columnName)
    var fileLists: seq[string] = getTargetExtFileLists(rulesDir, ".yml")
    var detectedPaths: seq[string] = csvData[columnName].map(getFileNameWithExt)
    detectedPaths = deduplicate(detectedPaths)
    var outputStock: seq[string] = @[]

    echo "Finished. "
    echo "---------------"

    let checkResult = getUnlistedSeq(fileLists, detectedPaths)
    if checkResult.len == 0:
        echo "Great! No unused rule files were found."
        echo ""
    else:
        echo "Unused rule file identified."
        echo ""
        var numberOfUnusedRules = 0
        for undetectedFile in checkResult:
            outputStock.add(undetectedFile)
            inc numberOfUnusedRules
        let undetectedPercentage = (checkResult.len() / fileLists.len()) * 100
        outputStock.add("")
        let numberOfUnusedRulesStr = intToStr(numberOfUnusedRules).insertSep(',')
        echo fmt"{ undetectedPercentage :.4}% of the yml rules were not used."
        echo fmt"Number of unused rule files: {numberOfUnusedRulesStr}"
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
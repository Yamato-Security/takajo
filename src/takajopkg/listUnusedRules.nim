proc listUnusedRules(timeline: string, rulesDir: string,
        columnName: string = "RuleFile", quiet: bool = false,
                output: string = ""): int =

    if not quiet:
        styledEcho(fgGreen, outputLogo())

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
        echo fmt"{ undetectedPercentage :.4}% of the yml rules were not used."
        echo fmt"Number of unused rule files: {numberOfUnusedRules}"
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
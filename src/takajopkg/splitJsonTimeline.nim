proc splitJsonTimeline( outputDir: string = "output", quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    echo ""
    echo "Splitting the Hayabusa JSONL timeline into separate timelines according to the computer name."

    if not dirExists(outputDir):
        echo ""
        echo "The directory '" & outputDir & "' does not exist so will be created."
        createDir(outputDir)

    echo "Not implemented yet."

    echo ""

    let endTime = epochTime()
    let elapsedTime2 = int(endTime - startTime)
    let hours = elapsedTime2 div 3600
    let minutes = (elapsedTime2 mod 3600) div 60
    let seconds = elapsedTime2 mod 60
    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
proc vtHashLookup(apiKey: string, hashList: string, output: string, quiet: bool = false) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    echo "Loading hashes from " & hashList
    echo ""



    echo ""
    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
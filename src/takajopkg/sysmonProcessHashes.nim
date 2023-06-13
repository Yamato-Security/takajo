proc sysmonProcessHashes(level: string = "high", output: string, quiet: bool = false, timeline: string) =
    let startTime = epochTime()
    if not quiet:
        styledEcho(fgGreen, outputLogo())

    if level != "critical" and level != "high" and level != "medium" and level != "low" and level != "informational":
        echo "You must specify a minimum level of critical, high, medium, low or informational. (default: high)"
        echo ""
        return

    if level == "critical":
        echo "Scanning for Sysmon 1 process hashes with an alert level of critical"
    else:
        echo "Scanning for Sysmon 1 process hashes with a minimal alert level of " & level
    echo ""

    var
        md5hashes, sha1hashes, sha256hashes, impHashes = initHashSet[string]()
        channel, eventLevel, hashes = ""
        eventId, md5hashCount, sha1hashCount, sha256hashCount, impHashCount = 0
        jsonLine: JsonNode

    for line in lines(timeline):
        jsonLine = parseJson(line)
        channel = jsonLine["Channel"].getStr()
        eventId = jsonLine["EventID"].getInt()
        eventLevel = jsonLine["Level"].getStr()

        # Found a Sysmon 1 process creation event
        if channel == "Sysmon" and eventId == 1 and isMinLevel(eventLevel, level) == true:
            try:
                hashes = jsonLine["Details"]["Hashes"].getStr() # Hashes are not enabled by default so this field may not exist.
                let pairs = hashes.split(",")  # Split the string into key-value pairs. Ex: MD5=DE9C75F34F47B60A71BBA03760F0579E,SHA256=12F06D3B1601004DB3F7F1A07E7D3AF4CC838E890E0FF50C51E4A0C9366719ED,IMPHASH=336674CB3C8337BDE2C22255345BFF43
                for pair in pairs:
                    let keyVal = pair.split("=")
                    case keyVal[0]:
                        of "MD5":
                            md5hashes.incl(keyVal[1])
                            inc md5hashCount
                        of "SHA1":
                            sha1hashes.incl(keyVal[1])
                            inc sha1hashCount
                        of "SHA256":
                            sha256hashes.incl(keyVal[1])
                            inc sha256hashCount
                        of "IMPHASH":
                            impHashes.incl(keyVal[1])
                            inc impHashCount
            except KeyError:
                discard

    # Save MD5 results
    let md5outputFilename = output & "-MD5-hashes.txt"
    var md5outputFile = open(md5outputFilename, fmWrite)
    for hash in md5hashes:
        md5outputFile.write(hash & "\p")
    md5outputFile.close()
    let md5FileSize = getFileSize(md5outputFilename)

    # Save SHA1 results
    let sha1outputFilename = output & "-SHA1-hashes.txt"
    var sha1outputFile = open(sha1outputFilename, fmWrite)
    for hash in sha1hashes:
        sha1outputFile.write(hash & "\p")
    sha1outputFile.close()
    let sha1FileSize = getFileSize(sha1outputFilename)

    # Save SHA256 results
    let sha256outputFilename = output & "-SHA256-hashes.txt"
    var sha256outputFile = open(sha256outputFilename, fmWrite)
    for hash in sha256hashes:
        sha256outputFile.write(hash & "\p")
    sha256outputFile.close()
    let sha256FileSize = getFileSize(sha256outputFilename)

    # Save IMPHASH results
    let impHashOutputFilename = output & "-ImportHashes.txt"
    var impHashOutputFile = open(impHashOutputFilename, fmWrite)
    for hash in impHashes:
        impHashOutputFile.write(hash & "\p")
    impHashOutputFile.close()
    let impHashFileSize = getFileSize(impHashOutputFilename)

    echo "MD5 Hashes: " & $md5hashCount & " (" & formatFileSize(md5FileSize) & ")"
    echo "SHA1 Hashes: ", $sha1hashCount & " (" & formatFileSize(sha1FileSize) & ")"
    echo "SHA256 Hashes: ", $sha256hashCount & " (" & formatFileSize(sha256FileSize) & ")"
    echo "Import Hashes: ", $impHashCount & " (" & formatFileSize(impHashFileSize) & ")"
    echo ""
    let endTime = epochTime()
    let elapsedTime = int(endTime - startTime)
    let hours = elapsedTime div 3600
    let minutes = (elapsedTime mod 3600) div 60
    let seconds = elapsedTime mod 60

    echo "Elapsed time: ", $hours & " hours, " & $minutes & " minutes, " & $seconds & " seconds"
    echo ""
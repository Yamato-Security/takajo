import json
import general
import std/tables

type VirusTotalResult* = ref object
    resTable*: TableRef[string, string]
    resJson*: JsonNode

proc outputVtCmdResult*(output:string, header:seq[string], seqOfResultsTables: seq[TableRef[string, string]], jsonOutput:string, jsonResponses: seq[JsonNode]) =
    if output != "":
        var outputFile = open(output, fmWrite)

        ## Write CSV header
        for h in header:
            outputFile.write(h & ",")
        outputFile.write("\p")

        ## Write contents
        for table in seqOfResultsTables:
            for key in header:
                if table.hasKey(key):
                    outputFile.write(escapeCsvField(table[key]) & ",")
                else:
                    outputFile.write(",")
            outputFile.write("\p")
        let fileSize = getFileSize(outputFile)
        outputFile.close()
        echo ""
        echo "Saved CSV results to " & output & " (" & formatFileSize(fileSize) & ")"

    # After the for loop, check if jsonOutput is not blank and then write the JSON responses to a file
    if jsonOutput != "":
        var jsonOutputFile = open(jsonOutput, fmWrite)
        let jsonArray = newJArray() # create empty JSON array
        for jsonResponse in jsonResponses: # iterate over jsonResponse sequence
            jsonArray.add(jsonResponse) # add each jsonResponse to jsonArray
        jsonOutputFile.write(jsonArray.pretty)
        jsonOutputFile.close()
        let fileSize = getFileSize(jsonOutputFile)
        echo "Saved JSON responses to " & jsonOutput & " (" & formatFileSize(fileSize) & ")"
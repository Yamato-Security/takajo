import cligen
import os
import terminal
import json
import sequtils
import strformat
import strutils
import tables
import takajopkg/general
include takajopkg/listUnusedRules
include takajopkg/listUndetectedEvtxFiles
include takajopkg/logonTimeline

when isMainModule:
    clCfg.version = "2.0.0-dev"
    const examples_1 = "Examples:\n"
    const examples_2 = "  logon-timeline -t ../hayabusa/timeline.jsonl -o logon-timeline.csv\n"
    const examples_3 = "  undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx\n"
    const examples_4 = "  unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules\n"
    clCfg.useMulti = "Usage: takajo.exe <COMMAND>\n\nCommands:\n$subcmds\nCommand help: $command help <COMMAND>\n\n" & examples_1 & examples_2 & examples_3 & examples_4

    if paramCount() == 0:
        styledEcho(fgGreen, outputLogo())
    dispatchMulti(
        [
            logonTimeline, cmdName = "logon-timeline",
            doc = "create a timeline of various logon events (input: JSONL)",
            help = {
                "timeline": "JSONL timeline created by Hayabusa",
                "quiet": "Do not display the launch banner",
                "output": "Save the results to a CSV file.",
            }
        ],
        [
            listUndetectedEvtxFiles, cmdName = "undetected-evtx",
            doc = "list up undetected evtx files (input: CSV, profile: verbose)",
            help = {
                "timeline": "CSV timeline created by Hayabusa with verbose profile",
                "evtxDir": "The directory of .evtx files you scanned with Hayabusa",
                "columnName": "Specify custom column header name",
                "quiet": "Do not display the launch banner",
                "output": "Save the results to a text file. The default is to print to screen.",
            }
        ],
        [
            listUnusedRules, cmdName = "unused-rules",
            doc = "list up unused rules (input: CSV, profile: verbose)",
            help = {
                "timeline": "CSV timeline created by Hayabusa with verbose profile",
                "rulesDir": "Hayabusa rules directory",
                "columnName": "Specify custom column header name",
                "quiet": "Do not display the launch banner",
                "output": "Save the results to a text file. The default is to print to screen.",
            }
        ]
    )

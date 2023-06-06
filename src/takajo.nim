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
include takajopkg/listSuspiciousProcesses
include takajopkg/printProcessTree

when isMainModule:
    clCfg.version = "2.0.0-dev"
    const examples_1 = "Examples:\n"
    const examples_2 = "  logon-timeline -t ../hayabusa/timeline.jsonl -o logon-timeline.csv\n"
    const examples_3 = "  undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx\n"
    const examples_4 = "  unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules\n"
    clCfg.useMulti = "Version: 2.0.0-dev\nUsage: takajo.exe <COMMAND>\n\nCommands:\n$subcmds\nCommand help: $command help <COMMAND>\n\n" & examples_1 & examples_2 & examples_3 & examples_4

    if paramCount() == 0:
        styledEcho(fgGreen, outputLogo())
    dispatchMulti(
        [
            logonTimeline, cmdName = "logon-timeline",
            doc = "create a timeline of various logon events (input: JSONL, profile: standard)",
            help = {
                "output": "save results to a CSV file",
                "quiet": "do not display the launch banner",
                "timeline": "JSONL timeline created by Hayabusa",
            }
        ],
        [
            listSuspiciousProcesses, cmdName = "suspicious-processes",
            doc = "list up suspicious processes. (input: JSONL, profile: standard)",
            help = {
                "level": "specify the alert level",
                "output": "save results to a CSV file",
                "quiet": "do not display the launch banner",
                "timeline": "JSONL timeline created by Hayabusa",
            }
        ],
        [
            listUndetectedEvtxFiles, cmdName = "undetected-evtx",
            doc = "list up undetected evtx files (input: CSV, profile: verbose)",
            help = {
                "columnName": "specify a custom column header name",
                "evtxDir": "directory of .evtx files you scanned with Hayabusa",
                "output": "save the results to a text file (default: stdout)",
                "quiet": "do not display the launch banner",
                "timeline": "CSV timeline created by Hayabusa with verbose profile",
            }
        ],
        [
            listUnusedRules, cmdName = "unused-rules",
            doc = "list up unused rules (input: CSV, profile: verbose)",
            help = {
                "columnName": "specify a custom column header name",
                "output": "save the results to a text file (default: stdout)",
                "quiet": "do not display the launch banner",
                "rulesDir": "Hayabusa rules directory",
                "timeline": "CSV timeline created by Hayabusa with verbose profile",    
            }
        ],
        [
            printProcessTree, cmdName = "process-tree",
            doc = "prints the process tree of a process (input: JSONL, profile: standard)",
            help = {
                "output": "save results to a CSV file",
                "processGuid": "sysmon procress GUID",
                "quiet": "do not display the launch banner",
                "timeline": "JSONL timeline created by Hayabusa", 
            }
        ]
    )

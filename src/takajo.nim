import algorithm
import cligen
import json
import malebolgia
import malebolgia / ticketlocks
import nancy
import puppy
import re
import sets
import sequtils
import strformat
import strutils
import suru
import tables
import terminal
import times
import uri
import os
import std/enumerate
import std/options
import std/xmlparser
import std/xmltree
import takajopkg/general
import takajopkg/hayabusaJson
import takajopkg/stackCommon
import takajopkg/takajoCore
import takajopkg/takajoTerminal
import takajopkg/ttpResult
import takajopkg/vtResult
include takajopkg/extractCredentials
include takajopkg/extractScriptblocks
include takajopkg/listDomains
include takajopkg/listIpAddresses
include takajopkg/listUndetectedEvtxFiles
include takajopkg/listUnusedRules
include takajopkg/metricsComputers
include takajopkg/metricsUsers
include takajopkg/htmlReport
include takajopkg/splitCsvTimeline
include takajopkg/splitJsonTimeline
include takajopkg/stackCmdlines
include takajopkg/stackComputers
include takajopkg/stackDNS
include takajopkg/stackIpAddresses
include takajopkg/stackLogons
include takajopkg/stackProcesses
include takajopkg/stackServices
include takajopkg/stackTasks
include takajopkg/stackUsers
include takajopkg/listHashes
include takajopkg/sysmonProcessTree
include takajopkg/timelineLogon
include takajopkg/timelinePartitionDiagnostic
include takajopkg/timelineSuspiciousProcesses
include takajopkg/timelineTasks
include takajopkg/ttpSummary
include takajopkg/ttpVisualize
include takajopkg/ttpVisualizeSigma
include takajopkg/vtDomainLookup
include takajopkg/vtIpLookup
include takajopkg/vtHashLookup
include takajopkg/automagic
include takajopkg/web/htmlServer


when isMainModule:
    clCfg.version = "2.8.0"
    const examples = "Examples:\p"
    const example_automagic = "  automagic -t ../hayabusa/timeline.jsonl [--level low] [--displayTable] -o case-1\p"
    const example_extract_credentials = "  extract-credentials -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o credentials.csv\p"
    const example_extract_scriptblocks = "  extract-scriptblocks -t ../hayabusa/timeline.jsonl [--level low]  [--skipProgressBar] -o scriptblock-logs\p"
    const example_html_report = "  html-report -t ../hayabusa/timeline.jsonl -o ./output -r ../hayabusa/rules [--sqlite-output html-report.sqlite] [--clobber] [--skipProgressBar] \p"
    const example_html_server = "  html-server -t ../hayabusa/timeline.jsonl [-r ../hayabusa/rules] [-p 8823] [--sqlite-output html-report.sqlite] [--clobber] [--skipProgressBar] \p"
    const example_list_domains = "  list-domains -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o domains.txt\p"
    const example_list_hashes = "  list-hashes -t ../hayabusa/case-1.jsonl [--skipProgressBar] -o case-1\p"
    const example_list_ip_addresses = "  list-ip-addresses -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o ipAddresses.txt\p"
    const example_list_undetected_evtx = "  list-undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx\p"
    const example_list_unused_rules = "  list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules\p"
    const example_metrics_computers = "  metrics-computers -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o metrics-computer.csv\p"
    const example_metrics_users = "  metrics-users -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o metrics-users.csv\p"
    const example_split_csv_timeline = "  split-csv-timeline -t ../hayabusa/timeline.csv [--makeMultiline] -o case-1-csv\p"
    const example_split_json_timeline = "  split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-json\p"
    const example_stack_cmdlines = "  stack-cmdlines -t ../hayabusa/timeline.jsonl [--level low] [--skipProgressBar] -o cmdlines.csv\p"
    const example_stack_computers = "  stack-computers -t ../hayabusa/timeline.jsonl [--level informational] [--sourceComputers] [--skipProgressBar] -o computers.csv\p"
    const example_stack_dns = "  stack-dns -t ../hayabusa/timeline.jsonl [--level infomational] [--skipProgressBar] -o dns.csv\p"
    const example_stack_ip_addresses = "  stack-ip-addresses -t ../hayabusa/timeline.jsonl [--level infomational] [--targetIpAddresses] [--skipProgressBar] -o ipAddresses.csv\p"
    const example_stack_logons = "  stack-logons -t ../hayabusa/timeline.jsonl [--skipProgressBar] [--failedLogons] -o logons.csv\p"
    const example_stack_processes = "  stack-processes -t ../hayabusa/timeline.jsonl [--level low] [--skipProgressBar] -o processes.csv\p"
    const example_stack_services  = "  stack-services -t ../hayabusa/timeline.jsonl [--level infomational] [--skipProgressBar] -o services.csv\p"
    const example_stack_tasks = "  stack-tasks -t ../hayabusa/timeline.jsonl [--level infomational] [--skipProgressBar] -o tasks.csv\p"
    const example_stack_users = "  stack-users -t ../hayabusa/timeline.jsonl [--level infomational] [--sourceUsers] [--filterSystemAccounts] [--filterComputerAccounts] [--skipProgressBar] -o users.csv\p"
    const example_sysmon_process_tree = "  sysmon-process-tree -t ../hayabusa/timeline.jsonl -p <Process GUID> [-o process-tree.txt]\p"
    const example_timeline_logon = "  timeline-logon -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o logon-timeline.csv\p"
    const example_timeline_partition_diagnostic = "  timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o partition-diagnostic-timeline.csv\p"
    const example_timeline_suspicious_processes = "  timeline-suspicious-processes -t ../hayabusa/timeline.jsonl [--level medium] [--skipProgressBar] [-o suspicious-processes.csv]\p"
    const example_timeline_tasks = "  timeline-tasks -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o task-timeline.csv\p"
    const example_vt_domain_lookup = "  vt-domain-lookup  -a <API-KEY> --domainList domains.txt -r 1000 -o results.csv --jsonOutput responses.json\p"
    const example_ttp_summary = "  ttp-summary -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o ttp-summary.csv\p"
    const example_ttp_visualize = "  ttp-visualize -t ../hayabusa/timeline.jsonl [--skipProgressBar] -o mitre-ttp-heatmap.json\p"
    const example_ttp_visualize_sigma = "  ttp-visualize-sigma -r ../hayabusa/rules -o sigma-rules-heatmap.json\p"
    const example_vt_hash_lookup = "  vt-hash-lookup -a <API-KEY> --hashList case-1-MD5-hashes.txt -r 1000 -o results.csv --jsonOutput responses.json\p"
    const example_vt_ip_lookup = "  vt-ip-lookup -a <API-KEY> --ipList ipAddresses.txt -r 1000 -o results.csv --jsonOutput responses.json\p"

    clCfg.useMulti = "Version: 2.8.0 Ninja Day Releaase\pUsage: takajo.exe <COMMAND>\p\pCommands:\p$subcmds\pCommand help: $command help <COMMAND>\p\p" &
        examples &
        example_automagic &
        example_extract_credentials & example_extract_scriptblocks & example_html_report & example_html_server &
        example_list_domains & example_list_hashes & example_list_ip_addresses & example_list_undetected_evtx & example_list_unused_rules &
        example_metrics_computers & example_metrics_users &
        example_split_csv_timeline & example_split_json_timeline &
        example_stack_cmdlines & example_stack_computers & example_stack_dns & example_stack_ip_addresses & example_stack_logons & example_stack_processes & example_stack_services & example_stack_tasks & example_stack_users &
        example_sysmon_process_tree &
        example_timeline_logon & example_timeline_partition_diagnostic & example_timeline_suspicious_processes & example_timeline_tasks &
        example_ttp_summary & example_ttp_visualize & example_ttp_visualize_sigma &
        example_vt_domain_lookup & example_vt_hash_lookup & example_vt_ip_lookup

    checkTakajoDir()

    if paramCount() == 0:
        styledEcho(fgGreen, outputLogo())
    dispatchMulti(
        [
            autoMagic, cmdName = "automagic",
            doc = "automatically executes as many commands as possible and output results to a new folder",
            help = {
                "displayTable": "display the results table (default: false)",
                "level": "specify the minimum alert level (default: informational)",
                "output": "output directory (default: case-1)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            extractCredentials, cmdName = "extract-credentials",
            doc = "extract plaintext credentials from the command-line auditing",
            help = {
                "output": "save results to a csv file",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            extractScriptblocks, cmdName = "extract-scriptblocks",
            doc = "extract and reassemble PowerShell EID 4104 script block logs",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "output": "output directory (default: scriptblock-logs)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            htmlReport, cmdName = "html-report",
            doc = "create static HTML summary reports for rules and computers with detections",
            help = {
                "output": "html report directory name",
                "quiet": "do not display the launch banner (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any verbose profile)",
                "rulepath": "hayabusa rules directory path",
                "sqliteoutput": "save results to a SQLite database (default: html-report.sqlite)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "clobber": "overwrite the SQLite file when saving (default: false)",
            },
            short = {
                "clobber": 'C',
                "sqlite-output": 's',
                "output": 'o'
            }
        ],
        [
            htmlServer, cmdName = "html-server",
            doc = "create a dynamic web server to view the HTML summary reports",
            help = {
                "quiet": "do not display the launch banner (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any verbose profile)",
                "rulepath": "hayabusa rules directory path",
                "sqliteoutput": "save results to a SQLite database (default: html-report.sqlite)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "clobber": "overwrite the SQLite file when saving (default: false)",
                "port": "web server port number"
            },
            short = {
                "port": 'p',
                "clobber": 'C',
                "sqlite-output": 's',
            }
        ],
        [
            listDomains, cmdName = "list-domains",
            doc = "create a list of unique domains to be used with vt-domain-lookup",
            help = {
                "includeSubdomains": "include subdomains",
                "includeWorkstations": "include local workstation names",
                "output": "save results to a text file",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },
            short = {
                "includeSubdomains": 'd',
                "includeWorkstations": 'w'
            }
        ],
        [
            listHashes, cmdName = "list-hashes",
            doc = "create a list of process hashes to be used with vt-hash-lookup",
            help = {
                "level": "specify the minimum alert level",
                "output": "specify the base name to save results to text files (ex: -o case-1)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            }
        ],
        [
            listIpAddresses, cmdName = "list-ip-addresses",
            doc = "create a list of unique target and/or source IP addresses to be used with vt-ip-lookup",
            help = {
                "inbound": "include inbound traffic",
                "outbound": "include outbound traffic",
                "output": "save results to a text file",
                "privateIp": "include private IP addresses",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },
            short = {
                "output": 'o',
                "outbound": 'O'
            }
        ],
        [
            listUndetectedEvtxFiles, cmdName = "list-undetected-evtx",
            doc = "create a list of undetected evtx files",
            help = {
                "columnName": "specify a custom column header name",
                "evtxDir": "directory of .evtx files you scanned with Hayabusa",
                "output": "save the results to a text file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "timeline": "Hayabusa CSV timeline (profile: any verbose profile)",
            }
        ],
        [
            listUnusedRules, cmdName = "list-unused-rules",
            doc = "create a list of unused sigma rules",
            help = {
                "columnName": "specify a custom column header name",
                "output": "save the results to a text file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "rulesDir": "Hayabusa rules directory",
                "timeline": "Hayabusa CSV timeline (profile: any verbose profile)",
            }
        ],
        [
            splitCsvTimeline, cmdName = "split-csv-timeline",
            doc = "split up a large CSV file into smaller ones based on the computer name",
            help = {
                "makeMultiline": "output fields in multiple lines",
                "output": "output directory (default: output)",
                "quiet": "do not display the launch banner (default: false)",
                "timeline": "Hayabusa non-multiline CSV timeline (profile: any)",
            }
        ],
        [
            metricsComputers, cmdName = "metrics-computers",
            doc = "extract out metrics of events, uptime, timezone, etc... from computers",
            help = {
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            metricsUsers, cmdName = "metrics-users",
            doc = "extract out metrics of logon events, target, sid, source, etc... from users",
            help = {
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            splitJsonTimeline, cmdName = "split-json-timeline",
            doc = "split up a large JSONL timeline into smaller ones based on the computer name",
            help = {
                "output": "output directory (default: output)",
                "quiet": "do not display the launch banner (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            stackCmdlines, cmdName = "stack-cmdlines",
            doc = "stack executed command lines",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "ignoreSecurity": "exclude Security 4688 events (default: false)",
                "ignoreSysmon": "exclude Sysmon 1 events (default: false)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },
            short = {
                "ignoreSysmon": 'y',
                "ignoreSecurity": 'e'
            }
        ],
        [
            stackComputers, cmdName = "stack-computers",
            doc = "stack computers",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "sourceComputers" : "stack source computers instead of target computers (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },
            short = {
                "sourceComputers": 'c'
            }
        ],
        [            
            stackDNS, cmdName = "stack-dns",
            doc = "stack DNS queries and responses",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            }
        ],
        [
            stackIpAddresses, cmdName = "stack-ip-addresses",
            doc = "stack the target IP addresses (TgtIP field) or source IP addresses (SrcIP field)",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "targetIpAddresses" : "stack target IP addresses instead of source IP addresses",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            },
            short = {
                "targetIpAddresses": 'a'
            }
        ],
        [
            stackLogons, cmdName = "stack-logons",
            doc = "stack logons by target user, target computer, source IP address and source computer",
            help = {
                "localSrcIpAddresses": "include results when the source IP address is local",
                "failedLogons": "stack failed logons instead of successful logons",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            }
        ],
        [
            stackProcesses, cmdName = "stack-processes",
            doc = "stack executed processes",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "ignoreSecurity": "exclude Security 4688 events",
                "ignoreSysmon": "exclude Sysmon 1 events",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },            
            short = {
                "ignoreSysmon": 'y',
                "ignoreSecurity": 'e'
            }
        ],
        [
            stackServices, cmdName = "stack-services",
            doc = "stack service names and paths from System 7040 and Security 4697 events",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "ignoreSecurity": "exclude Security 4697 events (default: false)",
                "ignoreSystem": "exclude System 7040 events (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },
            short = {
                "ignoreSystem": 'y',
                "ignoreSecurity": 'e'
            }
        ],
        [
            stackTasks, cmdName = "stack-tasks",
            doc = "stack new scheduled tasks from Security 4698 events and parse out XML task content",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            }
        ],
        [
            stackUsers, cmdName = "stack-users",
            doc = "stack target users (TgtUser field) or source users (SrcUser field)",
            help = {
                "level": "specify the minimum alert level (default: informational)",
                "filterComputerAccounts": "filter out computer accounts (default: true)",
                "filterSystemAccounts": "filter out system accounts (default: true)",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "sourceUsers" : "stack source users instead of target users (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            },
            short = {
                "filterComputerAccounts": 'c',
                "filterSystemAccounts": 'f'
            }
        ],
        [
            sysmonProcessTree, cmdName = "sysmon-process-tree",
            doc = "output the process tree of a certain process",
            help = {
                "output": "save results to a text file",
                "processGuid": "sysmon process GUID",
                "quiet": "do not display the launch banner (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            }
        ],
        [
            timelineLogon, cmdName = "timeline-logon",
            doc = "create a CSV timeline of logon events",
            help = {
                "calculateElapsedTime": "calculate the elapsed time for successful logons",
                "output": "save results to a CSV file",
                "outputAdminLogonEvents": "output admin logon events as separate entries",
                "outputLogoffEvents": "output logoff events as separate entries",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            },
            short = {
                "outputLogoffEvents": 'l',
                "outputAdminLogonEvents": 'a'
            }
        ],
        [
            timelinePartitionDiagnostic, cmdName = "timeline-partition-diagnostic",
            doc = "create a CSV timeline of partition diagnostic events",
            help = {
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            timelineSuspiciousProcesses, cmdName = "timeline-suspicious-processes",
            doc = "create a CSV timeline of suspicious processes",
            help = {
                "level": "specify the minimum alert level",
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any besides all-field-info*)",
            }
        ],
        [
            timelineTasks, cmdName = "timeline-tasks",
            doc = "create a CSV timeline of scheduled tasks",
            help = {
                "output": "save results to a CSV file",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any)",
            }
        ],
        [
            ttpSummary, cmdName = "ttp-summary",
            doc = "summarize tactics and techniques found in each computer",
            help = {
                "output": "save results to a CSV file (default: stdout)",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any verbose profile)",
            }
        ],
        [
            ttpVisualize, cmdName = "ttp-visualize",
            doc = "extract TTPs and create a JSON file to visualize in MITRE ATT&CK Navigator",
            help = {
                "output": "save results to a json file",
                "quiet": "do not display the launch banner (default: false)",
                "skipProgressBar": "do not display the progress bar (default: false)",
                "timeline": "Hayabusa JSONL timeline file or directory (profile: any verbose profile)",
            }
        ],
        [
            ttpVisualizeSigma, cmdName = "ttp-visualize-sigma",
            doc = "extract TTPs from Sigma and create a JSON file to visualize in MITRE ATT&CK Navigator",
            help = {
                "output": "save results to a json file",
                "quiet": "do not display the launch banner (default: false)",
                "rulesDir": "Sigma rules directory",
            }
        ],
        [
            vtDomainLookup, cmdName = "vt-domain-lookup",
            doc = "look up a list of domains on VirusTotal",
            help = {
                "apiKey": "your VirusTotal API key",
                "domainList": "a text file list of domains",
                "jsonOutput": "save all responses to a JSON file",
                "output": "save results to a CSV file (default: stdout)",
                "rateLimit": "set the rate per minute for requests",
                "quiet": "do not display the launch banner (default: false)",
            }
        ],
        [
            vtHashLookup, cmdName = "vt-hash-lookup",
            doc = "look up a list of hashes on VirusTotal",
            help = {
                "apiKey": "your VirusTotal API key",
                "hashList": "a text file list of hashes",
                "jsonOutput": "save all responses to a JSON file",
                "output": "save results to a text file",
                "rateLimit": "set the rate per minute for requests",
                "quiet": "do not display the launch banner (default: false)",
            },
            short = {
                "hashList": 'H'
            }
        ],
        [
            vtIpLookup, cmdName = "vt-ip-lookup",
            doc = "look up a list of IP addresses on VirusTotal",
            help = {
                "apiKey": "your VirusTotal API key",
                "ipList": "a text file list of IP addresses",
                "jsonOutput": "save all responses to a JSON file",
                "output": "save results to a CSV file (default: stdout)",
                "rateLimit": "set the rate per minute for requests",
                "quiet": "do not display the launch banner (default: false)",
            }
        ]
    )
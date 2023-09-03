import algorithm
import cligen
import json
import puppy
import sets
import sequtils
import strformat
import strutils
import tables
import terminal
import times
import threadpool
import uri
import os
import std/enumerate
import suru
import takajopkg/general
include takajopkg/listDomains
include takajopkg/listIpAddresses
include takajopkg/listUndetectedEvtxFiles
include takajopkg/listUnusedRules
include takajopkg/splitCsvTimeline
include takajopkg/splitJsonTimeline
include takajopkg/stackLogons
include takajopkg/listHashes
include takajopkg/sysmonProcessTree
include takajopkg/timelineLogon
include takajopkg/timelineSuspiciousProcesses
include takajopkg/vtDomainLookup
include takajopkg/vtIpLookup
include takajopkg/vtHashLookup

when isMainModule:
    clCfg.version = "2.0.0"
    const examples = "Examples:\p"
    const example_list_domains = "  list-domains -t ../hayabusa/timeline.jsonl -o domains.txt\p"
    const example_list_ip_addresses = "  list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt\p"
    const example_list_undetected_evtx = "  list-undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx\p"
    const example_list_unused_rules = "  list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules\p"
    const example_split_csv_timeline = "  split-csv-timeline -t ../hayabusa/timeline.csv [--makeMultiline] -o case-1-csv\p"
    const example_split_json_timeline = "  split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-json\p"
    const example_stack_logons = "  stack-logons -t ../hayabusa/timeline.jsonl -o logons.csv\p"
    const example_list_hashes = "  list-hashes -t ../hayabusa/case-1.jsonl -o case-1\p"
    const example_sysmon_process_tree = "  sysmon-process-tree -t ../hayabusa/timeline.jsonl -p <Process GUID> [-o process-tree.txt]\p"
    const example_timeline_logon = "  timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv\p"
    const example_timeline_suspicious_processes = "  timeline-suspicious-processes -t ../hayabusa/timeline.jsonl [--level medium] [-o suspicious-processes.csv]\p"
    const example_vt_domain_lookup = "  vt-domain-lookup  -a <API-KEY> --domainList domains.txt -r 1000 -o results.csv --jsonOutput responses.json\p"
    const example_vt_hash_lookup = "  vt-hash-lookup -a <API-KEY> --hashList case-1-MD5-hashes.txt -r 1000 -o results.csv --jsonOutput responses.json\p"
    const example_vt_ip_lookup = "  vt-ip-lookup -a <API-KEY> --ipList ipAddresses.txt -r 1000 -o results.csv --jsonOutput responses.json\p"

    clCfg.useMulti = "Version: 2.0.0\pUsage: takajo.exe <COMMAND>\p\pCommands:\p$subcmds\pCommand help: $command help <COMMAND>\p\p" &
        examples & example_list_domains & example_list_hashes & example_list_ip_addresses & example_list_undetected_evtx & example_list_unused_rules &
        example_split_csv_timeline & example_split_json_timeline & example_stack_logons & example_sysmon_process_tree &
        example_timeline_logon & example_timeline_suspicious_processes &
        example_vt_domain_lookup & example_vt_hash_lookup & example_vt_ip_lookup

    if paramCount() == 0:
        styledEcho(fgGreen, outputLogo())
    dispatchMulti(
        [
            listDomains, cmdName = "list-domains",
            doc = "create a list of unique domains to be used with vt-domain-lookup",
            help = {
                "includeSubdomains": "include subdomains",
                "includeWorkstations": "include local workstation names",
                "output": "save results to a text file",
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
            },
            short = {
                "includeSubdomains": 's',
                "includeWorkstations": 'w'
            }
        ],
        [
            listHashes, cmdName = "list-hashes",
            doc = "create a list of process hashes to be used with vt-hash-lookup",
            help = {
                "level": "specify the minimum alert level",
                "output": "specify the base name to save results to text files (ex: -o case-1)",
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
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
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
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
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa CSV timeline (profile: any verbose profile)",
            }
        ],
        [
            listUnusedRules, cmdName = "list-unused-rules",
            doc = "create a list of unused sigma rules",
            help = {
                "columnName": "specify a custom column header name",
                "output": "save the results to a text file (default: stdout)",
                "quiet": "do not display the launch banner",
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
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa non-multiline CSV timeline (profile: any)",
            }
        ],
        [
            splitJsonTimeline, cmdName = "split-json-timeline",
            doc = "split up a large JSONL timeline into smaller ones based on the computer name",
            help = {
                "output": "output directory (default: output)",
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any)",
            }
        ],
        [
            stackLogons, cmdName = "stack-logons",
            doc = "stack logons by target user, target computer, source IP address and source computer",
            help = {
                "localSrcIpAddresses": "include results when the source IP address is local",
                "output": "save results to a CSV file",
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
            }
        ],
        [
            sysmonProcessTree, cmdName = "sysmon-process-tree",
            doc = "output the process tree of a certain process",
            help = {
                "output": "save results to a text file",
                "processGuid": "sysmon process GUID",
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
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
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
            },
            short = {
                "outputLogoffEvents": 'l',
                "outputAdminLogonEvents": 'a'
            }
        ],
        [
            timelineSuspiciousProcesses, cmdName = "timeline-suspicious-processes",
            doc = "create a CSV timeline of suspicious processes",
            help = {
                "level": "specify the minimum alert level",
                "output": "save results to a CSV file",
                "quiet": "do not display the launch banner",
                "timeline": "Hayabusa JSONL timeline (profile: any besides all-field-info*)",
            }
        ],
        [
            vtDomainLookup, cmdName = "vt-domain-lookup",
            doc = "look up a list of domains on VirusTotal",
            help = {
                "apiKey": "your VirusTotal API key",
                "domainList": "a text file list of domains",
                "jsonOutput": "save all responses to a JSON file",
                "output": "save results to a CSV file",
                "rateLimit": "set the rate per minute for requests",
                "quiet": "do not display the launch banner",
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
                "quiet": "do not display the launch banner",
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
                "output": "save results to a CSV file",
                "rateLimit": "set the rate per minute for requests",
                "quiet": "do not display the launch banner",
            }
        ]
    )
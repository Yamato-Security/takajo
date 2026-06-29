# Command List

## Automation Commands
* `automagic`: automatically executes as many commands as possible and output results to a new folder

## Extract Commands
* `extract-scriptblocks`: extract and reassemble PowerShell EID 4104 script block logs

## HTML Commands
* `html-report`: create static HTML summary reports
* `html-server`: create a dynamic web server to view HTML summary reports

## List Commands
* `list-domains`: create a list of unique domains to be used with `vt-domain-lookup`
* `list-hashes`: create a list of process hashes to be used with `vt-hash-lookup`
* `list-ip-addresses`: create a list of unique target and/or source IP addresses to be used with `vt-ip-lookup`
* `list-undetected-evtx`: create a list of undetected evtx files
* `list-unused-rules`: create a list of unused detection rules

## Split Commands
* `split-csv-timeline`: split up a large CSV timeline into smaller ones based on the computer name
* `split-json-timeline`: split up a large JSONL timeline into smaller ones based on the computer name

## Stack Commands
* `stack-cmdlines`: stack executed command lines
* `stack-computers`: stack computers
* `stack-dns`: stack DNS queries and responses
* `stack-ip-addresses`: stack target IP addresses (`TgtIP` field) or source IP addresses (`SrcIP` field)
* `stack-logons`: stack logons by target user, target computer, source IP address and source computer
* `stack-processes`: stack executed processes
* `stack-services`: stack service names and paths from `System 7040` and `Security 4697` events
* `stack-tasks`: stack new scheduled tasks from `Security 4698` events and parse out XML task content
* `stack-users`: stack target users (`TgtUser` field) or source users (`SrcUser` field)

## Sysmon Commands
* `sysmon-process-tree`: output the process tree of a certain process

## Timeline Commands
* `timeline-logon`: create a CSV timeline of logon events
* `timeline-partition-diagnostic`: create a CSV timeline of partition diagnostic events
* `timeline-suspicious-processes`: create a CSV timeline of suspicious processes
* `timeline-tasks`: create a CSV timeline of scheduled tasks

## TTP Commands
* `ttp-summary`: summarize tactics and techniques found in each computer
* `ttp-visualize`: extract TTPs and create a JSON file to visualize in MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: extract TTPs from Sigma rules and create a JSON file to visualize in MITRE ATT&CK Navigator

## VirusTotal Commands
* `vt-domain-lookup`: look up a list of domains on VirusTotal and report on malicious ones
* `vt-hash-lookup`: look up a list of hashes on VirusTotal and report on malicious ones
* `vt-ip-lookup`: look up a list of IP addresses on VirusTotal and report on malicious ones

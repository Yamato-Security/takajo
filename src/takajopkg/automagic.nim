const AutoMagicMsg = "Automatically executes as many commands as possible and output results to a new folder."

type
  AutoMagicCmd* = ref object of AbstractCmd
    level: string

proc autoMagic(level: string = "informational", skipProgressBar: bool = false,
    displayTable: bool = false, output: string = "case-1", quiet: bool = false,
    timeline: string) =
  checkArgs(quiet, timeline, level)
  if dirExists(output):
    echo "The directory '" & output & "' exists. Please specify a new folder name."
    quit(1)
  else:
    createDir(output)

  # computer-metrics -t ../hayabusa/timeline.jsonl -o case-1/ComputerMetrics.csv
  let cmd0 = ComputerMetricsCmd(name: "computer-metrics",
    skipProgressBar: skipProgressBar,
    displayTable: displayTable,
    timeline: timeline, output: output & "/ComputerMetrics.csv")

  # extract-scriptblocks -t ../hayabusa/timeline.jsonl -l <level> -o case-1/scriptblock-logs/
  let cmd1 = ExtractScriptBlocksCmd(name: "extract-scriptblocks",
    level: level, skipProgressBar: skipProgressBar,
    displayTable: displayTable,
    timeline: timeline, output: output & "/scriptblock-logs")
  if not dirExists(output & "/scriptblock-logs/"):
    createDir(output & "/scriptblock-logs/")

  # list-domains -t ../hayabusa/timeline.jsonl -o case-1/ListDomains.txt
  let cmd2 = ListDomainsCmd(name: "list-domains", displayTable: displayTable,
    timeline: timeline, output: output & "/ListDomains.txt")

  # list-domains -t ../hayabusa/timeline.jsonl -d -w -o case-1/ListDomains-Detailed.txt
  let cmd3 = ListDomainsCmd(name: "list-domains(detailed)",
    displayTable: displayTable, timeline: timeline, output: output &
    "/ListDomainsDetailed.txt", includeSubdomains: true,
    includeWorkstations: true)

  # list-hashes -t ../hayabusa/timeline.jsonl -l <level> -o case-1/hashes
  let cmd4 = ListHashesCmd(name: "list-hashes", displayTable: displayTable,
    timeline: timeline, level: level, output: output & "/ListHashes")

  # list-ip-addresses -t ../hayabusa/timeline.jsonl -o case-1/IP-Addresses.txt
  let cmd5 = ListIpAddressesCmd(name: "list-ip-addresses",
    displayTable: displayTable, timeline: timeline, output: output & "/ListIP-Addresses.txt")

  # stack-cmdlines -t ../hayabusa/timeline.jsonl --level <leve> -o case-1/cmdlines.csv
  let cmd6 = StackCmdlineCmd(name: "stack-cmdlines", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/StackCmdlines.csv")

  # stack-computers -t ../hayabusa/timeline.jsonl --level <level> -o case-1/TargetComputers.csv
  let cmd7 = StackComputersCmd(name: "stack-computers", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/StackTargetComputers.csv")

  # stack-computers -t ../hayabusa/timeline.jsonl --level <level> --sourceComputers -o case-1/SourceComputers.csv
  let cmd8 = StackComputersCmd(name: "stack-computers", level: level,
    displayTable: displayTable, timeline: timeline, output: output &
    "/StackSourceComputers.csv", sourceComputers: true)

  # stack-dns -t ../hayabusa/timeline.jsonl --level <level>  -o case-1/DNS.csv
  let cmd9 = StackDNSCmd(name: "stack-dns", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/StackDNS.csv")

  # stack-ip-addresses -t ../hayabusa/timeline.jsonl --level <level> -o case-1/SourceIP-Addresses.csv
  let cmd10 = StackIpAddressesCmd(name: "stack-ip-addresses(source)",
    level: level, displayTable: displayTable, timeline: timeline,
    output: output & "/StackSourceIP-Addresses.csv")

  # stack-ip-addresses -t ../hayabusa/timeline.jsonl --level <level> --targetIpAddresses -o case-1/TargetIP-Addresses.csv
  let cmd11 = StackIpAddressesCmd(name: "stack-ip-addresses(target)",
    level: level, displayTable: displayTable, timeline: timeline,
    output: output & "/StackTargetIP-Addresses.csv",
    targetIpAddresses: true)

  # stack-logons -t ../hayabusa/timeline.jsonl -o case-1/StackLogons.csv
  let cmd12 = StackLogonsCmd(name: "stack-logons(successful)", displayTable: displayTable,
    timeline: timeline, output: output & "/StackSuccessfulLogons.csv")

  # stack-logons -t ../hayabusa/timeline.jsonl --failedLogons -o case-1/StackFailedLogons.csv
  let cmd122 = StackLogonsCmd(name: "stack-logons(failed)", displayTable: displayTable,
    timeline: timeline, output: output & "/StackFailedLogons.csv", failedLogons:true)

  # stack-processes -t ../hayabusa/timeline.jsonl --level <level> -o case-1/Processes.csv
  let cmd13 = StackProcessesCmd(name: "stack-processes", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/StackProcesses.csv")

  # stack-services -t ../hayabusa/timeline.jsonl --level <level> -o case-1/Services.csv
  let cmd14 = StackServicesCmd(name: "stack-services", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/StackServices.csv")

  # stack-tasks -t ../hayabusa/timeline.jsonl --level <level> -o case-1/Tasks.csv
  let cmd15 = StackTasksCmd(name: "stack-tasks", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/StackTasks.csv")

  # stack-users -t ../hayabusa/timeline.jsonl --level <level> -o case-1/TargetUsers.csv
  let cmd16 = StackUsersCmd(name: "stack-users(target)", level: level,
    displayTable: displayTable, timeline: timeline, output: output &
    "/StackTargetUsers.csv", filterSystemAccounts: true,
    filterComputerAccounts: true)

  # stack-users -t ../hayabusa/timeline.jsonl --level <level> --filterSystemAccounts=false --filterComputerAccounts=false -o case-1/TargetUsers-NoFiltering.csv
  let cmd17 = StackUsersCmd(name: "stack-users(no filtering)", level: level,
    displayTable: displayTable, timeline: timeline, output: output &
    "/StackTargetUsers-NoFiltering.csv", filterSystemAccounts: false,
    filterComputerAccounts: false)

  # stack-users -t ../hayabusa/timeline.jsonl --level <level> --sourceUsers -o users.csv
  let cmd18 = StackUsersCmd(name: "stack-users(source)", level: level,
    displayTable: displayTable, timeline: timeline, output: output &
    "/StackSourceUsers.csv", sourceUsers: true, filterSystemAccounts: true,
    filterComputerAccounts: true)

  # stack-users -t ../hayabusa/timeline.jsonl --level <level> --sourceUsers --filterSystemAccounts=false --filterComputerAccounts=false -o case-1/SourceUsers-NoFiltering.csv
  let cmd19 = StackUsersCmd(name: "stack-users(no filtering)", level: level,
    displayTable: displayTable, timeline: timeline, output: output &
    "/StackSourceUsers-NoFiltering.csv", sourceUsers: true,
    filterSystemAccounts: false, filterComputerAccounts: false)

  # timeline-logon -t ../hayabusa/timeline.jsonl -o case-1/LogonTimeline.csv
  let cmd20 = TimelineLogonCmd(name: "timeline-logon",
    displayTable: displayTable, timeline: timeline, output: output & "/TimelineLogon.csv")

  # timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o case-1/PartitionDiagnosticTimeline.csv
  let cmd21 = TimelinePartitionDiagnosticCmd(
    name: "timeline-partition-diagnostic", displayTable: displayTable,
    timeline: timeline, output: output & "/TimelinePartitionDiagnostic.csv")

  # timeline-suspicious-processes -t ../hayabusa/timeline.jsonl --level <level> -o case-1/SuspiciousProcesses.csv
  let cmd22 = TimelineSuspiciousProcessesCmd(
    name: "timeline-suspicious-processes", level: level,
    displayTable: displayTable, timeline: timeline, output: output & "/TimelineSuspiciousProcesses.csv")

  # timeline-tasks -t ../hayabusa/timeline.jsonl -o case-1/TaskTimeline.csv
  let cmd23 = TimelineTasksCmd(name: "timeline-tasks",
    displayTable: displayTable, timeline: timeline, output: output & "/TimelineTask.csv")

  # ttp-summary -t ../hayabusa/timeline.jsonl -o case-1/TTP-Summary.csv
  let cmd24 = TTPSummaryCmd(name: "ttp-summary", displayTable: displayTable,
    timeline: timeline, output: output & "/TTPSummary.csv")
  cmd24.attack = readJsonFromFile("mitre-attack.json")

  # ttp-visualize -t ../hayabusa/timeline.jsonl -o case-1/MitreTTP-Heatmap.json
  let cmd25 = TTPVisualizeCmd(name: "ttp-visualize",
    displayTable: displayTable, timeline: timeline, output: output & "/MitreTTP-Heatmap.json")

  # execute all command
  let cmds = @[cmd0, cmd1, cmd2, cmd3, cmd4, cmd5, cmd6, cmd7, cmd8, cmd9, cmd10,
        cmd11, cmd12, cmd122, cmd13, cmd14, cmd15, cmd16, cmd17, cmd18, cmd19,
        cmd20,
        cmd21, cmd22, cmd23, cmd24, cmd25]
  let cmd = AutoMagicCmd(level: level, skipProgressBar: skipProgressBar,
    displayTable: displayTable, output: output, timeline: timeline,
    name: "automagic", msg: AutoMagicMsg)
  cmd.analyzeJSONLFile(cmds)
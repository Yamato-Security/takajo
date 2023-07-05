# Changes

## v2.0.0 [2022/08/03]

- Major update released at the [SANS DFIR Summit in Austin](https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/).

**New Features:**

- `list-domains`: create a list of unique domains (input: JSONL, profile: standard) (@YamatoSecurity)
- `list-ip-addresses`: create a list of unique target and/or source IP addresses (input: JSONL, profile: standard) (@YamatoSecurity)
- `split-csv-timeline`: split up a large CSV file into smaller ones based on the computer name (input: non-multiline CSV, profile: any) (@YamatoSecurity)
- `split-json-timeline`: split up a large JSONL timeline into smaller ones based on the computer name (input: JSONL, profile: any) (@fukusuket)
- `stack-logons`: stack logons by target user, target computer, source IP address and source computer (input: JSONL, profile: standard) (@YamatoSecurity)
- `sysmon-process-hashes`: create a list of process hashes to be used with vt-hash-lookup (input: JSONL, profile: standard) (@YamatoSecurity)
- `sysmon-process-tree`: output the process tree of a certain process (input: JSONL, profile: standard) (@hitenkoku)
- `timeline-logon`: create a CSV timeline of logon events (input: JSONL, profile: standard) (@YamatoSecurity)
- `timeline-suspicious-processes`: create a CSV timeline of suspicious processes (input: JSONL, profile: standard) (@YamatoSecurity)
- `vt-domain-lookup`: look up a list of domains on VirusTotal (input: text file) (@YamatoSecurity)
- `vt-hash-lookup`: look up a list of hashes on VirusTotal (input: text file) (@YamatoSecurity)
- `vt-ip-lookup`: look up a list of IP addresses on VirusTotal (input: text file) (@YamatoSecurity)

## v1.0.0 [2022/10/28]

- Official release at [Code Blue 2022 Bluebox](https://codeblue.jp/2022/en/talks/?content=talks_24).

**New Features:**

- `list-undetected-evtx-files`: List up all of the `.evtx` files that Hayabusa didn't have a detection rule for. (#4) (@hitenkoku)
- `list-unused-rules`: List up all of the `.yml` detection rules that were not used. (#4) (@hitenkoku)
- Added Logo. If you want to hide the logo, use the `-q, --quiet` option. (#12) (@YamatoSecurity @hitenkoku)
- Added result output option. (`-o, --output` ) (#11) (@hitenkoku)

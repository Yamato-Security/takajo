# Changes

## x.x.x [xxxx/xx/xx]

**Enhancements:**

- Takajo now compiles with nim 2.0.0. (#31) (@fukusuket)

- `list-domains`: create a

## 2.0.0 [2022/08/03] - [SANS DFIR Summit 2023 Release](https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/)

**New Features:**

- `list-domains`: create a list of unique domains. (@YamatoSecurity)
- `list-hashes`: create a list of process hashes to be used with vt-hash-lookup. (@YamatoSecurity)
- `list-ip-addresses`: create a list of unique target and/or source IP addresses. (@YamatoSecurity)
- `split-csv-timeline`: split up a large CSV file into smaller ones based on the computer name. (@YamatoSecurity)
- `split-json-timeline`: split up a large JSONL timeline into smaller ones based on the computer name. (@fukusuket)
- `stack-logons`: stack logons by target user, target computer, source IP address and source computer. (@YamatoSecurity)
- `sysmon-process-tree`: output the process tree of a certain process. (@hitenkoku)
- `timeline-logon`: create a CSV timeline of logon events. (@YamatoSecurity)
- `timeline-suspicious-processes`: create a CSV timeline of suspicious processes. (@YamatoSecurity)
- `vt-domain-lookup`: look up a list of domains on VirusTotal. (@YamatoSecurity)
- `vt-hash-lookup`: look up a list of hashes on VirusTotal. (@YamatoSecurity)
- `vt-ip-lookup`: look up a list of IP addresses on VirusTotal. (@YamatoSecurity)

## v1.0.0 [2022/10/28] - [Code Blue 2022 Bluebox Release](https://codeblue.jp/2022/en/talks/?content=talks_24)

**New Features:**

- `list-undetected-evtx-files`: List up all of the `.evtx` files that Hayabusa didn't have a detection rule for. (#4) (@hitenkoku)
- `list-unused-rules`: List up all of the `.yml` detection rules that were not used. (#4) (@hitenkoku)
- Added Logo. If you want to hide the logo, use the `-q, --quiet` option. (#12) (@YamatoSecurity @hitenkoku)
- Added result output option. (`-o, --output` ) (#11) (@hitenkoku)

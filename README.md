<div align="center">
 <p>
    <img alt="Takajo Logō" src="logo.png" width="50%">
 </p>
 [ <b>English</b> ] | [<a href="README-Japanese.md">日本語</a>]
</div>

---

<p align="center">
    <a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/v/release/Yamato-Security/takajo?color=blue&label=Stable%20Version&style=flat""/></a>
    <a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/downloads/Yamato-Security/takajo/total?style=flat&label=GitHub%F0%9F%A6%85Downloads&color=blue"/></a>
    <a href="https://github.com/Yamato-Security/takajo/stargazers"><img src="https://img.shields.io/github/stars/Yamato-Security/takajo?style=flat&label=GitHub%F0%9F%A6%85Stars"/></a>
    <a href="https://codeblue.jp/2022/en/talks/?content=talks_24"><img src="https://img.shields.io/badge/CODE%20BLUE%20Bluebox-2022-blue"></a>
    <a href="https://www.seccon.jp/2022/seccon_workshop/windows.html"><img src="https://img.shields.io/badge/SECCON-2023-blue"></a>
    <a href="https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/"><img src="https://img.shields.io/badge/SANS%20DFIR%20Summit-2023-blue"></a>
    <a href=""><img src="https://img.shields.io/badge/Maintenance%20Level-Actively%20Developed-brightgreen.svg" /></a>
    <a href="https://twitter.com/SecurityYamato"><img src="https://img.shields.io/twitter/follow/SecurityYamato?style=social"/></a>
</p>

## About Takajō

Takajō (鷹匠), created by [Yamato Security](https://github.com/Yamato-Security), is a fast forensics analyzer for [Hayabusa](https://github.com/Yamato-Security/hayabusa) results written in [Nim](https://nim-lang.org/).
Takajō means ["Falconer"](https://en.wikipedia.org/wiki/Falconry) in Japanese and was chosen as Hayabusa's catches (results) can be put to even better use.

# Companion Projects

* [EnableWindowsLogSettings](https://github.com/Yamato-Security/EnableWindowsLogSettings) - documentation and scripts to properly enable Windows event logs.
* [Hayabusa](https://github.com/Yamato-Security/hayabusa) - sigma-based threat hunting and fast forensics timeline generator for Windows event logs.
* [Hayabusa Rules](https://github.com/Yamato-Security/hayabusa-rules) - detection rules for hayabusa.
* [Hayabusa Sample EVTXs](https://github.com/Yamato-Security/hayabusa-sample-evtx) - sample evtx files to use for testing hayabusa/sigma detection rules.
* [WELA (Windows Event Log Analyzer)](https://github.com/Yamato-Security/WELA) - analyzer for Windows event logs written in PowerShell.

## Table of Contents

- [Companion Projects](#companion-projects)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
- [Downloads](#downloads)
  - [Git cloning](#git-cloning)
  - [Advanced: Compiling From Source (Optional)](#advanced-compiling-from-source-optional)
- [Command List](#command-list)
  - [List Commands](#list-commands)
  - [Split Commands](#split-commands)
  - [Stack Commands](#stack-commands)
  - [Sysmon Commands](#sysmon-commands)
  - [Timeline Commands](#timeline-commands)
  - [VirusTotal Commands](#virustotal-commands)
- [Command Usage](#command-usage)
  - [List Commands](#list-commands-1)
    - [`list-network-connections` command](#list-network-connections-command)
    - [`list-undetected-evtx` command](#list-undetected-evtx-command)
      - [`list-undetected-evtx` command examples](#list-undetected-evtx-command-examples)
    - [`list-unused-rules` command](#list-unused-rules-command)
      - [`list-unused-rules` command examples](#list-unused-rules-command-examples)
  - [Split Commands](#split-commands-1)
    - [`split-csv-timeline` command](#split-csv-timeline-command)
      - [`split-csv-timeline` command examples](#split-csv-timeline-command-examples)
    - [`split-json-timeline` command](#split-json-timeline-command)
      - [`split-json-timeline` command examples](#split-json-timeline-command-examples)
  - [Stack Commands](#stack-commands-1)
    - [`stack-remote-logons` command](#stack-remote-logons-command)
      - [`stack-remote-logons` command examples](#stack-remote-logons-command-examples)
  - [Sysmon Commands](#sysmon-commands-1)
    - [`sysmon-process-hashes` command](#sysmon-process-hashes-command)
      - [`sysmon-process-hashes` command examples](#sysmon-process-hashes-command-examples)
    - [`sysmon-process-tree` command](#sysmon-process-tree-command)
      - [`sysmon-process-tree` command examples](#sysmon-process-tree-command-examples)
  - [Timeline Commands](#timeline-commands-1)
    - [`timeline-logon` command](#timeline-logon-command)
      - [`timeline-logon` command examples](#timeline-logon-command-examples)
    - [`timeline-suspicious-processes` command](#timeline-suspicious-processes-command)
      - [`timeline-suspicious-processes` command examples](#timeline-suspicious-processes-command-examples)
  - [VirusTotal Commands](#virustotal-commands-1)
    - [`vt-domain-lookup` command](#vt-domain-lookup-command)
    - [`vt-hash-lookup` command](#vt-hash-lookup-command)
      - [`vt-hash-lookup` command examples](#vt-hash-lookup-command-examples)
    - [`vt-ip-lookup` command](#vt-ip-lookup-command)
  - [Contribution](#contribution)
  - [Bug Submission](#bug-submission)
  - [License](#license)
  - [Twitter](#twitter)

## Features

- Written in Nim so it is very easy to program, memory safe, as fast as native C code and works as a single standalone binary on any OS.
- Create a timeline of all of the various logon events.
- Print the process trees of a malicious processes.
- Create a list up suspicious processes.
- List up all of `.evtx` files that Hayabusa does not have a detection rule for yet.

# Downloads

Please download the latest stable version of Takajo with compiled binaries or compile the source code from the [Releases](https://github.com/Yamato-Security/takajo/releases) page.

## Git cloning

You can git clone the repository with the following command and compile binary from source code:

>> Warning: The main branch of the repository is for development purposes so you may be able to access new features not yet officially released, however, there may be bugs so consider it unstable.

`git clone https://github.com/Yamato-Security/takajo.git`

## Advanced: Compiling From Source (Optional)

If you have Nim installed, you can compile from source with the following command:

```bash
> nimble update
> nimble build -d:release -d:ssl
```

# Command List

## List Commands
* `list-network-connections`: create a list of unique target and/or source IP addresses (input: JSONL, profile: standard)
* `list-undetected-evtx`: create a list of undetected evtx files (input: CSV, profile: verbose)
* `list-unused-rules`: create a list of unused sigma rules (input: CSV, profile: verbose)

## Split Commands
* `split-csv-timeline`: split up a large CSV timeline into smaller ones based on the computer name (input: non-multiline CSV, profile: any)
* `split-json-timeline`: split up a large JSONL timeline into smaller ones based on the computer name (input: JSONL, profile: any)

## Stack Commands
* `stackRemoteLogons`: create a list of top accounts that logged into computers (input: JSONL, profile: standard)

## Sysmon Commands
* `sysmon-process-hashes`: create a list of process hashes to be used with vt-hash-lookup (input: JSONL, profile: standard)
* `sysmon-process-tree`: output the process tree of a certain process (input: JSONL, profile: standard)

## Timeline Commands
* `timeline-logon`: create a CSV timeline of logon events (input: JSONL, profile: standard)
* `timeline-suspicious-processes`: create a CSV timeline of suspicious processes (input: JSONL, profile: standard)

## VirusTotal Commands
* `vt-domain-lookup`: look up a list of domains on VirusTotal and report on malicious ones (input: JSONL, profile: standard)
* `vt-hash-lookup`: look up a list of hashes on VirusTotal and report on malicious ones (input: JSONL, profile: standard)
* `vt-ip-lookup`: look up a list of IP addresses on VirusTotal and report on malicious ones (input: JSONL, profile: standard)

# Command Usage

## List Commands

### `list-network-connections` command

Creates a list of unique target and/or source IP addresses (input: JSONL, profile: standard)
Not implemented yet.

### `list-undetected-evtx` command

List up all of the `.evtx` files that Hayabusa didn't have a detection rule for.
This is meant to be used on sample evtx files that all contain evidence of malicious activity such as the sample evtx files in the [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) repository.
You first need to run Hayabusa with a profile that saves the `%EvtxFile%` column information and save the results to a csv timeline. Example: `hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv`.
You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).

Required options:

- `-t, --timeline <CSV-FILE>`: CSV timeline created by Hayabusa.
- `-e, --evtx-dir <DIR>`: The directory of `.evtx` files you scanned with Hayabusa.

Options:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: Optional: Specify a custom column name for the evtx column. Default is Hayabusa's default of `EvtxFile`.
- `-o, --output <TXT-FILE>`: Save the results to a text file. The default is to print to screen.
- `-q, --quiet`: Do not display logo.

#### `list-undetected-evtx` command examples

```bash
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx
```

### `list-unused-rules` command

List up all of the `.yml` detection rules that did not detect anything. This is useful to help determine the reliablity of rules. That is, which rules are known to find malicious activity and which are still untested and need sample `.evtx` files.
You first need to run Hayabusa with a profile that saves the `%RuleFile%` column information and save the results to a csv timeline. Example: `hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv`.
You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).

Required options:

- `-t, --timeline <CSV-FILE>`: CSV timeline created by Hayabusa.
- `-r, --rules-dir <DIR>`: The directory of `.yml` rules files you used with Hayabusa.

Options:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: Specify a custom column name for the rule file column. Default is Hayabusa's default of `RuleFile`.
- `-o, --output <TXT-FILE>`: Save the results to a text file. The default is to print to screen.
- `-q, --quiet`: Do not display logo.

#### `list-unused-rules` command examples

```bash
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

```bash
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

## Split Commands

### `split-csv-timeline` command

Split up a large CSV timeline into smaller ones based on the computer name. (input: non-multiline CSV, profile: any)

Required options:

- `-t, --timeline <CSV-FILE>`: CSV timeline created by Hayabusa.
- `-o, --output <DIR>`: Directory to save the CSV results to.

Options:

- `-m, --makeMultiline`: Output fields in multiple lines.
- `-q, --quiet`: Do not display logo.

#### `split-csv-timeline` command examples

```bash
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

### `split-json-timeline` command

Split up a large JSONL timeline into smaller ones based on the computer name.

Required options:

- `-t, --timeline <JSONL-FILE>`: JSONL timeline created by Hayabusa.
- `-o, --output <DIR>`: Directory to save the JSONL results to.

Options:

- `-q, --quiet`: Do not display logo.

#### `split-json-timeline` command examples

```bash
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

## Stack Commands

### `stack-remote-logons` command

Creates a list of top accounts that logged into computers (input: JSONL, profile: standard)
Not implemented yet.

#### `stack-remote-logons` command examples

```bash
takajo.exe stack-remote-logons -t ../hayabusa/timeline.jsonl
```

## Sysmon Commands

### `sysmon-process-hashes` command

Create a list of process hashes to be used with vt-hash-lookup (input: JSONL, profile: standard)

Required options:

- `-t, --timeline <JSONL-FILE>`: JSONL timeline created by Hayabusa.
- `-o, --output <BASE-NAME>`: Specify the base name to save the text results to.

Options:

- `-l, --level`: Specify the minimum level. Default: `high`
- `-q, --quiet`: Do not display logo.

#### `sysmon-process-hashes` command examples

Prepare JSONL timeline with Hayabusa:

```bash
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

Save the results to a CSV file:

```bash
takajo.exe sysmon-process-hashes -t ../hayabusa/timeline.jsonl -o hashes
```

### `sysmon-process-tree` command

Output the process tree of a certain process (input: JSONL, profile: standard)
This command will print out the process tree of a suspicious or malicious process.

Required options:

- `-t, --timeline <JSONL-FILE>`: JSONL timeline created by Hayabusa.
- `-o, --output <TXT-FILE>`: A text file to save the results to.
- `-p, --processGuid`: Sysmon process GUID

Options:

- `-q, --quiet`: Do not display logo.

#### `sysmon-process-tree` command examples

Prepare JSONL timeline with Hayabusa:

```bash
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

Output results to screen:

```bash
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00"
```

Save the results to a CSV file:

```bash
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -o process-tree.txt
```

## Timeline Commands

### `timeline-logon` command

This command extracts information from the following logon events, normalizes the fields and saves the results to a CSV file.
This makes it easier to detect lateral movement, password guessing/spraying, privilege escalation, etc...
- `4624` - Successful Logon
- `4625` - Failed Logon
- `4634` - Account Logoff
- `4647` - User Initiated Logoff
- `4648` - Explicit Logon
- `4672` - Admin Logon
-

Required options:

- `-t, --timeline <JSONL-FILE>`: JSONL timeline created by Hayabusa.
- `-o, --output <CSV-FILE>`: The CSV file to save the results to.

Options:

- `-q, --quiet`: Do not display logo.

#### `timeline-logon` command examples

Prepare JSONL timeline with Hayabusa:

```bash
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

Save logon timeline to a CSV file:

```bash
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-suspicious-processes` command

Create a CSV timeline of suspicious processes (input: JSONL, profile: standard)

Required options:

- `-l, --level <LEVEL>`: Specify the minimum alert level.
- `-t, --timeline <JSONL-FILE>`: JSONL timeline created by Hayabusa.
- `-o, --output <CSV-FILE>`: The CSV file to save the results to.

Options:

- `-q, --quiet`: Do not display logo.

#### `timeline-suspicious-processes` command examples

Prepare JSONL timeline with Hayabusa:

```bash
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

Search for processes that had an alert level of high or above and output results to screen:

```bash
takajo.exe timeline-suspicious-process -t ../hayabusa/timeline.jsonl
```

Search for processes that had an alert level of low or above and output results to screen:

```bash
takajo.exe timeline-suspicious-process -t ../hayabusa/timeline.jsonl -l low
```

Save the results to a CSV file:

```bash
takajo.exe timeline-suspicious-process -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

## VirusTotal Commands

### `vt-domain-lookup` command
Look up a list of domains on VirusTotal (input: JSONL, profile: standard)
Not yet implemented.

### `vt-hash-lookup` command

Look up a list of hashes on VirusTotal (input: JSONL, profile: standard)

Required options:

- `-a, --apiKey <API-KEY>`: Your API key.
- `--hashList <HASH-LIST>`: A text file of hashes.

Options:

- `-j, --jsonOutput <JSON-FILE>`: Output all of the JSON responses from VirusTotal to a JSON file.
- `-o, --output <CSV-FILE`: Save the results to a CSV file.
- `-r, --rateLimit <NUMBER>`: The rate per minute to send requests. Default: `4`
- `-q, --quiet`: Do not display logo.

#### `vt-hash-lookup` command examples

```bash
takajo.exe vt-hash-lookup -a xxx --hashlist MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 --jsonOutput vt-hash-lookup.json
```

### `vt-ip-lookup` command
Look up a list of IP addresses on VirusTotal (input: JSONL, profile: standard)
Not yet implemented.

## Contribution

We would love any form of contribution. Pull requests, rule creation and sample evtx logs are the best but feature requests, notifying us of bugs, etc... are also very welcome.

At the least, if you like our tool then please give us a star on Github and show your support!

## Bug Submission

Please submit any bugs you find [here.](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D)
This project is currently actively maintained and we are happy to fix any bugs reported.

If you find any issues (false positives, bugs, etc...) with Hayabusa, please report them to the hayabusa github issues page [here](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D).

If you find any issues (false positives, bugs, etc...) with Hayabusa rules, please report them to the hayabusa-rules github issues page [here](https://github.com/Yamato-Security/hayabusa-rules/issues/new).

If you find any issues (false positives, bugs, etc...) with Sigma rules, please report them to the upstream SigmaHQ github issues page [here](https://github.com/SigmaHQ/sigma/issues).

## License

Takajō is released under the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

## Twitter

You can recieve the latest news about Takajō, Hayabusa, rule updates, other Yamato Security tools, etc... by following us on Twitter at [@SecurityYamato](https://twitter.com/SecurityYamato).

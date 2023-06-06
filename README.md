<div align="center">
 <p>
    <img alt="Takajo Logō" src="logo.png" width="50%">
 </p>
 [ <b>English</b> ] | [<a href="README-Japanese.md">日本語</a>]
</div>

---

<p align="center">
    <a href="https://github.com/Yamato-Security/hayabusa/releases"><img src="https://img.shields.io/github/v/release/Yamato-Security/takajo?color=blue&label=Stable%20Version&style=flat""/></a>
    <a href="https://github.com/Yamato-Security/hayabusa/releases"><img src="https://img.shields.io/github/downloads/Yamato-Security/takajo/total?style=flat&label=GitHub%F0%9F%A6%85Downloads&color=blue"/></a>
    <a href="https://github.com/Yamato-Security/hayabusa/stargazers"><img src="https://img.shields.io/github/stars/Yamato-Security/hayabusa?style=flat&label=GitHub%F0%9F%A6%85Stars"/></a>
    <a href="https://www.blackhat.com/asia-22/arsenal/schedule/#hayabusa-26211"><img src="https://raw.githubusercontent.com/toolswatch/badges/master/arsenal/asia/2022.svg"></a>
    <a href="https://codeblue.jp/2022/en/talks/?content=talks_24"><img src="https://img.shields.io/badge/CODE%20BLUE%20Bluebox-2022-blue"></a>
    <a href="https://www.seccon.jp/2022/seccon_workshop/windows.html"><img src="https://img.shields.io/badge/SECCON-2023-blue"></a>
    <a href="https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/"><img src="https://img.shields.io/badge/SANS%20DFIR%20Summit-2023-blue"></a>
    <a href=""><img src="https://img.shields.io/badge/Maintenance%20Level-Actively%20Developed-brightgreen.svg" /></a>
    <a href="https://twitter.com/SecurityYamato"><img src="https://img.shields.io/twitter/follow/SecurityYamato?style=social"/></a>
</p>

## About Takajō

Takajō (鷹匠), created by [Yamato Security](https://github.com/Yamato-Security), is an analyzer for [Hayabusa](https://github.com/Yamato-Security/hayabusa) results written in [Nim](https://nim-lang.org/).
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
  - [Planned features](#planned-features)
  - [Git cloning](#git-cloning)
  - [Advanced: Compiling From Source (Optional)](#advanced-compiling-from-source-optional)
    - [Usage](#usage)
  - [Contribution](#contribution)
  - [Bug Submission](#bug-submission)
  - [License](#license)
  - [Twitter](#twitter)

## Features

- Written in Nim so it is very easy to program, memory safe, almost as fast as native C code and works as a single standalone binary on any OS.
- `undetected-evtx`: List up all of the `.evtx` files that Hayabusa didn't have a detection rule for. This is meant to be used on sample evtx files that all contain evidence of malicious activity such as the sample evtx files in the [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) repository.
- `unused-rules`: List up all of the `.yml` detection rules that were not used. This is useful for finding out which rules are currently not proven to work and that need sample evtx files.

## Planned features

- Behavior analysis
- Malicious process tree visualization

## Git cloning

You can git clone the repository with the following command and compile binary from source code:

>> Warning: The main branch of the repository is for development purposes so you may be able to access new features not yet officially released, however, there may be bugs so consider it unstable.

`git clone https://github.com/Yamato-Security/takajo.git`

## Advanced: Compiling From Source (Optional)

If you have Nim installed, you can compile from source with the following command:

```bash
> nimble update
> nimble build -d:release
```

### Usage

1. `help`: Print help menu for all commands.
2. `undetected-evtx`: List up all of the `.evtx` files that Hayabusa didn't have a detection rule for.
You first need to run Hayabusa with a profile that saves the `%EvtxFile%` column information and save the results to a csv timeline. Example: `hayabusa.exe -d <dir> -P verbose -o timeline.csv`.
You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).

Required options:

- `-t, --timeline ../hayabusa/timeline.csv`: CSV timeline created by Hayabusa.
- `-e, --evtx-dir ../hayabusa-sample-evtx`: The directory of `.evtx` files you scanned with Hayabusa.

Options:

- `-c, --column-name CustomEvtxColumn`: Optional: Specify a custom column name for the evtx column. Default is Hayabusa's default of `EvtxFile`.
- `-o, --output result.txt`: Save the results to a text file. The default is to print to screen.
- `-q, --quiet`: Do not display logo.

Example:

```bash
takajo.exe undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx
```

3. `unused-rules`: List up all of the `.yml` detection rules that did not detect anything. This is useful to help determine the reliablity of rules. That is, which rules are known to find malicious activity and which are still untested.
You first need to run Hayabusa with a profile that saves the `%RuleFile%` column information and save the results to a csv timeline. Example: `hayabusa.exe -d <dir> -P verbose -o timeline.csv`.
You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).

Required options:

- `-t, --timeline ../hayabusa/timeline.csv`: CSV timeline created by Hayabusa.
- `-r, --rules-dir ../hayabusa/rules`: The directory of `.yml` rules files you used with Hayabusa.

Options:

- `-c, --column-name CustomRuleFileColumn`: Specify a custom column name for the rule file column. Default is Hayabusa's default of `RuleFile`.
- `-o, --output result.txt`: Save the results to a text file. The default is to print to screen.
- `-q, --quiet`: Do not display logo.

Example:

```bash
takajo.exe unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

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

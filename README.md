<div align="center">
 <p>
    <img alt="Takajo Logō" src="logo.png" width="50%">
 </p>
 [ <b>English</b> ] | [<a href="README-Japanese.md">日本語</a>]
</div>

---

[tag-1]: https://img.shields.io/github/downloads/Yamato-Secuirty/takajo/total?label=GitHub%F0%9F%8E%AFDownloads&style=plastic
[tag-2]: https://img.shields.io/github/stars/Yamato-Security/takajo?style=plastic&label=GitHub%F0%9F%8E%AFStars
[tag-3]: https://img.shields.io/github/v/release/Yamato-Security/takajo?display_name=tag&label=latest-version&style=plastic
[tag-4]: https://img.shields.io/badge/Maintenance%20Level-Actively%20Developed-brightgreen.svg
[tag-5]: https://img.shields.io/badge/Twitter-00acee?logo=twitter&logoColor=white

![tag-1] ![tag-2] <a href="https://github.com/Yamato-Security/hayabusa/releases">![tag-3]</a> ![tag-4]</a> ![tag-5]  <a href="https://twitter.com/SecurityYamato"></a>

# About Takajō

Takajō (鷹匠), created by [Yamato Security](https://github.com/Yamato-Security), is an analyzer for [Hayabusa](https://github.com/Yamato-Security/hayabusa) results written in [Nim](https://nim-lang.org/).
Takajō means ["Falconer"](https://en.wikipedia.org/wiki/Falconry) in Japanese and was chosen as Hayabusa's catches (results) can be put to even better use.

## Table of Contents

- [About Takajō](#about-takajō)
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
- `list-undetected-evtx-files`: List up all of the `.evtx` files that Hayabusa didn't have a detection rule for.
- `list-unused-rules`: List up all of the `.yml` detection rules that were not used. 

## Planned features

- Behavior analysis
- Log enrichment (Adding Geolocation, ASN info, threat intelligence based on IP addresses)
- Malicious process tree visualization

## Git cloning

You can git clone the repository with the following command and compile binary from source code:

>> Warning: The main branch of the repository is for development purposes so you may be able to access new features not yet officially released, however, there may be bugs so consider it unstable.

`git clone https://github.com/Yamato-Security/takajo.git`

## Advanced: Compiling From Source (Optional)

If you have Nim installed, you can compile from source with the following command:

```bash
> nimble update
> nimble build
```

### Usage

1. `-h, --help`: Print help menu.
2. `list-undetected-evtx-files`: List up all of the `.evtx` files that Hayabusa didn't have a detection rule for.
You first need to run Hayabusa with a profile that saves the `%EvtxFile%` column information and save the results to a csv timeline. Example: `hayabusa.exe -d <dir> -P verbose -o timeline.csv`.  
You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).

Required options:
* `-t, --timeline timeline.csv`: CSV timeline created by Hayabusa.
* `-e, --evtx-dir ../hayabusa-sample-evtx`: The directory of `.evtx` files you scanned with Hayabusa.

Optional options:
* `-o, --output undetected-evtx-files.txt`: Save the results to a text file. The default is to print to screen.

Example 1:
```bash
takajo.exe list-undetected-evtx-files -t timeline.csv -e .\hayabusa-sample-evtx
```

Example 2:
```bash
takajo.exe list-undetected-evtx-files -t timeline.csv -e .\hayabusa-sample-evtx -o undetected-evtx-files.txt
```

3.`list-unused-rules`: List up all of the `.yml` detection rules that did not detect anything. This is useful to help determine the reliablity of rules. That is, which rules are known to find malicious activity and which are still untested.
You first need to run Hayabusa with a profile that saves the `%RuleFile%` column information and save the results to a csv timeline. Example: `hayabusa.exe -d <dir> -P verbose -o timeline.csv`.  
You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).

Required options:
* `-t, --timeline timeline.csv`: CSV timeline created by Hayabusa.
* `-r, --rules-dir ../hayabusa-sample-evtx`: The directory of `.yml` rules files you used with Hayabusa.

Optional options:
* `-o, --output unused-rules.txt`: Save the results to a text file. The default is to print to screen.

Example 1:
```bash
takajo.exe list-unused-rules -t timeline.csv -r ../hayabusa/rules
```

Example 2:
```bash
takajo.exe list-unused-rules -t timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

## Contribution

We would love any form of contribution. Pull requests, rule creation and sample evtx logs are the best but feature requests, notifying us of bugs, etc... are also very welcome.

At the least, if you like our tool then please give us a star on Github and show your support!

## Bug Submission

Please submit any bugs you find [here.](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D)
This project is currently actively maintained and we are happy to fix any bugs reported.

If you find any issues (false positives, bugs, etc...) with Hayabusa, please report them to the hayabusa-rules github issues page [here](https://github.com/Yamato-Security/hayabusa/issues/new).

If you find any issues (false positives, bugs, etc...) with Hayabusa rules, please report them to the hayabusa-rules github issues page [here](https://github.com/Yamato-Security/hayabusa-rules/issues/new).

If you find any issues (false positives, bugs, etc...) with Sigma rules, please report them to the upstream SigmaHQ github issues page [here](https://github.com/SigmaHQ/sigma/issues).

## License

Takajō is released under the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

## Twitter

You can recieve the latest news about Takajō, Hayabusa, rule updates, other Yamato Security tools, etc... by following us on Twitter at [@SecurityYamato](https://twitter.com/SecurityYamato).

# Takajo

<div align="center">
 <p>
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

# About Takajo

Takajo (鷹匠) is an analyzer for [Hayabusa](https://github.com/Yamato-Security/hayabusa) results written in [Nim](https://nim-lang.org/).  Takajo created by the [Yamato Security](https://yamatosecurity.connpass.com/) group in Japan.
Takajo means ["A person skilled in the art of falconry"](https://en.wikipedia.org/wiki/Falconry) in Japanese and was chosen as Hayabusa's prey can be put to good use.

## Table of Contents

- [Takajo](#takajo)
- [About Takajo](#about-takajo)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Git cloning](#git-cloning)
  - [Advanced: Compiling From Source (Optional)](#advanced-compiling-from-source-optional)
    - [Usage](#usage)
  - [Contribution](#contribution)
  - [Bug Submission](#bug-submission)
  - [License](#license)
  - [Twitter](#twitter)

## Features

- check undetected windows event file to Hayabusa csv output.
- check undetected rule file to Hayabusa csv output.

## Git cloning

You can git clone the repository with the following command and compile binary from source code:

Warning: The main branch of the repository is for development purposes so you may be able to access new features not yet officially released, however, there may be bugs so consider it unstable.

git clone https://github.com/Yamato-Security/takajo.git

## Advanced: Compiling From Source (Optional)

If you have Nim installed, you can compile from source with the following command:

```bash
> nimble update
> nimble install
> nimble build
```

### Usage

- check undetected windows event file to Hayabusa csv output(ex. output.csv). `-t` option value is compare target column name in output.csv.

```bash
takajo.exe evtx output.csv -c .\\hayabusa-sample-evtx -t EvtxFile
```

- check undetected rule file to Hayabusa csv output(ex. output.csv).

```bash
takajo.exe yml output.csv -c .\\hayabusa\\rules -t RuleFile
```

## Contribution

We would love any form of contribution. Pull requests, rule creation and sample evtx logs are the best but feature requests, notifying us of bugs, etc... are also very welcome.

At the least, if you like our tool then please give us a star on Github and show your support!

## Bug Submission

Please submit any bugs you find [here.](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D)
This project is currently actively maintained and we are happy to fix any bugs reported.

If you find any issues (false positives, bugs, etc...) with Hayabusa rules, please report them to the hayabusa-rules github issues page [here](https://github.com/Yamato-Security/hayabusa-rules/issues/new).

If you find any issues (false positives, bugs, etc...) with Sigma rules, please report them to the upstream SigmaHQ github issues page [here](https://github.com/SigmaHQ/sigma/issues).

## License

Takajo is released under [MIT License](https://mit-license.org/).

## Twitter

You can recieve the latest news about Hayabusa, rule updates, other Yamato Security tools, etc... by following us on Twitter at [@SecurityYamato](https://twitter.com/SecurityYamato).
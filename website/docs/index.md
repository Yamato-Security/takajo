---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) is a fast forensics analyzer for
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> results, created by
<a href="https://github.com/Yamato-Security">Yamato Security</a> and written in
<a href="https://nim-lang.org/">Nim</a>. Takajō means
<a href="https://en.wikipedia.org/wiki/Falconry">"Falconer"</a> in Japanese — it analyzes
Hayabusa's "catches" (results).
</p>

<div class="hb-cta" markdown>
[Get Started :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Command Reference :material-console:](commands/index.md){ .md-button }
[View on GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
</div>

<p class="hb-badges">
<a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/v/release/Yamato-Security/takajo?color=blue&label=Stable%20Version&style=flat"/></a>
<a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/downloads/Yamato-Security/takajo/total?style=flat&label=GitHub%F0%9F%A6%85Downloads&color=blue"/></a>
<a href="https://github.com/Yamato-Security/takajo/stargazers"><img src="https://img.shields.io/github/stars/Yamato-Security/takajo?style=flat&label=GitHub%F0%9F%A6%85Stars"/></a>
<a href="https://codeblue.jp/2022/en/talks/?content=talks_24"><img src="https://img.shields.io/badge/CODE%20BLUE%20Bluebox-2022-blue"></a>
<a href="https://www.seccon.jp/2022/seccon_workshop/windows.html"><img src="https://img.shields.io/badge/SECCON-2023-blue"></a>
<a href="https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/"><img src="https://img.shields.io/badge/SANS%20DFIR%20Summit-2023-blue"></a>
<a href="https://bsides.tokyo/2024/"><img src="https://img.shields.io/badge/BSides%20Tokyo-2024-blue"></a>
<a href="https://www.hacker.or.jp/hack-fes-2024/"><img src="https://img.shields.io/badge/Hack%20Fes.-2024-blue"></a>
<a href="https://hitcon.org/2024/CMT/"><img src="https://img.shields.io/badge/HITCON-2024-blue"></a>
<a href="https://www.blackhat.com/sector/2024/briefings/schedule/index.html#performing-dfir-and-threat-hunting-with-yamato-security-oss-tools-and-community-driven-knowledge-41347"><img src="https://img.shields.io/badge/SecTor-2024-blue"></a>
<a href="https://twitter.com/SecurityYamato"><img src="https://img.shields.io/twitter/follow/SecurityYamato?style=social"/></a>
</p>

</div>

---

## Why Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Single fast binary__

    ---

    Written in **Nim** — memory-safe, as fast as native C, and a single standalone
    binary on any OS.

-   :material-file-chart:{ .lg .middle } __HTML reports__

    ---

    Generate HTML summary reports of your Hayabusa results, or serve them interactively.

-   :material-file-tree:{ .lg .middle } __Process trees__

    ---

    Reconstruct and print the **process trees** of malicious processes from Sysmon logs.

-   :material-layers-triple:{ .lg .middle } __Stacking analysis__

    ---

    Stack command lines, DNS requests, logons, processes, services, tasks and more to
    surface outliers.

-   :material-timeline-clock:{ .lg .middle } __Focused timelines__

    ---

    Build timelines for logons, USB usage, suspicious processes and tasks, and split
    large CSV/JSONL timelines.

-   :material-shield-search:{ .lg .middle } __TTPs & VirusTotal__

    ---

    Visualize TTPs as heatmaps in the **MITRE ATT&CK Navigator**, and look up IPs,
    domains and hashes on **VirusTotal**.

</div>

## Quick links

<div class="grid cards" markdown>

-   __:material-book-open-variant: New here?__

    Start with the [Overview](overview/index.md), then head to
    [Getting Started](getting-started/index.md) to download and run Takajō.

-   __:material-console-line: Working with the CLI?__

    Browse the [Command List](commands/index.md) and the per-category reference —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), and more.

-   __:material-puzzle: Going further?__

    Explore the [Companion Projects](resources/companion-projects.md), the
    [Changelog](resources/changelog.md), and how to
    [contribute](resources/contributing.md).

</div>

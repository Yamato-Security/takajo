---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) 是一款針對
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> 結果的快速鑑識分析工具，由
<a href="https://github.com/Yamato-Security">Yamato Security</a> 開發，並以
<a href="https://nim-lang.org/">Nim</a> 撰寫。Takajō 在日文中意為
<a href="https://en.wikipedia.org/wiki/Falconry">「馴鷹師」</a>——它會分析
Hayabusa 的「獵物」（結果）。
</p>

<div class="hb-cta" markdown>
[開始使用 :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[命令參考 :material-console:](commands/index.md){ .md-button }
[在 GitHub 上檢視 :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## 為什麼選擇 Takajō？

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __單一快速執行檔__

    ---

    以 **Nim** 撰寫——記憶體安全、效能媲美原生 C，並且在任何作業系統上都是單一獨立的
    執行檔。

-   :material-file-chart:{ .lg .middle } __HTML 報告__

    ---

    產生 Hayabusa 結果的 HTML 摘要報告，或以互動方式提供服務。

-   :material-file-tree:{ .lg .middle } __程序樹__

    ---

    從 Sysmon 紀錄重建並輸出惡意程序的 **程序樹**。

-   :material-layers-triple:{ .lg .middle } __堆疊分析__

    ---

    對命令列、DNS 請求、登入、程序、服務、工作等進行堆疊，以
    凸顯離群值。

-   :material-timeline-clock:{ .lg .middle } __聚焦式時間軸__

    ---

    為登入、USB 使用、可疑程序與工作建立時間軸，並分割
    大型 CSV/JSONL 時間軸。

-   :material-shield-search:{ .lg .middle } __TTP 與 VirusTotal__

    ---

    在 **MITRE ATT&CK Navigator** 中將 TTP 視覺化為熱度圖，並在 **VirusTotal** 上
    查詢 IP、網域與雜湊值。

</div>

## 快速連結

<div class="grid cards" markdown>

-   __:material-book-open-variant: 初次使用？__

    從 [概觀](overview/index.md) 開始，接著前往
    [開始使用](getting-started/index.md) 下載並執行 Takajō。

-   __:material-console-line: 使用 CLI？__

    瀏覽 [命令清單](commands/index.md) 以及各類別的參考——
    [Extract](commands/extract.md)、[HTML](commands/html.md)、[Stack](commands/stack.md)、
    [Timeline](commands/timeline.md) 等。

-   __:material-puzzle: 想更進一步？__

    探索 [配套專案](resources/companion-projects.md)、
    [變更紀錄](resources/changelog.md)，以及如何
    [貢獻](resources/contributing.md)。

</div>

---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong>（鷹匠）は、<a href="https://github.com/Yamato-Security">Yamato Security</a>
によって作られた、<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a>
の結果を解析する高速フォレンジック解析ツールです。<a href="https://nim-lang.org/">Nim</a>
で記述されています。Takajō は日本語で<a href="https://ja.wikipedia.org/wiki/%E9%B7%B9%E7%8B%A9">「鷹匠」</a>を意味し、
Hayabusa が捕らえた「獲物」（結果）を解析することから名付けられました。
</p>

<div class="hb-cta" markdown>
[はじめる :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[コマンド一覧 :material-console:](commands/index.md){ .md-button }
[GitHub で見る :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Takajō の特徴

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __単一の高速バイナリ__

    ---

    **Nim** で記述され、メモリセーフかつネイティブ C 並みに高速で、あらゆる OS で
    単一のスタンドアロンバイナリとして動作します。

-   :material-file-chart:{ .lg .middle } __HTML レポート__

    ---

    Hayabusa の結果を HTML サマリレポートとして生成、またはインタラクティブに配信できます。

-   :material-file-tree:{ .lg .middle } __プロセスツリー__

    ---

    Sysmon ログから悪意のあるプロセスの**プロセスツリー**を再構築して表示します。

-   :material-layers-triple:{ .lg .middle } __スタッキング解析__

    ---

    コマンドライン、DNS リクエスト、ログオン、プロセス、サービス、タスクなどをスタックして
    外れ値を浮かび上がらせます。

-   :material-timeline-clock:{ .lg .middle } __目的別タイムライン__

    ---

    ログオン、USB 使用、不審なプロセスやタスクのタイムラインを作成し、大きな CSV/JSONL
    タイムラインを分割できます。

-   :material-shield-search:{ .lg .middle } __TTP と VirusTotal__

    ---

    **MITRE ATT&CK Navigator** で TTP をヒートマップとして可視化し、IP・ドメイン・ハッシュを
    **VirusTotal** で照会できます。

</div>

## クイックリンク

<div class="grid cards" markdown>

-   __:material-book-open-variant: はじめての方へ__

    まずは[概要](overview/index.md)を読み、[はじめる](getting-started/index.md)で
    Takajō のダウンロードと実行を行いましょう。

-   __:material-console-line: CLI を使う__

    [コマンド一覧](commands/index.md)や、[Extract](commands/extract.md)・
    [HTML](commands/html.md)・[Stack](commands/stack.md)・[Timeline](commands/timeline.md)
    などのカテゴリ別リファレンスをご覧ください。

-   __:material-puzzle: さらに活用する__

    [関連プロジェクト](resources/companion-projects.md)、[変更履歴](resources/changelog.md)、
    [貢献方法](resources/contributing.md)を見てみましょう。

</div>

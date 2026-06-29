---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) adalah penganalisis forensik cepat untuk
hasil <a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a>, dibuat oleh
<a href="https://github.com/Yamato-Security">Yamato Security</a> dan ditulis dalam
<a href="https://nim-lang.org/">Nim</a>. Takajō berarti
<a href="https://en.wikipedia.org/wiki/Falconry">"Pemburu dengan Elang"</a> dalam bahasa Jepang — alat ini menganalisis
"tangkapan" (hasil) Hayabusa.
</p>

<div class="hb-cta" markdown>
[Mulai :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Referensi Perintah :material-console:](commands/index.md){ .md-button }
[Lihat di GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Mengapa Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Biner tunggal yang cepat__

    ---

    Ditulis dalam **Nim** — aman-memori, secepat C native, dan biner mandiri
    tunggal di OS apa pun.

-   :material-file-chart:{ .lg .middle } __Laporan HTML__

    ---

    Hasilkan laporan ringkasan HTML dari hasil Hayabusa Anda, atau sajikan secara interaktif.

-   :material-file-tree:{ .lg .middle } __Pohon proses__

    ---

    Rekonstruksi dan cetak **pohon proses** dari proses berbahaya dari log Sysmon.

-   :material-layers-triple:{ .lg .middle } __Analisis stacking__

    ---

    Susun (stack) baris perintah, permintaan DNS, logon, proses, layanan, tugas, dan lainnya untuk
    memunculkan pencilan (outlier).

-   :material-timeline-clock:{ .lg .middle } __Linimasa terfokus__

    ---

    Bangun linimasa untuk logon, penggunaan USB, proses dan tugas mencurigakan, serta pisahkan
    linimasa CSV/JSONL berukuran besar.

-   :material-shield-search:{ .lg .middle } __TTP & VirusTotal__

    ---

    Visualisasikan TTP sebagai heatmap di **MITRE ATT&CK Navigator**, dan cari IP,
    domain, serta hash di **VirusTotal**.

</div>

## Tautan cepat

<div class="grid cards" markdown>

-   __:material-book-open-variant: Baru di sini?__

    Mulai dengan [Ikhtisar](overview/index.md), lalu menuju ke
    [Memulai](getting-started/index.md) untuk mengunduh dan menjalankan Takajō.

-   __:material-console-line: Bekerja dengan CLI?__

    Jelajahi [Daftar Perintah](commands/index.md) dan referensi per-kategori —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), dan lainnya.

-   __:material-puzzle: Ingin lebih jauh?__

    Jelajahi [Proyek Pendamping](resources/companion-projects.md), 
    [Changelog](resources/changelog.md), dan cara
    [berkontribusi](resources/contributing.md).

</div>

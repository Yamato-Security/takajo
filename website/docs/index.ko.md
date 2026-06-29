---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠)는
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> 결과를 위한 빠른 포렌식 분석 도구로,
<a href="https://github.com/Yamato-Security">Yamato Security</a>가 제작하였으며
<a href="https://nim-lang.org/">Nim</a>으로 작성되었습니다. Takajō는 일본어로
<a href="https://en.wikipedia.org/wiki/Falconry">"매사냥꾼"</a>을 의미하며 —
Hayabusa의 "포획물"(결과)을 분석합니다.
</p>

<div class="hb-cta" markdown>
[시작하기 :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[명령어 레퍼런스 :material-console:](commands/index.md){ .md-button }
[GitHub에서 보기 :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## 왜 Takajō인가?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __단일 고속 바이너리__

    ---

    **Nim**으로 작성됨 — 메모리 안전성을 갖추고, 네이티브 C만큼 빠르며, 모든 OS에서
    단일 독립 실행형 바이너리입니다.

-   :material-file-chart:{ .lg .middle } __HTML 보고서__

    ---

    Hayabusa 결과의 HTML 요약 보고서를 생성하거나 대화형으로 제공할 수 있습니다.

-   :material-file-tree:{ .lg .middle } __프로세스 트리__

    ---

    Sysmon 로그로부터 악성 프로세스의 **프로세스 트리**를 재구성하고 출력합니다.

-   :material-layers-triple:{ .lg .middle } __스태킹 분석__

    ---

    명령줄, DNS 요청, 로그온, 프로세스, 서비스, 작업 등을 스태킹하여
    이상값을 드러냅니다.

-   :material-timeline-clock:{ .lg .middle } __집중형 타임라인__

    ---

    로그온, USB 사용, 의심스러운 프로세스 및 작업에 대한 타임라인을 구축하고,
    대용량 CSV/JSONL 타임라인을 분할합니다.

-   :material-shield-search:{ .lg .middle } __TTP 및 VirusTotal__

    ---

    **MITRE ATT&CK Navigator**에서 TTP를 히트맵으로 시각화하고, IP,
    도메인, 해시를 **VirusTotal**에서 조회합니다.

</div>

## 빠른 링크

<div class="grid cards" markdown>

-   __:material-book-open-variant: 처음 오셨나요?__

    [개요](overview/index.md)부터 시작한 다음,
    [시작하기](getting-started/index.md)로 이동하여 Takajō를 다운로드하고 실행하세요.

-   __:material-console-line: CLI로 작업 중이신가요?__

    [명령어 목록](commands/index.md)과 카테고리별 레퍼런스를 살펴보세요 —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md) 등.

-   __:material-puzzle: 더 나아가시려나요?__

    [관련 프로젝트](resources/companion-projects.md),
    [변경 이력](resources/changelog.md), 그리고
    [기여하는 방법](resources/contributing.md)을 탐색해 보세요.

</div>

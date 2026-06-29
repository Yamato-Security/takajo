---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) — це швидкий аналізатор форензики для
результатів <a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a>, створений
<a href="https://github.com/Yamato-Security">Yamato Security</a> та написаний мовою
<a href="https://nim-lang.org/">Nim</a>. Takajō японською означає
<a href="https://en.wikipedia.org/wiki/Falconry">"Сокольник"</a> — він аналізує
"здобич" Hayabusa (результати).
</p>

<div class="hb-cta" markdown>
[Почати роботу :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Довідник команд :material-console:](commands/index.md){ .md-button }
[Переглянути на GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Чому Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Єдиний швидкий бінарний файл__

    ---

    Написаний мовою **Nim** — безпечний для пам'яті, такий же швидкий, як нативний C, та єдиний автономний
    бінарний файл на будь-якій ОС.

-   :material-file-chart:{ .lg .middle } __HTML-звіти__

    ---

    Генеруйте підсумкові HTML-звіти за результатами Hayabusa або надавайте їх інтерактивно.

-   :material-file-tree:{ .lg .middle } __Дерева процесів__

    ---

    Відновлюйте та виводьте **дерева процесів** шкідливих процесів з журналів Sysmon.

-   :material-layers-triple:{ .lg .middle } __Аналіз стекування__

    ---

    Стекуйте командні рядки, DNS-запити, входи в систему, процеси, служби, завдання та інше, щоб
    виявляти аномалії.

-   :material-timeline-clock:{ .lg .middle } __Сфокусовані хронології__

    ---

    Будуйте хронології для входів у систему, використання USB, підозрілих процесів і завдань, а також розбивайте
    великі хронології CSV/JSONL.

-   :material-shield-search:{ .lg .middle } __TTP та VirusTotal__

    ---

    Візуалізуйте TTP у вигляді теплових карт у **MITRE ATT&CK Navigator** та шукайте IP-адреси,
    домени й хеші у **VirusTotal**.

</div>

## Швидкі посилання

<div class="grid cards" markdown>

-   __:material-book-open-variant: Тут уперше?__

    Почніть з [Огляду](overview/index.md), а потім перейдіть до
    [Початку роботи](getting-started/index.md), щоб завантажити та запустити Takajō.

-   __:material-console-line: Працюєте з CLI?__

    Перегляньте [Список команд](commands/index.md) та довідник за категоріями —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md) та інше.

-   __:material-puzzle: Хочете більше?__

    Ознайомтеся із [Супутніми проєктами](resources/companion-projects.md),
    [Журналом змін](resources/changelog.md) та з тим, як
    [долучитися](resources/contributing.md).

</div>

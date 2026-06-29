---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) هو محلل جنائي رقمي سريع لنتائج
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a>، طوّرته
<a href="https://github.com/Yamato-Security">Yamato Security</a> ومكتوب بلغة
<a href="https://nim-lang.org/">Nim</a>. تعني كلمة Takajō
<a href="https://en.wikipedia.org/wiki/Falconry">"البيّاز"</a> باللغة اليابانية — فهو يحلل
"صيد" Hayabusa (النتائج).
</p>

<div class="hb-cta" markdown>
[ابدأ الآن :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[مرجع الأوامر :material-console:](commands/index.md){ .md-button }
[عرض على GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## لماذا Takajō؟

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __ملف ثنائي واحد سريع__

    ---

    مكتوب بلغة **Nim** — آمن للذاكرة، وبسرعة لغة C الأصلية، وملف ثنائي مستقل واحد
    على أي نظام تشغيل.

-   :material-file-chart:{ .lg .middle } __تقارير HTML__

    ---

    أنشئ تقارير ملخصة بصيغة HTML لنتائج Hayabusa الخاصة بك، أو قدّمها بشكل تفاعلي.

-   :material-file-tree:{ .lg .middle } __أشجار العمليات__

    ---

    أعد بناء وطباعة **أشجار العمليات** للعمليات الخبيثة من سجلات Sysmon.

-   :material-layers-triple:{ .lg .middle } __تحليل التكديس__

    ---

    كدّس سطور الأوامر وطلبات DNS وعمليات تسجيل الدخول والعمليات والخدمات والمهام والمزيد
    لإبراز القيم الشاذة.

-   :material-timeline-clock:{ .lg .middle } __جداول زمنية مركّزة__

    ---

    أنشئ جداول زمنية لعمليات تسجيل الدخول واستخدام USB والعمليات والمهام المشبوهة، وقسّم
    الجداول الزمنية الكبيرة بصيغة CSV/JSONL.

-   :material-shield-search:{ .lg .middle } __TTPs وVirusTotal__

    ---

    اعرض الـ TTPs كخرائط حرارية في **MITRE ATT&CK Navigator**، وابحث عن عناوين IP
    والنطاقات والتجزئات (hashes) على **VirusTotal**.

</div>

## روابط سريعة

<div class="grid cards" markdown>

-   __:material-book-open-variant: جديد هنا؟__

    ابدأ بـ [نظرة عامة](overview/index.md)، ثم انتقل إلى
    [البدء](getting-started/index.md) لتنزيل وتشغيل Takajō.

-   __:material-console-line: تعمل مع واجهة سطر الأوامر؟__

    تصفح [قائمة الأوامر](commands/index.md) والمرجع حسب كل فئة —
    [Extract](commands/extract.md) و[HTML](commands/html.md) و[Stack](commands/stack.md)
    و[Timeline](commands/timeline.md) والمزيد.

-   __:material-puzzle: تريد المزيد؟__

    استكشف [المشاريع المصاحبة](resources/companion-projects.md) و
    [سجل التغييرات](resources/changelog.md) وكيفية
    [المساهمة](resources/contributing.md).

</div>

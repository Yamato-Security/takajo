---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) एक तेज़ फ़ोरेंसिक विश्लेषक है जो
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> के परिणामों के लिए है, इसे
<a href="https://github.com/Yamato-Security">Yamato Security</a> द्वारा बनाया गया है और
<a href="https://nim-lang.org/">Nim</a> में लिखा गया है। Takajō का अर्थ जापानी में
<a href="https://en.wikipedia.org/wiki/Falconry">"बाज़ पालक"</a> है — यह
Hayabusa की "पकड़" (परिणामों) का विश्लेषण करता है।
</p>

<div class="hb-cta" markdown>
[शुरू करें :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[कमांड संदर्भ :material-console:](commands/index.md){ .md-button }
[GitHub पर देखें :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Takajō क्यों?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __एकल तेज़ बाइनरी__

    ---

    **Nim** में लिखा गया — मेमोरी-सुरक्षित, नेटिव C जितना तेज़, और किसी भी OS पर एक
    स्टैंडअलोन बाइनरी।

-   :material-file-chart:{ .lg .middle } __HTML रिपोर्ट__

    ---

    अपने Hayabusa परिणामों की HTML सारांश रिपोर्ट तैयार करें, या उन्हें इंटरैक्टिव रूप से प्रस्तुत करें।

-   :material-file-tree:{ .lg .middle } __प्रोसेस ट्री__

    ---

    Sysmon लॉग से दुर्भावनापूर्ण प्रोसेस के **प्रोसेस ट्री** का पुनर्निर्माण और प्रिंट करें।

-   :material-layers-triple:{ .lg .middle } __स्टैकिंग विश्लेषण__

    ---

    आउटलायर्स को सामने लाने के लिए कमांड लाइनों, DNS अनुरोधों, लॉगऑन, प्रोसेस, सेवाओं, कार्यों और
    अन्य को स्टैक करें।

-   :material-timeline-clock:{ .lg .middle } __केंद्रित टाइमलाइन__

    ---

    लॉगऑन, USB उपयोग, संदिग्ध प्रोसेस और कार्यों के लिए टाइमलाइन बनाएं, और
    बड़ी CSV/JSONL टाइमलाइनों को विभाजित करें।

-   :material-shield-search:{ .lg .middle } __TTPs और VirusTotal__

    ---

    **MITRE ATT&CK Navigator** में TTPs को हीटमैप के रूप में विज़ुअलाइज़ करें, और
    **VirusTotal** पर IP, डोमेन और हैश देखें।

</div>

## त्वरित लिंक

<div class="grid cards" markdown>

-   __:material-book-open-variant: यहाँ नए हैं?__

    [अवलोकन](overview/index.md) से शुरू करें, फिर Takajō को डाउनलोड और चलाने के लिए
    [शुरू करें](getting-started/index.md) पर जाएं।

-   __:material-console-line: CLI के साथ काम कर रहे हैं?__

    [कमांड सूची](commands/index.md) और प्रति-श्रेणी संदर्भ देखें —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), और अन्य।

-   __:material-puzzle: और आगे जा रहे हैं?__

    [सहयोगी परियोजनाएं](resources/companion-projects.md), 
    [चेंजलॉग](resources/changelog.md), और
    [योगदान](resources/contributing.md) कैसे करें, इन्हें देखें।

</div>

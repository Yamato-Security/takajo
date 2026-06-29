---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) သည်
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> ၏ ရလဒ်များအတွက် မြန်ဆန်သော forensics ခွဲခြမ်းစိတ်ဖြာရေး ကိရိယာတစ်ခုဖြစ်ပြီး
<a href="https://github.com/Yamato-Security">Yamato Security</a> မှ ဖန်တီးကာ
<a href="https://nim-lang.org/">Nim</a> ဖြင့် ရေးသားထားသည်။ Takajō ဆိုသည်မှာ ဂျပန်ဘာသာဖြင့်
<a href="https://en.wikipedia.org/wiki/Falconry">"Falconer"</a> (သိမ်းငှက်ထိန်း) ဟု အဓိပ္ပာယ်ရပြီး — ၎င်းသည်
Hayabusa ၏ "ဖမ်းမိမှုများ" (ရလဒ်များ) ကို ခွဲခြမ်းစိတ်ဖြာသည်။
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

## Takajō ကို ဘာကြောင့်?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __မြန်ဆန်သော binary တစ်ခုတည်း__

    ---

    **Nim** ဖြင့် ရေးသားထားသည် — memory-safe ဖြစ်ပြီး၊ native C ကဲ့သို့ မြန်ဆန်ကာ၊ မည်သည့် OS တွင်မဆို
    standalone binary တစ်ခုတည်းဖြစ်သည်။

-   :material-file-chart:{ .lg .middle } __HTML အစီရင်ခံစာများ__

    ---

    သင်၏ Hayabusa ရလဒ်များ၏ HTML အကျဉ်းချုပ် အစီရင်ခံစာများကို ထုတ်လုပ်ပါ၊ သို့မဟုတ် ၎င်းတို့ကို အပြန်အလှန်တုံ့ပြန်နိုင်စွာ ဖြန့်ဝေပါ။

-   :material-file-tree:{ .lg .middle } __Process trees__

    ---

    Sysmon logs များမှ malicious processes များ၏ **process trees** များကို ပြန်လည်တည်ဆောက်၍ ပုံနှိပ်ဖော်ပြပါ။

-   :material-layers-triple:{ .lg .middle } __Stacking ခွဲခြမ်းစိတ်ဖြာမှု__

    ---

    command lines, DNS requests, logons, processes, services, tasks နှင့် အခြားအရာများကို stack လုပ်ကာ
    outliers များကို ဖော်ထုတ်ပါ။

-   :material-timeline-clock:{ .lg .middle } __အာရုံစိုက်ထားသော timelines များ__

    ---

    logons, USB အသုံးပြုမှု, သံသယဖြစ်ဖွယ် processes နှင့် tasks များအတွက် timelines များကို တည်ဆောက်ပြီး၊
    ကြီးမားသော CSV/JSONL timelines များကို ပိုင်းခြားပါ။

-   :material-shield-search:{ .lg .middle } __TTPs နှင့် VirusTotal__

    ---

    **MITRE ATT&CK Navigator** တွင် TTPs များကို heatmaps အဖြစ် မြင်သာအောင်ပြသပြီး၊ IPs များ,
    domains များနှင့် hashes များကို **VirusTotal** တွင် ရှာဖွေပါ။

</div>

## အမြန်လင့်များ

<div class="grid cards" markdown>

-   __:material-book-open-variant: ဒီမှာ အသစ်လား?__

    [Overview](overview/index.md) ဖြင့် စတင်ပြီးနောက်၊ Takajō ကို ဒေါင်းလုဒ်လုပ်၍ အသုံးပြုရန်
    [Getting Started](getting-started/index.md) သို့ ဆက်သွားပါ။

-   __:material-console-line: CLI နှင့် အလုပ်လုပ်နေပါသလား?__

    [Command List](commands/index.md) နှင့် အမျိုးအစားအလိုက် ကိုးကားချက်ကို လှော်လှန်ကြည့်ပါ —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), နှင့် အခြားအရာများ။

-   __:material-puzzle: ဆက်လက်လေ့လာမည်လား?__

    [Companion Projects](resources/companion-projects.md),
    [Changelog](resources/changelog.md), နှင့် မည်သို့
    [contribute](resources/contributing.md) လုပ်ရမည်ကို လေ့လာပါ။

</div>

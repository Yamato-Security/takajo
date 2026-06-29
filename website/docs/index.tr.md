---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠),
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> sonuçları için hızlı bir adli analiz aracıdır;
<a href="https://github.com/Yamato-Security">Yamato Security</a> tarafından oluşturulmuş ve
<a href="https://nim-lang.org/">Nim</a> ile yazılmıştır. Takajō, Japoncada
<a href="https://en.wikipedia.org/wiki/Falconry">"Şahinci"</a> anlamına gelir — Hayabusa'nın "avlarını" (sonuçlarını) analiz eder.
</p>

<div class="hb-cta" markdown>
[Başlayın :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Komut Referansı :material-console:](commands/index.md){ .md-button }
[GitHub'da Görüntüle :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Neden Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Tek hızlı ikili dosya__

    ---

    **Nim** ile yazılmıştır — bellek güvenli, yerel C kadar hızlı ve herhangi bir işletim sisteminde tek bağımsız bir ikili dosya.

-   :material-file-chart:{ .lg .middle } __HTML raporları__

    ---

    Hayabusa sonuçlarınızın HTML özet raporlarını oluşturun veya bunları etkileşimli olarak sunun.

-   :material-file-tree:{ .lg .middle } __Süreç ağaçları__

    ---

    Sysmon günlüklerinden kötü amaçlı süreçlerin **süreç ağaçlarını** yeniden oluşturun ve yazdırın.

-   :material-layers-triple:{ .lg .middle } __İstifleme analizi__

    ---

    Aykırı değerleri ortaya çıkarmak için komut satırlarını, DNS isteklerini, oturum açmaları, süreçleri, hizmetleri, görevleri ve daha fazlasını istifleyin.

-   :material-timeline-clock:{ .lg .middle } __Odaklanmış zaman çizelgeleri__

    ---

    Oturum açmalar, USB kullanımı, şüpheli süreçler ve görevler için zaman çizelgeleri oluşturun ve büyük CSV/JSONL zaman çizelgelerini bölün.

-   :material-shield-search:{ .lg .middle } __TTP'ler ve VirusTotal__

    ---

    TTP'leri **MITRE ATT&CK Navigator** içinde ısı haritaları olarak görselleştirin ve IP'leri, etki alanlarını ve karma değerlerini **VirusTotal** üzerinde arayın.

</div>

## Hızlı bağlantılar

<div class="grid cards" markdown>

-   __:material-book-open-variant: Buraya yeni mi geldiniz?__

    [Genel Bakış](overview/index.md) ile başlayın, ardından Takajō'yu indirmek ve çalıştırmak için
    [Başlarken](getting-started/index.md) bölümüne geçin.

-   __:material-console-line: CLI ile mi çalışıyorsunuz?__

    [Komut Listesi](commands/index.md) ve kategori bazlı referansa göz atın —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md) ve daha fazlası.

-   __:material-puzzle: Daha ileri mi gidiyorsunuz?__

    [Tamamlayıcı Projeleri](resources/companion-projects.md), [Değişiklik Günlüğünü](resources/changelog.md)
    ve nasıl [katkıda bulunulacağını](resources/contributing.md) keşfedin.

</div>

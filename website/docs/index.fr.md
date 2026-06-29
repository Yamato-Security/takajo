---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) est un analyseur forensique rapide pour les
<a href="https://github.com/Yamato-Security/hayabusa">résultats Hayabusa</a>, créé par
<a href="https://github.com/Yamato-Security">Yamato Security</a> et écrit en
<a href="https://nim-lang.org/">Nim</a>. Takajō signifie
<a href="https://en.wikipedia.org/wiki/Falconry">« Fauconnier »</a> en japonais — il analyse
les « prises » (résultats) de Hayabusa.
</p>

<div class="hb-cta" markdown>
[Commencer :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Référence des commandes :material-console:](commands/index.md){ .md-button }
[Voir sur GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Pourquoi Takajō ?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Un binaire unique et rapide__

    ---

    Écrit en **Nim** — sûr en mémoire, aussi rapide que le C natif, et un binaire
    autonome unique sur n'importe quel OS.

-   :material-file-chart:{ .lg .middle } __Rapports HTML__

    ---

    Générez des rapports de synthèse HTML de vos résultats Hayabusa, ou diffusez-les de manière interactive.

-   :material-file-tree:{ .lg .middle } __Arbres de processus__

    ---

    Reconstruisez et affichez les **arbres de processus** des processus malveillants à partir des journaux Sysmon.

-   :material-layers-triple:{ .lg .middle } __Analyse par empilement__

    ---

    Empilez les lignes de commande, les requêtes DNS, les ouvertures de session, les processus, les services, les tâches et plus encore pour
    faire ressortir les valeurs aberrantes.

-   :material-timeline-clock:{ .lg .middle } __Chronologies ciblées__

    ---

    Construisez des chronologies pour les ouvertures de session, l'utilisation des clés USB, les processus et tâches suspects, et divisez
    les grandes chronologies CSV/JSONL.

-   :material-shield-search:{ .lg .middle } __TTP et VirusTotal__

    ---

    Visualisez les TTP sous forme de cartes thermiques dans le **MITRE ATT&CK Navigator**, et recherchez des IP,
    des domaines et des hachages sur **VirusTotal**.

</div>

## Liens rapides

<div class="grid cards" markdown>

-   __:material-book-open-variant: Nouveau ici ?__

    Commencez par l'[Aperçu](overview/index.md), puis rendez-vous sur
    [Premiers pas](getting-started/index.md) pour télécharger et exécuter Takajō.

-   __:material-console-line: Vous travaillez avec la CLI ?__

    Parcourez la [Liste des commandes](commands/index.md) et la référence par catégorie —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), et plus encore.

-   __:material-puzzle: Aller plus loin ?__

    Explorez les [Projets compagnons](resources/companion-projects.md), le
    [Journal des modifications](resources/changelog.md), et comment
    [contribuer](resources/contributing.md).

</div>

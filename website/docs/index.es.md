---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) es un analizador forense rápido para
resultados de <a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a>, creado por
<a href="https://github.com/Yamato-Security">Yamato Security</a> y escrito en
<a href="https://nim-lang.org/">Nim</a>. Takajō significa
<a href="https://en.wikipedia.org/wiki/Falconry">"Halconero"</a> en japonés — analiza
las "capturas" (resultados) de Hayabusa.
</p>

<div class="hb-cta" markdown>
[Comenzar :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Referencia de comandos :material-console:](commands/index.md){ .md-button }
[Ver en GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## ¿Por qué Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Un único binario rápido__

    ---

    Escrito en **Nim** — seguro en memoria, tan rápido como C nativo y un único binario
    independiente en cualquier sistema operativo.

-   :material-file-chart:{ .lg .middle } __Informes HTML__

    ---

    Genera informes resumidos en HTML de tus resultados de Hayabusa, o sírvelos de forma interactiva.

-   :material-file-tree:{ .lg .middle } __Árboles de procesos__

    ---

    Reconstruye e imprime los **árboles de procesos** de procesos maliciosos a partir de registros de Sysmon.

-   :material-layers-triple:{ .lg .middle } __Análisis de apilamiento__

    ---

    Apila líneas de comandos, solicitudes DNS, inicios de sesión, procesos, servicios, tareas y más para
    detectar valores atípicos.

-   :material-timeline-clock:{ .lg .middle } __Cronologías enfocadas__

    ---

    Crea cronologías para inicios de sesión, uso de USB, procesos y tareas sospechosas, y divide
    cronologías CSV/JSONL grandes.

-   :material-shield-search:{ .lg .middle } __TTPs y VirusTotal__

    ---

    Visualiza los TTPs como mapas de calor en el **MITRE ATT&CK Navigator**, y consulta IPs,
    dominios y hashes en **VirusTotal**.

</div>

## Enlaces rápidos

<div class="grid cards" markdown>

-   __:material-book-open-variant: ¿Nuevo aquí?__

    Comienza con la [Descripción general](overview/index.md), luego dirígete a
    [Primeros pasos](getting-started/index.md) para descargar y ejecutar Takajō.

-   __:material-console-line: ¿Trabajando con la CLI?__

    Explora la [Lista de comandos](commands/index.md) y la referencia por categoría —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), y más.

-   __:material-puzzle: ¿Quieres ir más allá?__

    Explora los [Proyectos complementarios](resources/companion-projects.md), el
    [Registro de cambios](resources/changelog.md), y cómo
    [contribuir](resources/contributing.md).

</div>

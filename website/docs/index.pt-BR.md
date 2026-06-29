---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) é um analisador forense rápido para
<a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> resultados, criado por
<a href="https://github.com/Yamato-Security">Yamato Security</a> e escrito em
<a href="https://nim-lang.org/">Nim</a>. Takajō significa
<a href="https://en.wikipedia.org/wiki/Falconry">"Falcoeiro"</a> em japonês — ele analisa
as "capturas" (resultados) do Hayabusa.
</p>

<div class="hb-cta" markdown>
[Comece Agora :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[Referência de Comandos :material-console:](commands/index.md){ .md-button }
[Ver no GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
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

## Por que Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __Binário único e rápido__

    ---

    Escrito em **Nim** — seguro em memória, tão rápido quanto C nativo, e um único
    binário autônomo em qualquer sistema operacional.

-   :material-file-chart:{ .lg .middle } __Relatórios HTML__

    ---

    Gere relatórios resumidos em HTML dos seus resultados do Hayabusa, ou os disponibilize de forma interativa.

-   :material-file-tree:{ .lg .middle } __Árvores de processos__

    ---

    Reconstrua e imprima as **árvores de processos** de processos maliciosos a partir de logs do Sysmon.

-   :material-layers-triple:{ .lg .middle } __Análise de empilhamento__

    ---

    Empilhe linhas de comando, requisições DNS, logons, processos, serviços, tarefas e mais para
    revelar valores atípicos.

-   :material-timeline-clock:{ .lg .middle } __Linhas do tempo focadas__

    ---

    Crie linhas do tempo para logons, uso de USB, processos e tarefas suspeitos, e divida
    grandes linhas do tempo em CSV/JSONL.

-   :material-shield-search:{ .lg .middle } __TTPs e VirusTotal__

    ---

    Visualize TTPs como mapas de calor no **MITRE ATT&CK Navigator**, e consulte IPs,
    domínios e hashes no **VirusTotal**.

</div>

## Links rápidos

<div class="grid cards" markdown>

-   __:material-book-open-variant: Novo por aqui?__

    Comece com a [Visão Geral](overview/index.md), depois siga para
    [Comece Agora](getting-started/index.md) para baixar e executar o Takajō.

-   __:material-console-line: Trabalhando com a CLI?__

    Navegue pela [Lista de Comandos](commands/index.md) e a referência por categoria —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md), e mais.

-   __:material-puzzle: Indo além?__

    Explore os [Projetos Complementares](resources/companion-projects.md), o
    [Changelog](resources/changelog.md), e como
    [contribuir](resources/contributing.md).

</div>

# Comandos de TTP

## Comando `ttp-summary`

Este comando resume as táticas e técnicas encontradas em cada computador de acordo com os TTPs do MITRE ATT&CK definidos no campo `tags` das regras sigma.

* Entrada: JSONL
* Perfil: Um perfil que exibe os campos `%MitreTactics%` e `%MitreTags%`. (Ex.: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Saída: Terminal ou CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de linha do tempo JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados.
- `-q, --quiet`: não exibir o logotipo. (padrão: `false`)

### Exemplos do comando `ttp-summary`

Prepare a linha do tempo JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Exiba o resumo de TTP no terminal:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Salve os resultados em um arquivo CSV:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### Captura de tela do `ttp-summary`

![ttp-summary](../assets/screenshots/ttp-summary.png)

## Comando `ttp-visualize`

Este comando extrai os TTPs e cria um arquivo JSON para visualização no [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Entrada: JSONL
* Perfil: Um perfil que exibe os campos `%MitreTactics%` e `%MitreTags%`. (Ex.: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Saída: JSON

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de linha do tempo JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-o, --output <JSON-FILE>`: o arquivo JSON no qual salvar os resultados. (padrão: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: não exibir o logotipo. (padrão: `false`)

### Exemplos do comando `ttp-visualize`

Prepare a linha do tempo JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Extraia os TTPs e salve em `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

Abra [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), clique em `Open Existing Layer` e envie o arquivo JSON salvo.

### Captura de tela do `ttp-visualize`

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## Comando `ttp-visualize-sigma`

Este comando extrai os TTPs do Sigma e cria um arquivo JSON para visualização no [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Entrada: diretório de regras Sigma
* Saída: JSON

Opções obrigatórias:

- `-r, --ruleDir <SIGMA-DIR>`: diretório de regras Sigma

Opções:

- `-o, --output <JSON-FILE>`: o arquivo JSON no qual salvar os resultados. (padrão: `mitre-attack-navigator.json`)
- `-q, --quiet`: não exibir o logotipo. (padrão: `false`)

### Exemplos do comando `ttp-visualize-sigma`

Clone o repositório do Sigma:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Extraia os TTPs do Sigma e salve em `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

# Comandos HTML

## Comando `html-report`

Cria relatórios de resumo em HTML para regras e computadores com detecções.
Este comando primeiro cria um arquivo de banco de dados DuckDB indexado (padrão) ou um arquivo de banco de dados SQLite a fim de realizar consultas rápidas nos dados necessários para criar os relatórios de resumo.

* Entrada: JSONL
* Perfil: Qualquer perfil verbose
* Saída: Relatórios de resumo HTML individuais com base no nome do computador, bem como uma página principal `index.html`

Opções obrigatórias:

- `-o, --output`: nome do diretório do relatório html
- `-r, --rulepath`: caminho para o diretório de regras do Hayabusa
- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo ou diretório de timeline JSONL do Hayabusa

Opções:

- `-C, --clobber`: sobrescreve o arquivo de banco de dados ao salvar (padrão: `false`)
- `-q, --quiet`: não exibe o banner de inicialização (padrão: `false`)
- `-s, --dboutput`: salva os resultados em um arquivo de banco de dados (padrão: `html-report.duckdb` ou `html-report.sqlite` com `--sqlite`)
- `--skipProgressBar`: não exibe a barra de progresso (padrão: `false`)
- `--sqlite`: usa o backend SQLite em vez do DuckDB (padrão: `false`)

### Exemplo do comando `html-report`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

ou

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Crie os relatórios de resumo HTML:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### Capturas de tela do `html-report`

#### Resumo de Regras

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Resumo de Computadores

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Lista de Regras

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## Comando `html-server`

Cria um servidor web dinâmico para visualizar relatórios de resumo em HTML.
Este comando primeiro cria um arquivo de banco de dados DuckDB indexado (padrão) ou um arquivo de banco de dados SQLite a fim de realizar consultas rápidas nos dados necessários para criar os relatórios de resumo.
É semelhante ao comando `html-report`, mas é mais escalável e permite filtrar por datas e regras.

* Entrada: JSONL
* Perfil: Qualquer perfil verbose
* Saída: Por padrão, escutará em `http://localhost:8823`

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo ou diretório de timeline JSONL do Hayabusa

Opções:

- `-C, --clobber`: sobrescreve o arquivo de banco de dados ao salvar (padrão: `false`)
- `-p, --port`: número da porta do servidor web (padrão: `8823`)
- `-q, --quiet`: não exibe o banner de inicialização (padrão: `false`)
- `-r, --rulepath`: caminho para o diretório de regras do Hayabusa (isto é opcional, mas necessário para criar links corretos para os arquivos de regras)
- `-s, --dboutput`: salva os resultados em um arquivo de banco de dados (padrão: `html-report.duckdb` ou `html-report.sqlite` com `--sqlite`)
- `--skipProgressBar`: não exibe a barra de progresso (padrão: `false`)
- `--sqlite`: usa o backend SQLite em vez do DuckDB (padrão: `false`)

### Exemplo do comando `html-report`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

ou

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Inicie o servidor web:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### Capturas de tela do `html-server`

#### Lista de Regras

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Resumo de Computadores

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Filtragem de Regras

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Filtragem de Regras

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

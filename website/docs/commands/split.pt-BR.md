# Comandos de Divisão

## Comando `split-csv-timeline`

Divide uma linha do tempo CSV grande em outras menores com base no nome do computador.

* Entrada: CSV sem múltiplas linhas
* Perfil: Qualquer
* Saída: Múltiplos arquivos CSV

Opções obrigatórias:

- `-t, --timeline <CSV-FILE>`: linha do tempo CSV criada pelo Hayabusa.

Opções:

- `-m, --makeMultiline`: exibe os campos em múltiplas linhas. (padrão: `false`)
- `-o, --output <DIR>`: diretório onde salvar os arquivos CSV. (padrão: `output`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `split-csv-timeline`

Prepare a linha do tempo CSV com o Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Divide a única linha do tempo CSV em múltiplas linhas do tempo CSV no diretório padrão `output`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Separe as informações dos campos com caracteres de nova linha para criar entradas em múltiplas linhas e salve no diretório `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## Comando `split-json-timeline`

Divide uma linha do tempo JSONL grande em outras menores com base no nome do computador.

* Entrada: JSONL
* Perfil: Qualquer
* Saída: Múltiplos arquivos JSONL

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo ou diretório de linha do tempo JSONL do Hayabusa.

Opções:

- `-o, --output <DIR>`: diretório onde salvar os arquivos JSONL. (padrão: `output`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `split-json-timeline`

Prepare a linha do tempo JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Divide a única linha do tempo JSONL em múltiplas linhas do tempo JSONL no diretório padrão `output`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Salve no diretório `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

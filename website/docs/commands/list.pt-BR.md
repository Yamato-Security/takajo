# Comandos de Listagem

## Comando `list-domains`

Cria uma lista de domínios únicos para ser usada com `vt-domain-lookup`.
Atualmente, ele verificará apenas os domínios consultados nos logs do Sysmon EID 22, mas será atualizado para oferecer suporte aos logs internos do Windows DNS Client e Server.

* Entrada: JSONL
* Perfil: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Arquivo de texto

Opções obrigatórias:

 - `-o, --output <TXT-FILE>`: salva os resultados em um arquivo de texto.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo ou diretório de timeline JSONL do Hayabusa.

Opções:

 - `-s, --includeSubdomains`: inclui subdomínios (padrão: `false`)
 - `-w, --includeWorkstations`: inclui nomes de estações de trabalho locais (padrão: `false`)
 - `-q, --quiet`: não exibe o logo (padrão: `false`)
 - `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `list-domains`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Salve os resultados em um arquivo de texto:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Inclua subdomínios:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## Comando `list-hashes`

Cria uma lista de hashes de processos para ser usada com vt-hash-lookup (entrada: JSONL, perfil: standard)

* Entrada: JSONL
* Perfil: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Arquivo de texto

Opções obrigatórias:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL
 - `-o, --output <BASE-NAME>`: especifica o nome base no qual salvar os resultados em texto.

Opções:

 - `-l, --level`: especifica o nível mínimo. (padrão: `high`)
 - `-q, --quiet`: não exibe o logo. (padrão: `false`)
 - `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `list-hashes`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Salve os resultados em um arquivo de texto diferente para cada tipo de hash:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Por exemplo, se hashes `MD5`, `SHA1` e `IMPHASH` estiverem armazenados nos logs do sysmon, então os seguintes arquivos serão criados: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## Comando `list-ip-addresses`

Cria uma lista de endereços IP de destino e/ou origem únicos para ser usada com `vt-ip-lookup`.
Ele extrairá os campos `TgtIP` para os endereços IP de destino e os campos `SrcIP` para os endereços IP de origem em todos os resultados e gerará apenas os endereços IP únicos em um arquivo de texto.

* Entrada: JSONL
* Perfil: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Arquivo de texto

Opções obrigatórias:

 - `-o, --output <TXT-FILE>`: salva os resultados em um arquivo de texto.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo ou diretório de timeline JSONL do Hayabusa.

Opções:

 - `-i, --inbound`: inclui o tráfego de entrada. (padrão: `true`)
 - `-O, --outbound`: inclui o tráfego de saída. (padrão: `true`)
 - `-p, --privateIp`: inclui endereços IP privados (padrão: `false`)
 - `-q, --quiet`: não exibe o logo. (padrão: `false`)
 - `-s, --skipProgressBar`: "não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `list-ip-addresses`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Salve os resultados em um arquivo de texto:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Exclua o tráfego de entrada:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Inclua endereços IP privados:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## Comando `list-undetected-evtx`

Lista todos os arquivos `.evtx` para os quais o Hayabusa não tinha uma regra de detecção.
Isso serve para ser usado em arquivos evtx de exemplo que contêm evidências de atividade maliciosa, como os arquivos evtx de exemplo no repositório [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx).

* Entrada: CSV
* Perfil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Primeiro você precisa executar o Hayabusa com um perfil que salve as informações da coluna `%EvtxFile%` e salvar os resultados em uma timeline CSV.
  > Você pode ver quais colunas o Hayabusa salva de acordo com os diferentes perfis [aqui](https://github.com/Yamato-Security/hayabusa#profiles).
* Saída: Terminal ou arquivo de texto

Opções obrigatórias:

- `-e, --evtx-dir <EVTX-DIR>`: O diretório dos arquivos `.evtx` que você escaneou com o Hayabusa.
- `-t, --timeline <CSV-FILE>`: timeline CSV do Hayabusa.

Opções:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: especifica um nome de coluna personalizado para a coluna evtx. (padrão: o padrão do Hayabusa de `EvtxFile`)
- `-o, --output <TXT-FILE>`: salva os resultados em um arquivo de texto. (padrão: saída na tela)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `list-undetected-evtx`

Prepare a timeline CSV com o Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Exiba os resultados na tela:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Salve os resultados em um arquivo de texto:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## Comando `list-unused-rules`

Lista todas as regras de detecção `.yml` que não detectaram nada.
Isso é útil para ajudar a determinar a confiabilidade das regras.
Ou seja, quais regras são conhecidas por encontrar atividade maliciosa e quais ainda não foram testadas e precisam de arquivos `.evtx` de exemplo.

* Entrada: CSV
* Perfil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Primeiro você precisa executar o Hayabusa com um perfil que salve as informações da coluna `%RuleFile%` e salvar os resultados em uma timeline CSV.
  > Você pode ver quais colunas o Hayabusa salva de acordo com os diferentes perfis [aqui](https://github.com/Yamato-Security/hayabusa#profiles).
* Saída: Terminal ou arquivo de texto

Opções obrigatórias:

- `-r, --rules-dir <DIR>`: o diretório dos arquivos de regras `.yml` que você usou com o Hayabusa.
- `-t, --timeline <CSV-FILE>`: timeline CSV criada pelo Hayabusa.

Opções:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: especifica um nome de coluna personalizado para a coluna do arquivo de regra. (padrão: o padrão do Hayabusa de `RuleFile`)
- `-o, --output <TXT-FILE>`: salva os resultados em um arquivo de texto. (padrão: saída na tela)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `list-unused-rules`

Prepare a timeline CSV com o Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Exiba os resultados na tela:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Salve os resultados em um arquivo de texto:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

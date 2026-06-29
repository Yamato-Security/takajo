# Comandos de Empilhamento (Stack)

## Comando `stack-cmdlines`

Este comando empilha as linhas de comando executadas extraindo informações dos eventos `Sysmon 1` e `Security 4688`.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-y, --ignoreSysmon`: exclui os eventos Sysmon 1 (padrão: `false`)
- `-e, --ignoreSecurity`: exclui os eventos Security 4688 (padrão: `false`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-cmdlines`

Saída para o terminal:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## Comando `stack-computers`

Este comando empilha os nomes de host dos computadores de acordo com o campo `Computer`.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-c, --sourceComputers`: empilha os computadores de origem em vez dos computadores de destino (padrão: false)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-computers`

Saída para o terminal:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## Comando `stack-dns`

Este comando empilha as consultas e respostas de DNS dos eventos Sysmon 22.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-dns`

Saída para o terminal:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## Comando `stack-ip-addresses`

Este comando empilha os endereços IP de destino (campo `TgtIP`) ou os endereços IP de origem (campo `SrcIP`).

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-a, --targetIpAddresses`: empilha os endereços IP de destino em vez dos endereços IP de origem (padrão: `false`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-ip-addresses`

Saída para o terminal:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## Comando `stack-logons`

Cria uma lista de logons de acordo com `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
Por padrão, os resultados são filtrados quando o endereço IP de origem é um endereço IP local.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --localSrcIpAddresses`: inclui os resultados quando o endereço IP de origem é local.
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-logons`

Executar com as configurações padrão:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Incluir logons locais:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## Comando `stack-processes`

Este comando empilha os processos executados dos eventos Sysmon 1 e Security 4688.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `low`)
- `-y, --ignoreSysmon`: exclui os eventos Sysmon 1 (padrão: `false`)
- `-e, --ignoreSecurity`: exclui os eventos Security 4688 (padrão: `false`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-processes`

Saída para o terminal:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## Comando `stack-services`

Este comando empilha os nomes e caminhos de serviços dos eventos System 7040 e Security 4697.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-y, --ignoreSystem`: exclui os eventos System 7040 (padrão: `false`)
- `-e, --ignoreSecurity`: exclui os eventos Security 4697 (padrão: `false`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-services`

Saída para o terminal:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## Comando `stack-tasks`

Este comando empilha as novas tarefas agendadas dos eventos Security 4698 e analisa o conteúdo XML da tarefa.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-tasks`

Saída para o terminal:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## Comando `stack-users`

Este comando empilha os usuários de destino (campo `TgtUser` (padrão)) ou os usuários de origem (campo `SrcUser`) em qualquer evento que tenha esses campos, além de exibir as informações de alerta.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-s, --sourceUsers`: empilha os usuários de origem em vez dos usuários de destino (padrão: false)
- `-c, --filterComputerAccounts`: filtra as contas de computador (padrão: true)
- `-f, --filterSystemAccounts`: filtra as contas de sistema (padrão: true)
- `-l, --level`: especifica o nível mínimo de alerta (padrão: `informational`)
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `stack-users`

Saída para o terminal:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

# Comandos de Timeline

## Comando `timeline-logon`

Este comando extrai informações dos seguintes eventos de logon, normaliza os campos e salva os resultados em um arquivo CSV:

- `4624` - Logon bem-sucedido
- `4625` - Logon malsucedido
- `4634` - Logoff de conta
- `4647` - Logoff iniciado pelo usuário
- `4648` - Logon explícito
- `4672` - Logon de administrador

Isso facilita a detecção de movimentação lateral, adivinhação/spraying de senhas, escalonamento de privilégios, etc...

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: CSV

Opções obrigatórias:

- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-c, --calculateElapsedTime`: calcula o tempo decorrido para logons bem-sucedidos. (padrão: `true`)
- `-l, --outputLogoffEvents`: gera eventos de logoff como entradas separadas. (padrão: `false`)
- `-a, --outputAdminLogonEvents`: gera eventos de logon de administrador como entradas separadas. (padrão: `false`)
- `-q, --quiet`: não exibe o logotipo. (padrão: `false`)

### Exemplos do comando `timeline-logon`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Salve a timeline de logon em um arquivo CSV:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### Captura de tela do `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## Comando `timeline-partition-diagnostic`

Cria uma timeline CSV de eventos de diagnóstico de partição analisando os arquivos `Microsoft-Windows-Partition%4Diagnostic.evtx` do Windows 10 e reportando informações sobre todos os dispositivos conectados e seus Números de Série de Volume, tanto os atualmente presentes no dispositivo quanto os que existiram anteriormente.
Este processo é baseado na ferramenta [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Entrada: JSONL
* Profile: Qualquer um
* Saída: Terminal ou CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados.
- `-q, --quiet`: não exibe o logotipo. (padrão: `false`)

### Exemplos do comando `timeline-partition-diagnostic`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Crie uma timeline CSV dos dispositivos conectados:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## Comando `timeline-suspicious-processes`

Cria uma timeline CSV de processos suspeitos.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL
- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados (padrão: `stdout`)

Opções:

- `-l, --level <LEVEL>`: especifica o nível mínimo de alerta (padrão: `high`)
- `-q, --quiet`: não exibe o logotipo. (padrão: `false`)

### Exemplos do comando `timeline-suspicious-processes`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Busque processos que tiveram um nível de alerta `high` ou superior e exiba os resultados na tela:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Busque processos que tiveram um nível de alerta `low` ou superior e exiba os resultados na tela:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Salve os resultados em um arquivo CSV:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### Captura de tela do `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## Comando `timeline-tasks`

Este comando agrupa novas tarefas agendadas a partir de eventos Security 4698 e extrai o conteúdo XML da tarefa.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo CSV

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-o, --output <CSV-FILE>`: o arquivo CSV no qual salvar os resultados.
- `-q, --quiet`: não exibe o logotipo. (padrão: `false`)

### Exemplos do comando `timeline-tasks`

Saída para o terminal:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Salvar em CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

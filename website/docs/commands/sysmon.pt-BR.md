# Comandos do Sysmon

## Comando `sysmon-process-tree`

Exibe a árvore de processos de um determinado processo, como um processo suspeito ou malicioso.

* Entrada: JSONL
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Terminal ou arquivo de texto

Opções obrigatórias:

- `-p, --processGuid <Process GUID>`: GUID de processo do sysmon
- `-t, --timeline <JSONL-FILE-OR-DIR>`: arquivo de timeline JSONL do Hayabusa ou diretório de arquivos JSONL

Opções:

- `-o, --output <TXT-FILE>`: um arquivo de texto para salvar os resultados.
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `sysmon-process-tree`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Salve os resultados em um arquivo de texto:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### Captura de tela do `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

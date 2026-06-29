# Comandos de Extração

## Comando `extract-scriptblocks`

Extrai e remonta logs de blocos de script do PowerShell EID 4104.

> Nota: Os scripts do PowerShell são melhor visualizados como arquivos `.ps1` com realce de sintaxe de código, mas usamos a extensão `.txt` para evitar qualquer execução acidental de código malicioso.

* Entrada: JSONL
* Perfil: Qualquer
* Saída: Terminal e diretório de Scripts do PowerShell

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Arquivo ou diretório de timeline JSONL do Hayabusa

Opções:

 - `-l, --level`: especifica o nível mínimo de alerta (padrão: `low`)
 - `-o, --output`: diretório de saída (padrão: `scriptblock-logs`)
 - `-q, --quiet`: não exibe o banner de inicialização (padrão: `false`)
 - `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplo do comando `extract-scriptblocks`

Prepare a timeline JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Extraia os logs de blocos de script do PowerShell EID 4104 para o diretório `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### Captura de tela do `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

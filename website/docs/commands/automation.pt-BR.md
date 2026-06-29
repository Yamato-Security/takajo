# Comandos de Automação

## Comando `automagic`

Executa automaticamente o maior número possível de comandos e gera os resultados em uma nova pasta

> Nota: Você deve usar o perfil `verbose` ou `super-verbose` para utilizar todos os comandos.

* Entrada: Arquivo JSONL ou diretório de arquivos JSONL
* Perfil: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: Uma nova pasta com todos os resultados em arquivos diferentes

Opções obrigatórias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Arquivo ou diretório de linha do tempo JSONL do Hayabusa.

Opções:

- `-d, --displayTable`: exibe a tabela de resultados (padrão: `false`)
- `-l, --level`: especifica o nível mínimo de alerta (padrão: `low`)
- `-o, --output`: diretório de saída (padrão: `case-1`)
- `-q, --quiet`: não exibe o banner de inicialização (padrão: `false`)
- `-s, --skipProgressBar`: não exibe a barra de progresso (padrão: `false`)

### Exemplos do comando `automagic`

Prepare a linha do tempo JSONL com o Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Execute o maior número possível de comandos do Takajo e salve os resultados na pasta `case-1`:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Execute o maior número possível de comandos do Takajo no diretório `hayabusa-results` e salve os resultados na pasta `case-1`:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

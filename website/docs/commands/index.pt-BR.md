# Lista de Comandos

## Comandos de Automação
* `automagic`: executa automaticamente o maior número possível de comandos e gera os resultados em uma nova pasta

## Comandos de Extração
* `extract-scriptblocks`: extrai e remonta os logs de bloco de script do PowerShell EID 4104

## Comandos de HTML
* `html-report`: cria relatórios resumidos em HTML estático
* `html-server`: cria um servidor web dinâmico para visualizar relatórios resumidos em HTML

## Comandos de Listagem
* `list-domains`: cria uma lista de domínios únicos para ser usada com `vt-domain-lookup`
* `list-hashes`: cria uma lista de hashes de processos para ser usada com `vt-hash-lookup`
* `list-ip-addresses`: cria uma lista de endereços IP de destino e/ou de origem únicos para ser usada com `vt-ip-lookup`
* `list-undetected-evtx`: cria uma lista de arquivos evtx não detectados
* `list-unused-rules`: cria uma lista de regras de detecção não utilizadas

## Comandos de Divisão
* `split-csv-timeline`: divide uma grande linha do tempo em CSV em outras menores com base no nome do computador
* `split-json-timeline`: divide uma grande linha do tempo em JSONL em outras menores com base no nome do computador

## Comandos de Empilhamento
* `stack-cmdlines`: empilha as linhas de comando executadas
* `stack-computers`: empilha computadores
* `stack-dns`: empilha consultas e respostas DNS
* `stack-ip-addresses`: empilha endereços IP de destino (campo `TgtIP`) ou endereços IP de origem (campo `SrcIP`)
* `stack-logons`: empilha logons por usuário de destino, computador de destino, endereço IP de origem e computador de origem
* `stack-processes`: empilha os processos executados
* `stack-services`: empilha nomes e caminhos de serviços a partir dos eventos `System 7040` e `Security 4697`
* `stack-tasks`: empilha novas tarefas agendadas a partir dos eventos `Security 4698` e analisa o conteúdo XML da tarefa
* `stack-users`: empilha usuários de destino (campo `TgtUser`) ou usuários de origem (campo `SrcUser`)

## Comandos do Sysmon
* `sysmon-process-tree`: gera a árvore de processos de um determinado processo

## Comandos de Linha do Tempo
* `timeline-logon`: cria uma linha do tempo em CSV de eventos de logon
* `timeline-partition-diagnostic`: cria uma linha do tempo em CSV de eventos de diagnóstico de partição
* `timeline-suspicious-processes`: cria uma linha do tempo em CSV de processos suspeitos
* `timeline-tasks`: cria uma linha do tempo em CSV de tarefas agendadas

## Comandos de TTP
* `ttp-summary`: resume as táticas e técnicas encontradas em cada computador
* `ttp-visualize`: extrai TTPs e cria um arquivo JSON para visualização no MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: extrai TTPs das regras Sigma e cria um arquivo JSON para visualização no MITRE ATT&CK Navigator

## Comandos do VirusTotal
* `vt-domain-lookup`: consulta uma lista de domínios no VirusTotal e reporta os maliciosos
* `vt-hash-lookup`: consulta uma lista de hashes no VirusTotal e reporta os maliciosos
* `vt-ip-lookup`: consulta uma lista de endereços IP no VirusTotal e reporta os maliciosos

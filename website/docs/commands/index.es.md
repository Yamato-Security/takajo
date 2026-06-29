# Lista de comandos

## Comandos de automatización
* `automagic`: ejecuta automáticamente tantos comandos como sea posible y envía los resultados a una nueva carpeta

## Comandos de extracción
* `extract-scriptblocks`: extrae y reensambla los registros de bloques de script de PowerShell EID 4104

## Comandos HTML
* `html-report`: crea informes resumen HTML estáticos
* `html-server`: crea un servidor web dinámico para ver informes resumen HTML

## Comandos de listas
* `list-domains`: crea una lista de dominios únicos para usar con `vt-domain-lookup`
* `list-hashes`: crea una lista de hashes de procesos para usar con `vt-hash-lookup`
* `list-ip-addresses`: crea una lista de direcciones IP de destino y/o origen únicas para usar con `vt-ip-lookup`
* `list-undetected-evtx`: crea una lista de archivos evtx no detectados
* `list-unused-rules`: crea una lista de reglas de detección no utilizadas

## Comandos de división
* `split-csv-timeline`: divide una línea de tiempo CSV grande en otras más pequeñas según el nombre del equipo
* `split-json-timeline`: divide una línea de tiempo JSONL grande en otras más pequeñas según el nombre del equipo

## Comandos de apilamiento
* `stack-cmdlines`: apila las líneas de comandos ejecutadas
* `stack-computers`: apila equipos
* `stack-dns`: apila las consultas y respuestas de DNS
* `stack-ip-addresses`: apila las direcciones IP de destino (campo `TgtIP`) o las direcciones IP de origen (campo `SrcIP`)
* `stack-logons`: apila los inicios de sesión por usuario de destino, equipo de destino, dirección IP de origen y equipo de origen
* `stack-processes`: apila los procesos ejecutados
* `stack-services`: apila los nombres y rutas de servicios de los eventos `System 7040` y `Security 4697`
* `stack-tasks`: apila las nuevas tareas programadas de los eventos `Security 4698` y analiza el contenido XML de la tarea
* `stack-users`: apila los usuarios de destino (campo `TgtUser`) o los usuarios de origen (campo `SrcUser`)

## Comandos de Sysmon
* `sysmon-process-tree`: muestra el árbol de procesos de un proceso determinado

## Comandos de línea de tiempo
* `timeline-logon`: crea una línea de tiempo CSV de eventos de inicio de sesión
* `timeline-partition-diagnostic`: crea una línea de tiempo CSV de eventos de diagnóstico de particiones
* `timeline-suspicious-processes`: crea una línea de tiempo CSV de procesos sospechosos
* `timeline-tasks`: crea una línea de tiempo CSV de tareas programadas

## Comandos TTP
* `ttp-summary`: resume las tácticas y técnicas encontradas en cada equipo
* `ttp-visualize`: extrae las TTP y crea un archivo JSON para visualizar en MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: extrae las TTP de las reglas Sigma y crea un archivo JSON para visualizar en MITRE ATT&CK Navigator

## Comandos de VirusTotal
* `vt-domain-lookup`: busca una lista de dominios en VirusTotal e informa sobre los maliciosos
* `vt-hash-lookup`: busca una lista de hashes en VirusTotal e informa sobre los maliciosos
* `vt-ip-lookup`: busca una lista de direcciones IP en VirusTotal e informa sobre las maliciosas

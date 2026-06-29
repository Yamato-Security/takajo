# Comandos de Timeline

## Comando `timeline-logon`

Este comando extrae información de los siguientes eventos de inicio de sesión, normaliza los campos y guarda los resultados en un archivo CSV:

- `4624` - Inicio de sesión exitoso
- `4625` - Inicio de sesión fallido
- `4634` - Cierre de sesión de cuenta
- `4647` - Cierre de sesión iniciado por el usuario
- `4648` - Inicio de sesión explícito
- `4672` - Inicio de sesión de administrador

Esto facilita la detección de movimiento lateral, adivinación/rociado de contraseñas, escalada de privilegios, etc...

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: CSV

Opciones requeridas:

- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de timeline JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-c, --calculateElapsedTime`: calcula el tiempo transcurrido de los inicios de sesión exitosos. (predeterminado: `true`)
- `-l, --outputLogoffEvents`: genera los eventos de cierre de sesión como entradas separadas. (predeterminado: `false`)
- `-a, --outputAdminLogonEvents`: genera los eventos de inicio de sesión de administrador como entradas separadas. (predeterminado: `false`)
- `-q, --quiet`: no muestra el logo. (predeterminado: `false`)

### Ejemplos del comando `timeline-logon`

Prepara el timeline JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Guarda el timeline de inicios de sesión en un archivo CSV:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### Captura de pantalla de `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## Comando `timeline-partition-diagnostic`

Crea un timeline CSV de eventos de diagnóstico de particiones analizando los archivos `Microsoft-Windows-Partition%4Diagnostic.evtx` de Windows 10 e informando sobre todos los dispositivos conectados y sus Números de Serie de Volumen, tanto los presentes actualmente en el dispositivo como los que existieron previamente.
Este proceso se basa en la herramienta [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Entrada: JSONL
* Perfil: Cualquiera
* Salida: Terminal o CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de timeline JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados.
- `-q, --quiet`: no muestra el logo. (predeterminado: `false`)

### Ejemplos del comando `timeline-partition-diagnostic`

Prepara el timeline JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Crea un timeline CSV de los dispositivos conectados:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## Comando `timeline-suspicious-processes`

Crea un timeline CSV de procesos sospechosos.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de timeline JSONL de Hayabusa o directorio de archivos JSONL
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)

Opciones:

- `-l, --level <LEVEL>`: especifica el nivel mínimo de alerta (predeterminado: `high`)
- `-q, --quiet`: no muestra el logo. (predeterminado: `false`)

### Ejemplos del comando `timeline-suspicious-processes`

Prepara el timeline JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Busca procesos que tuvieron un nivel de alerta de `high` o superior y muestra los resultados en pantalla:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Busca procesos que tuvieron un nivel de alerta de `low` o superior y muestra los resultados en pantalla:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Guarda los resultados en un archivo CSV:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### Captura de pantalla de `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## Comando `timeline-tasks`

Este comando apilará las nuevas tareas programadas de los eventos Security 4698 y extraerá el contenido XML de las tareas.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de timeline JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados.
- `-q, --quiet`: no muestra el logo. (predeterminado: `false`)

### Ejemplos del comando `timeline-tasks`

Salida a la terminal:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

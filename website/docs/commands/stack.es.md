# Comandos Stack

## Comando `stack-cmdlines`

Este comando apilará las líneas de comando ejecutadas extrayendo información de los eventos `Sysmon 1` y `Security 4688`.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-y, --ignoreSysmon`: excluye los eventos Sysmon 1 (predeterminado: `false`)
- `-e, --ignoreSecurity`: excluye los eventos Security 4688 (predeterminado: `false`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-cmdlines`

Salida a terminal:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## Comando `stack-computers`

Este comando apilará los nombres de host de los equipos según el campo `Computer`.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-c, --sourceComputers`: apila los equipos de origen en lugar de los equipos de destino (predeterminado: false)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-computers`

Salida a terminal:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## Comando `stack-dns`

Este comando apilará las consultas y respuestas DNS de los eventos Sysmon 22.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-dns`

Salida a terminal:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## Comando `stack-ip-addresses`

Este comando apilará las direcciones IP de destino (campo `TgtIP`) o las direcciones IP de origen (campo `SrcIP`).

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-a, --targetIpAddresses`: apila las direcciones IP de destino en lugar de las direcciones IP de origen (predeterminado: `false`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-ip-addresses`

Salida a terminal:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## Comando `stack-logons`

Crea una lista de inicios de sesión según `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
Los resultados se filtran de forma predeterminada cuando la dirección IP de origen es una dirección IP local.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --localSrcIpAddresses`: incluye los resultados cuando la dirección IP de origen es local.
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-logons`

Ejecutar con la configuración predeterminada:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Incluir inicios de sesión locales:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## Comando `stack-processes`

Este comando apilará los procesos ejecutados de los eventos Sysmon 1 y Security 4688.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `low`)
- `-y, --ignoreSysmon`: excluye los eventos Sysmon 1 (predeterminado: `false`)
- `-e, --ignoreSecurity`: excluye los eventos Security 4688 (predeterminado: `false`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-processes`

Salida a terminal:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## Comando `stack-services`

Este comando apilará los nombres y rutas de servicios de los eventos System 7040 y Security 4697.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-y, --ignoreSystem`: excluye los eventos System 7040 (predeterminado: `false`)
- `-e, --ignoreSecurity`: excluye los eventos Security 4697 (predeterminado: `false`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-services`

Salida a terminal:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## Comando `stack-tasks`

Este comando apilará las nuevas tareas programadas de los eventos Security 4698 y analizará el contenido XML de la tarea.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-tasks`

Salida a terminal:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## Comando `stack-users`

Este comando apilará los usuarios de destino (campo `TgtUser` (predeterminado)) o los usuarios de origen (campo `SrcUser`) en cualquier evento que tenga esos campos, además de mostrar información de alerta.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo CSV

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-s, --sourceUsers`: apila los usuarios de origen en lugar de los usuarios de destino (predeterminado: false)
- `-c, --filterComputerAccounts`: filtra las cuentas de equipo (predeterminado: true)
- `-f, --filterSystemAccounts`: filtra las cuentas del sistema (predeterminado: true)
- `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `informational`)
- `-o, --output <CSV-FILE>`: el archivo CSV donde guardar los resultados (predeterminado: `stdout`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)
- `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `stack-users`

Salida a terminal:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

Guardar en CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

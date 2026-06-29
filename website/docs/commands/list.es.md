# Comandos de listado

## Comando `list-domains`

Crea una lista de dominios únicos para usar con `vt-domain-lookup`.
Actualmente solo comprobará los dominios consultados en los registros de Sysmon EID 22, pero se actualizará para admitir los registros integrados de cliente y servidor DNS de Windows.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Archivo de texto

Opciones requeridas:

 - `-o, --output <TXT-FILE>`: guarda los resultados en un archivo de texto.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo o directorio de línea de tiempo JSONL de Hayabusa.

Opciones:

 - `-s, --includeSubdomains`: incluir subdominios (predeterminado: `false`)
 - `-w, --includeWorkstations`: incluir nombres de estaciones de trabajo locales (predeterminado: `false`)
 - `-q, --quiet`: no mostrar el logotipo (predeterminado: `false`)
 - `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `list-domains`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Guarda los resultados en un archivo de texto:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Incluir subdominios:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## Comando `list-hashes`

Crea una lista de hashes de procesos para usar con vt-hash-lookup (entrada: JSONL, perfil: standard)

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Archivo de texto

Opciones requeridas:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo o directorio de archivos JSONL de línea de tiempo JSONL de Hayabusa
 - `-o, --output <BASE-NAME>`: especifica el nombre base con el que guardar los resultados de texto.

Opciones:

 - `-l, --level`: especifica el nivel mínimo. (predeterminado: `high`)
 - `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)
 - `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `list-hashes`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Guarda los resultados en un archivo de texto diferente para cada tipo de hash:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Por ejemplo, si los hashes `MD5`, `SHA1` e `IMPHASH` están almacenados en los registros de sysmon, entonces se crearán los siguientes archivos: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## Comando `list-ip-addresses`

Crea una lista de direcciones IP de destino y/o de origen únicas para usar con `vt-ip-lookup`.
Extraerá los campos `TgtIP` para las direcciones IP de destino y los campos `SrcIP` para las direcciones IP de origen en todos los resultados y mostrará únicamente las direcciones IP únicas en un archivo de texto.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Archivo de texto

Opciones requeridas:

 - `-o, --output <TXT-FILE>`: guarda los resultados en un archivo de texto.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo o directorio de línea de tiempo JSONL de Hayabusa.

Opciones:

 - `-i, --inbound`: incluir el tráfico entrante. (predeterminado: `true`)
 - `-O, --outbound`: incluir el tráfico saliente. (predeterminado: `true`)
 - `-p, --privateIp`: incluir direcciones IP privadas (predeterminado: `false`)
 - `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)
 - `-s, --skipProgressBar`: "no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `list-ip-addresses`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Guarda los resultados en un archivo de texto:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Excluir el tráfico entrante:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Incluir direcciones IP privadas:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## Comando `list-undetected-evtx`

Enumera todos los archivos `.evtx` para los que Hayabusa no tenía una regla de detección.
Esto está pensado para usarse con archivos evtx de muestra que contengan todos evidencia de actividad maliciosa, como los archivos evtx de muestra del repositorio [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx).

* Entrada: CSV
* Perfil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Primero debes ejecutar Hayabusa con un perfil que guarde la información de la columna `%EvtxFile%` y guardar los resultados en una línea de tiempo CSV.
  > Puedes ver qué columnas guarda Hayabusa según los diferentes perfiles [aquí](https://github.com/Yamato-Security/hayabusa#profiles).
* Salida: Terminal o archivo de texto

Opciones requeridas:

- `-e, --evtx-dir <EVTX-DIR>`: El directorio de archivos `.evtx` que escaneaste con Hayabusa.
- `-t, --timeline <CSV-FILE>`: línea de tiempo CSV de Hayabusa.

Opciones:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: especifica un nombre de columna personalizado para la columna evtx. (predeterminado: el valor predeterminado de Hayabusa de `EvtxFile`)
- `-o, --output <TXT-FILE>`: guarda los resultados en un archivo de texto. (predeterminado: salida en pantalla)
- `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)

### Ejemplos del comando `list-undetected-evtx`

Prepara la línea de tiempo CSV con Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Muestra los resultados en pantalla:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Guarda los resultados en un archivo de texto:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## Comando `list-unused-rules`

Enumera todas las reglas de detección `.yml` que no detectaron nada.
Esto es útil para ayudar a determinar la fiabilidad de las reglas.
Es decir, qué reglas se sabe que encuentran actividad maliciosa y cuáles aún no se han probado y necesitan archivos `.evtx` de muestra.

* Entrada: CSV
* Perfil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Primero debes ejecutar Hayabusa con un perfil que guarde la información de la columna `%RuleFile%` y guardar los resultados en una línea de tiempo CSV.
  > Puedes ver qué columnas guarda Hayabusa según los diferentes perfiles [aquí](https://github.com/Yamato-Security/hayabusa#profiles).
* Salida: Terminal o archivo de texto

Opciones requeridas:

- `-r, --rules-dir <DIR>`: el directorio de archivos de reglas `.yml` que usaste con Hayabusa.
- `-t, --timeline <CSV-FILE>`: línea de tiempo CSV creada por Hayabusa.

Opciones:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: especifica un nombre de columna personalizado para la columna del archivo de reglas. (predeterminado: el valor predeterminado de Hayabusa de `RuleFile`)
- `-o, --output <TXT-FILE>`: guarda los resultados en un archivo de texto. (predeterminado: salida en pantalla)
- `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)

### Ejemplos del comando `list-unused-rules`

Prepara la línea de tiempo CSV con Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Muestra los resultados en pantalla:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Guarda los resultados en un archivo de texto:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

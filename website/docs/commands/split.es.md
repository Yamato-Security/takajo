# Comandos de división

## Comando `split-csv-timeline`

Divide una línea de tiempo CSV grande en otras más pequeñas según el nombre del equipo.

* Entrada: CSV sin formato multilínea
* Perfil: Cualquiera
* Salida: Múltiples archivos CSV

Opciones obligatorias:

- `-t, --timeline <CSV-FILE>`: línea de tiempo CSV creada por Hayabusa.

Opciones:

- `-m, --makeMultiline`: muestra los campos en varias líneas. (predeterminado: `false`)
- `-o, --output <DIR>`: directorio donde guardar los archivos CSV. (predeterminado: `output`)
- `-q, --quiet`: no muestra el logotipo. (predeterminado: `false`)

### Ejemplos del comando `split-csv-timeline`

Prepara la línea de tiempo CSV con Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Divide la única línea de tiempo CSV en múltiples líneas de tiempo CSV en el directorio `output` predeterminado:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Separa la información de los campos con caracteres de salto de línea para crear entradas multilínea y guarda en el directorio `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## Comando `split-json-timeline`

Divide una línea de tiempo JSONL grande en otras más pequeñas según el nombre del equipo.

* Entrada: JSONL
* Perfil: Cualquiera
* Salida: Múltiples archivos JSONL

Opciones obligatorias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo o directorio de línea de tiempo JSONL de Hayabusa.

Opciones:

- `-o, --output <DIR>`: directorio donde guardar los archivos JSONL. (predeterminado: `output`)
- `-q, --quiet`: no muestra el logotipo. (predeterminado: `false`)

### Ejemplos del comando `split-json-timeline`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Divide la única línea de tiempo JSONL en múltiples líneas de tiempo JSONL en el directorio `output` predeterminado:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Guarda en el directorio `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

# Comandos de automatización

## Comando `automagic`

Ejecuta automáticamente tantos comandos como sea posible y envía los resultados a una nueva carpeta

> Nota: Debe usar el perfil `verbose` o `super-verbose` para utilizar todos los comandos.

* Entrada: archivo JSONL o directorio de archivos JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Una nueva carpeta con todos los resultados en distintos archivos

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Archivo o directorio de línea de tiempo JSONL de Hayabusa.

Opciones:

- `-d, --displayTable`: muestra la tabla de resultados (predeterminado: `false`)
- `-l, --level`: especifica el nivel de alerta mínimo (predeterminado: `low`)
- `-o, --output`: directorio de salida (predeterminado: `case-1`)
- `-q, --quiet`: no muestra el banner de inicio (predeterminado: `false`)
- `-s, --skipProgressBar`: no muestra la barra de progreso (predeterminado: `false`)

### Ejemplos del comando `automagic`

Prepare la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Ejecute tantos comandos de Takajo como sea posible y guarde los resultados en la carpeta `case-1`:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Ejecute tantos comandos de Takajo como sea posible en el directorio `hayabusa-results` y guarde los resultados en la carpeta `case-1`:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

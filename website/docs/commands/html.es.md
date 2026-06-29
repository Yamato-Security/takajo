# Comandos HTML

## Comando `html-report`

Crea informes resumidos en HTML para reglas y equipos con detecciones.
Este comando crea primero un archivo de base de datos DuckDB indexado (predeterminado) o un archivo de base de datos SQLite con el fin de realizar búsquedas rápidas en los datos necesarios para crear los informes resumidos.

* Entrada: JSONL
* Perfil: Cualquier perfil detallado
* Salida: Informes resumidos en HTML individuales basados en el nombre del equipo, así como una página principal `index.html`

Opciones requeridas:

- `-o, --output`: nombre del directorio del informe html
- `-r, --rulepath`: ruta al directorio de reglas de Hayabusa
- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo o directorio de línea de tiempo JSONL de Hayabusa

Opciones:

- `-C, --clobber`: sobrescribe el archivo de base de datos al guardar (predeterminado: `false`)
- `-q, --quiet`: no muestra el banner de inicio (predeterminado: `false`)
- `-s, --dboutput`: guarda los resultados en un archivo de base de datos (predeterminado: `html-report.duckdb` o `html-report.sqlite` con `--sqlite`)
- `--skipProgressBar`: no muestra la barra de progreso (predeterminado: `false`)
- `--sqlite`: usa el backend SQLite en lugar de DuckDB (predeterminado: `false`)

### Ejemplo del comando `html-report`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

o

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Crea los informes resumidos en HTML:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### Capturas de pantalla de `html-report`

#### Resumen de reglas

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Resumen de equipos

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Lista de reglas

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## Comando `html-server`

Crea un servidor web dinámico para ver los informes resumidos en HTML.
Este comando crea primero un archivo de base de datos DuckDB indexado (predeterminado) o un archivo de base de datos SQLite con el fin de realizar búsquedas rápidas en los datos necesarios para crear los informes resumidos.
Es similar al comando `html-report` pero es más escalable y permite filtrar por fechas y reglas.

* Entrada: JSONL
* Perfil: Cualquier perfil detallado
* Salida: De forma predeterminada, escuchará en `http://localhost:8823`

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo o directorio de línea de tiempo JSONL de Hayabusa

Opciones:

- `-C, --clobber`: sobrescribe el archivo de base de datos al guardar (predeterminado: `false`)
- `-p, --port`: número de puerto del servidor web (predeterminado: `8823`)
- `-q, --quiet`: no muestra el banner de inicio (predeterminado: `false`)
- `-r, --rulepath`: ruta al directorio de reglas de Hayabusa (es opcional pero necesaria para crear enlaces correctos a los archivos de reglas)
- `-s, --dboutput`: guarda los resultados en un archivo de base de datos (predeterminado: `html-report.duckdb` o `html-report.sqlite` con `--sqlite`)
- `--skipProgressBar`: no muestra la barra de progreso (predeterminado: `false`)
- `--sqlite`: usa el backend SQLite en lugar de DuckDB (predeterminado: `false`)

### Ejemplo del comando `html-report`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

o

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Inicia el servidor web:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### Capturas de pantalla de `html-server`

#### Lista de reglas

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Resumen de equipos

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Filtrado de reglas

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Filtrado de reglas

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

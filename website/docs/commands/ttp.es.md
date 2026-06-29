# Comandos TTP

## Comando `ttp-summary`

Este comando resume las tácticas y técnicas encontradas en cada equipo según las TTP de MITRE ATT&CK definidas en el campo `tags` de las reglas de sigma.

* Entrada: JSONL
* Perfil: Un perfil que muestre los campos `%MitreTactics%` y `%MitreTags%`. (Ej: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Salida: Terminal o CSV

Opciones obligatorias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-o, --output <CSV-FILE>`: el archivo CSV en el que guardar los resultados.
- `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)

### Ejemplos del comando `ttp-summary`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Imprime el resumen de TTP en la terminal:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Guarda los resultados en un archivo CSV:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### Captura de pantalla de `ttp-summary`

![ttp-summary](../assets/screenshots/ttp-summary.png)

## Comando `ttp-visualize`

Este comando extrae las TTP y crea un archivo JSON para visualizarlo en [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Entrada: JSONL
* Perfil: Un perfil que muestre los campos `%MitreTactics%` y `%MitreTags%`. (Ej: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Salida: JSON

Opciones obligatorias:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-o, --output <JSON-FILE>`: el archivo JSON en el que guardar los resultados. (predeterminado: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)

### Ejemplos del comando `ttp-visualize`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Extrae las TTP y guárdalas en `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

Abre [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), haz clic en `Open Existing Layer` y sube el archivo JSON guardado.

### Captura de pantalla de `ttp-visualize`

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## Comando `ttp-visualize-sigma`

Este comando extrae las TTP de Sigma y crea un archivo JSON para visualizarlo en [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Entrada: directorio de reglas de Sigma
* Salida: JSON

Opciones obligatorias:

- `-r, --ruleDir <SIGMA-DIR>`: directorio de reglas de Sigma

Opciones:

- `-o, --output <JSON-FILE>`: el archivo JSON en el que guardar los resultados. (predeterminado: `mitre-attack-navigator.json`)
- `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)

### Ejemplos del comando `ttp-visualize-sigma`

Clona el repositorio de Sigma:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Extrae las TTP de Sigma y guárdalas en `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

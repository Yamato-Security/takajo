# Comandos de extracción

## Comando `extract-scriptblocks`

Extrae y reensambla los registros de bloques de script de PowerShell EID 4104.

> Nota: Los scripts de PowerShell se abren mejor como archivos `.ps1` con resaltado de sintaxis de código, pero usamos la extensión `.txt` para evitar cualquier ejecución accidental de código malicioso.

* Entrada: JSONL
* Perfil: Cualquiera
* Salida: Terminal y directorio de scripts de PowerShell

Opciones requeridas:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Archivo o directorio de cronología JSONL de Hayabusa

Opciones:

 - `-l, --level`: especifica el nivel mínimo de alerta (predeterminado: `low`)
 - `-o, --output`: directorio de salida (predeterminado: `scriptblock-logs`)
 - `-q, --quiet`: no mostrar el banner de inicio (predeterminado: `false`)
 - `-s, --skipProgressBar`: no mostrar la barra de progreso (predeterminado: `false`)

### Ejemplo del comando `extract-scriptblocks`

Prepara la cronología JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Extrae los registros de bloques de script de PowerShell EID 4104 al directorio `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### Captura de pantalla de `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

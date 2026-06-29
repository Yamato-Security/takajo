# Comandos de Sysmon

## Comando `sysmon-process-tree`

Muestra el árbol de procesos de un proceso determinado, como un proceso sospechoso o malicioso.

* Entrada: JSONL
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: Terminal o archivo de texto

Opciones obligatorias:

- `-p, --processGuid <Process GUID>`: GUID del proceso de sysmon
- `-t, --timeline <JSONL-FILE-OR-DIR>`: archivo de línea de tiempo JSONL de Hayabusa o directorio de archivos JSONL

Opciones:

- `-o, --output <TXT-FILE>`: un archivo de texto en el que guardar los resultados.
- `-q, --quiet`: no mostrar el logotipo. (predeterminado: `false`)

### Ejemplos del comando `sysmon-process-tree`

Prepara la línea de tiempo JSONL con Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Guarda los resultados en un archivo de texto:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### Captura de pantalla de `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

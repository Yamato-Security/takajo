# Split-Befehle

## `split-csv-timeline`-Befehl

Teilt eine große CSV-Zeitleiste anhand des Computernamens in kleinere auf.

* Eingabe: Nicht-mehrzeilige CSV
* Profil: Beliebig
* Ausgabe: Mehrere CSV-Dateien

Erforderliche Optionen:

- `-t, --timeline <CSV-FILE>`: Von Hayabusa erstellte CSV-Zeitleiste.

Optionen:

- `-m, --makeMultiline`: Felder in mehreren Zeilen ausgeben. (Standard: `false`)
- `-o, --output <DIR>`: Verzeichnis, in dem die CSV-Dateien gespeichert werden. (Standard: `output`)
- `-q, --quiet`: Logo nicht anzeigen. (Standard: `false`)

### Beispiele für den `split-csv-timeline`-Befehl

Bereiten Sie die CSV-Zeitleiste mit Hayabusa vor:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Teilen Sie die einzelne CSV-Zeitleiste in mehrere CSV-Zeitleisten im Standardverzeichnis `output` auf:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Trennen Sie Feldinformationen mit Zeilenumbruchzeichen, um mehrzeilige Einträge zu erstellen, und speichern Sie sie im Verzeichnis `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline`-Befehl

Teilt eine große JSONL-Zeitleiste anhand des Computernamens in kleinere auf.

* Eingabe: JSONL
* Profil: Beliebig
* Ausgabe: Mehrere JSONL-Dateien

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Zeitleistendatei oder -verzeichnis.

Optionen:

- `-o, --output <DIR>`: Verzeichnis, in dem die JSONL-Dateien gespeichert werden. (Standard: `output`)
- `-q, --quiet`: Logo nicht anzeigen. (Standard: `false`)

### Beispiele für den `split-json-timeline`-Befehl

Bereiten Sie die JSONL-Zeitleiste mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Teilen Sie die einzelne JSONL-Zeitleiste in mehrere JSONL-Zeitleisten im Standardverzeichnis `output` auf:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Speichern Sie sie im Verzeichnis `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

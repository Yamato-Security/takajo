# Automatisierungsbefehle

## `automagic`-Befehl

Führt automatisch so viele Befehle wie möglich aus und gibt die Ergebnisse in einem neuen Ordner aus

> Hinweis: Sie sollten das Profil `verbose` oder `super-verbose` verwenden, um alle Befehle zu nutzen.

* Eingabe: JSONL-Datei oder Verzeichnis mit JSONL-Dateien
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Ein neuer Ordner mit allen Ergebnissen in verschiedenen Dateien

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder -Verzeichnis.

Optionen:

- `-d, --displayTable`: die Ergebnistabelle anzeigen (Standard: `false`)
- `-l, --level`: das minimale Warnstufenlevel angeben (Standard: `low`)
- `-o, --output`: Ausgabeverzeichnis (Standard: `case-1`)
- `-q, --quiet`: das Startbanner nicht anzeigen (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den `automagic`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Führen Sie so viele Takajo-Befehle wie möglich aus und speichern Sie die Ergebnisse im Ordner `case-1`:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Führen Sie so viele Takajo-Befehle wie möglich für das Verzeichnis `hayabusa-results` aus und speichern Sie die Ergebnisse im Ordner `case-1`:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

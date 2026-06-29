# Extract-Befehle

## `extract-scriptblocks`-Befehl

Extrahiert und setzt PowerShell-EID-4104-Skriptblock-Protokolle wieder zusammen.

> Hinweis: Die PowerShell-Skripte werden am besten als `.ps1`-Dateien mit Code-Syntaxhervorhebung geöffnet, aber wir verwenden die Erweiterung `.txt`, um ein versehentliches Ausführen von Schadcode zu verhindern.

* Eingabe: JSONL
* Profil: Beliebig
* Ausgabe: Terminal und Verzeichnis mit PowerShell-Skripten

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder -Verzeichnis

Optionen:

 - `-l, --level`: gibt die minimale Warnstufe an (Standard: `low`)
 - `-o, --output`: Ausgabeverzeichnis (Standard: `scriptblock-logs`)
 - `-q, --quiet`: das Startbanner nicht anzeigen (Standard: `false`)
 - `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiel für den `extract-scriptblocks`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Extrahieren Sie PowerShell-EID-4104-Skriptblock-Protokolle in das Verzeichnis `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### `extract-scriptblocks`-Screenshot

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

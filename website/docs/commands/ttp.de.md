# TTP-Befehle

## `ttp-summary`-Befehl

Dieser Befehl fasst die in jedem Computer gefundenen Taktiken und Techniken gemäß den MITRE ATT&CK TTPs zusammen, die im `tags`-Feld der Sigma-Regeln definiert sind.

* Eingabe: JSONL
* Profil: Ein Profil, das die Felder `%MitreTactics%` und `%MitreTags%` ausgibt. (Bsp.: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Ausgabe: Terminal oder CSV

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden.
- `-q, --quiet`: kein Logo anzeigen. (Standard: `false`)

### Beispiele für den `ttp-summary`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTP-Zusammenfassung im Terminal ausgeben:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Die Ergebnisse in einer CSV-Datei speichern:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary`-Screenshot

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize`-Befehl

Dieser Befehl extrahiert TTPs und erstellt eine JSON-Datei zur Visualisierung im [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Eingabe: JSONL
* Profil: Ein Profil, das die Felder `%MitreTactics%` und `%MitreTags%` ausgibt. (Bsp.: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Ausgabe: JSON

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-o, --output <JSON-FILE>`: die JSON-Datei, in der die Ergebnisse gespeichert werden. (Standard: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: kein Logo anzeigen. (Standard: `false`)

### Beispiele für den `ttp-visualize`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Die TTPs extrahieren und in `mitre-ttp-heatmap.json` speichern:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

Öffnen Sie [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), klicken Sie auf `Open Existing Layer` und laden Sie die gespeicherte JSON-Datei hoch.

### `ttp-visualize`-Screenshot

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma`-Befehl

Dieser Befehl extrahiert TTPs aus Sigma und erstellt eine JSON-Datei zur Visualisierung im [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Eingabe: Sigma-Regelverzeichnis
* Ausgabe: JSON

Erforderliche Optionen:

- `-r, --ruleDir <SIGMA-DIR>`: Sigma-Regelverzeichnis

Optionen:

- `-o, --output <JSON-FILE>`: die JSON-Datei, in der die Ergebnisse gespeichert werden. (Standard: `mitre-attack-navigator.json`)
- `-q, --quiet`: kein Logo anzeigen. (Standard: `false`)

### Beispiele für den `ttp-visualize-sigma`-Befehl

Klonen Sie das Sigma-Repository:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Die TTPs aus Sigma extrahieren und in `mitre-attack-navigator.json` speichern:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

# HTML-Befehle

## `html-report` Befehl

Erstellt HTML-Zusammenfassungsberichte für Regeln und Computer mit Erkennungen.
Dieser Befehl erstellt zunächst eine indizierte DuckDB-Datenbankdatei (Standard) oder eine SQLite-Datenbankdatei, um schnelle Abfragen der Daten durchzuführen, die zur Erstellung der Zusammenfassungsberichte benötigt werden.

* Eingabe: JSONL
* Profil: Beliebiges ausführliches Profil
* Ausgabe: Einzelne HTML-Zusammenfassungsberichte basierend auf dem Computernamen sowie eine `index.html` Hauptseite

Erforderliche Optionen:

- `-o, --output`: Verzeichnisname des HTML-Berichts
- `-r, --rulepath`: Pfad zum Hayabusa-Regelverzeichnis
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder -Verzeichnis

Optionen:

- `-C, --clobber`: überschreibt die Datenbankdatei beim Speichern (Standard: `false`)
- `-q, --quiet`: zeigt das Start-Banner nicht an (Standard: `false`)
- `-s, --dboutput`: speichert die Ergebnisse in einer Datenbankdatei (Standard: `html-report.duckdb` oder `html-report.sqlite` mit `--sqlite`)
- `--skipProgressBar`: zeigt die Fortschrittsanzeige nicht an (Standard: `false`)
- `--sqlite`: verwendet das SQLite-Backend anstelle von DuckDB (Standard: `false`)

### `html-report` Befehlsbeispiel

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

oder

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Erstellen Sie die HTML-Zusammenfassungsberichte:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report` Screenshots

#### Regelzusammenfassung

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Computerzusammenfassung

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Regelliste

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server` Befehl

Erstellt einen dynamischen Webserver zur Anzeige von HTML-Zusammenfassungsberichten.
Dieser Befehl erstellt zunächst eine indizierte DuckDB-Datenbankdatei (Standard) oder eine SQLite-Datenbankdatei, um schnelle Abfragen der Daten durchzuführen, die zur Erstellung der Zusammenfassungsberichte benötigt werden.
Er ähnelt dem `html-report` Befehl, ist aber besser skalierbar und ermöglicht das Filtern nach Datum und Regeln.

* Eingabe: JSONL
* Profil: Beliebiges ausführliches Profil
* Ausgabe: Standardmäßig wird auf `http://localhost:8823` gelauscht

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder -Verzeichnis

Optionen:

- `-C, --clobber`: überschreibt die Datenbankdatei beim Speichern (Standard: `false`)
- `-p, --port`: Portnummer des Webservers (Standard: `8823`)
- `-q, --quiet`: zeigt das Start-Banner nicht an (Standard: `false`)
- `-r, --rulepath`: Pfad zum Hayabusa-Regelverzeichnis (dies ist optional, aber erforderlich, um korrekte Links zu den Regeldateien zu erstellen)
- `-s, --dboutput`: speichert die Ergebnisse in einer Datenbankdatei (Standard: `html-report.duckdb` oder `html-report.sqlite` mit `--sqlite`)
- `--skipProgressBar`: zeigt die Fortschrittsanzeige nicht an (Standard: `false`)
- `--sqlite`: verwendet das SQLite-Backend anstelle von DuckDB (Standard: `false`)

### `html-report` Befehlsbeispiel

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

oder

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Starten Sie den Webserver:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server` Screenshots

#### Regelliste

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Computerzusammenfassung

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Regelfilterung

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Regelfilterung

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

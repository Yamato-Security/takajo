# Timeline-Befehle

## `timeline-logon` Befehl

Dieser Befehl extrahiert Informationen aus den folgenden Anmeldeereignissen, normalisiert die Felder und speichert die Ergebnisse in einer CSV-Datei:

- `4624` - Erfolgreiche Anmeldung
- `4625` - Fehlgeschlagene Anmeldung
- `4634` - Abmeldung des Kontos
- `4647` - Vom Benutzer initiierte Abmeldung
- `4648` - Explizite Anmeldung
- `4672` - Administrator-Anmeldung

Dies erleichtert das Erkennen von Lateral Movement, Passwort-Erraten/-Spraying, Privilegieneskalation usw...

* Eingabe: JSONL
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: CSV

Erforderliche Optionen:

- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-c, --calculateElapsedTime`: berechnet die verstrichene Zeit für erfolgreiche Anmeldungen. (Standard: `true`)
- `-l, --outputLogoffEvents`: gibt Abmeldeereignisse als separate Einträge aus. (Standard: `false`)
- `-a, --outputAdminLogonEvents`: gibt Administrator-Anmeldeereignisse als separate Einträge aus. (Standard: `false`)
- `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)

### `timeline-logon` Befehlsbeispiele

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Speichern Sie die Anmelde-Timeline in einer CSV-Datei:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-logon` Screenshot

![timeline-logon](../assets/screenshots/timeline-logon.png)

## `timeline-partition-diagnostic` Befehl

Erstellt eine CSV-Timeline von Partition-Diagnoseereignissen, indem Windows-10-`Microsoft-Windows-Partition%4Diagnostic.evtx`-Dateien geparst werden und Informationen über alle verbundenen Geräte und deren Volume-Seriennummern gemeldet werden, sowohl die derzeit auf dem Gerät vorhandenen als auch die zuvor vorhandenen.
Dieser Vorgang basiert auf dem Tool [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Eingabe: JSONL
* Profil: Jedes
* Ausgabe: Terminal oder CSV

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden.
- `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)

### `timeline-partition-diagnostic` Befehlsbeispiele

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Erstellen Sie eine CSV-Timeline der verbundenen Geräte:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## `timeline-suspicious-processes` Befehl

Erstellt eine CSV-Timeline verdächtiger Prozesse.

* Eingabe: JSONL
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)

Optionen:

- `-l, --level <LEVEL>`: gibt die minimale Alarmstufe an (Standard: `high`)
- `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)

### `timeline-suspicious-processes` Befehlsbeispiele

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Suchen Sie nach Prozessen mit einer Alarmstufe von `high` oder höher und geben Sie die Ergebnisse auf dem Bildschirm aus:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Suchen Sie nach Prozessen mit einer Alarmstufe von `low` oder höher und geben Sie die Ergebnisse auf dem Bildschirm aus:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Speichern Sie die Ergebnisse in einer CSV-Datei:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### `timeline-suspicious-processes` Screenshot

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## `timeline-tasks` Befehl

Dieser Befehl stapelt neue geplante Aufgaben aus Security-4698-Ereignissen und parst den XML-Aufgabeninhalt.

* Eingabe: JSONL
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden.
- `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)

### `timeline-tasks` Befehlsbeispiele

Ausgabe auf dem Terminal:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Speichern als CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

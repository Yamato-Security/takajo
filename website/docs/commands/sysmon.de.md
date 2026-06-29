# Sysmon-Befehle

## Befehl `sysmon-process-tree`

Gibt den Prozessbaum eines bestimmten Prozesses aus, beispielsweise eines verdächtigen oder bösartigen Prozesses.

* Eingabe: JSONL
* Profil: Beliebig außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder Textdatei

Erforderliche Optionen:

- `-p, --processGuid <Process GUID>`: Sysmon-Prozess-GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Zeitleistendatei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-o, --output <TXT-FILE>`: eine Textdatei, in der die Ergebnisse gespeichert werden.
- `-q, --quiet`: Logo nicht anzeigen. (Standard: `false`)

### Beispiele für den Befehl `sysmon-process-tree`

JSONL-Zeitleiste mit Hayabusa vorbereiten:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Die Ergebnisse in einer Textdatei speichern:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### Screenshot von `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

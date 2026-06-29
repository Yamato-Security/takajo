# List-Befehle

## `list-domains`-Befehl

Erstellt eine Liste eindeutiger Domains zur Verwendung mit `vt-domain-lookup`.
Derzeit werden nur abgefragte Domains in Sysmon-EID-22-Logs überprüft, aber dies wird aktualisiert, um die integrierten Windows-DNS-Client- und -Server-Logs zu unterstützen.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Textdatei

Erforderliche Optionen:

 - `-o, --output <TXT-FILE>`: speichert die Ergebnisse in einer Textdatei.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder -Verzeichnis.

Optionen:

 - `-s, --includeSubdomains`: schließt Subdomains ein (Standard: `false`)
 - `-w, --includeWorkstations`: schließt lokale Workstation-Namen ein (Standard: `false`)
 - `-q, --quiet`: zeigt das Logo nicht an (Standard: `false`)
 - `-s, --skipProgressBar`: zeigt den Fortschrittsbalken nicht an (Standard: `false`)

### Beispiele für den `list-domains`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Speichern Sie die Ergebnisse in einer Textdatei:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Schließen Sie Subdomains ein:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes`-Befehl

Erstellt eine Liste von Prozess-Hashes zur Verwendung mit vt-hash-lookup (Eingabe: JSONL, Profil: standard)

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Textdatei

Erforderliche Optionen:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien
 - `-o, --output <BASE-NAME>`: gibt den Basisnamen an, unter dem die Textergebnisse gespeichert werden.

Optionen:

 - `-l, --level`: gibt das Mindestniveau an. (Standard: `high`)
 - `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)
 - `-s, --skipProgressBar`: zeigt den Fortschrittsbalken nicht an (Standard: `false`)

### Beispiele für den `list-hashes`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Speichern Sie die Ergebnisse für jeden Hash-Typ in einer separaten Textdatei:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Wenn beispielsweise `MD5`-, `SHA1`- und `IMPHASH`-Hashes in den Sysmon-Logs gespeichert sind, werden die folgenden Dateien erstellt: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses`-Befehl

Erstellt eine Liste eindeutiger Ziel- und/oder Quell-IP-Adressen zur Verwendung mit `vt-ip-lookup`.
Es extrahiert die `TgtIP`-Felder für Ziel-IP-Adressen und die `SrcIP`-Felder für Quell-IP-Adressen aus allen Ergebnissen und gibt nur die eindeutigen IP-Adressen in eine Textdatei aus.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Textdatei

Erforderliche Optionen:

 - `-o, --output <TXT-FILE>`: speichert die Ergebnisse in einer Textdatei.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder -Verzeichnis.

Optionen:

 - `-i, --inbound`: schließt eingehenden Datenverkehr ein. (Standard: `true`)
 - `-O, --outbound`: schließt ausgehenden Datenverkehr ein. (Standard: `true`)
 - `-p, --privateIp`: schließt private IP-Adressen ein (Standard: `false`)
 - `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)
 - `-s, --skipProgressBar`: "zeigt den Fortschrittsbalken nicht an (Standard: `false`)

### Beispiele für den `list-ip-addresses`-Befehl

Bereiten Sie die JSONL-Timeline mit Hayabusa vor:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Speichern Sie die Ergebnisse in einer Textdatei:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Schließen Sie eingehenden Datenverkehr aus:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Schließen Sie private IP-Adressen ein:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx`-Befehl

Listet alle `.evtx`-Dateien auf, für die Hayabusa keine Erkennungsregel hatte.
Dies ist für die Verwendung mit beispielhaften evtx-Dateien gedacht, die alle Hinweise auf bösartige Aktivitäten enthalten, wie etwa die beispielhaften evtx-Dateien im [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx)-Repository.

* Eingabe: CSV
* Profil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Sie müssen Hayabusa zunächst mit einem Profil ausführen, das die Spalteninformationen `%EvtxFile%` speichert, und die Ergebnisse in einer CSV-Timeline speichern.
  > Welche Spalten Hayabusa je nach den verschiedenen Profilen speichert, können Sie [hier](https://github.com/Yamato-Security/hayabusa#profiles) sehen.
* Ausgabe: Terminal oder Textdatei

Erforderliche Optionen:

- `-e, --evtx-dir <EVTX-DIR>`: Das Verzeichnis der `.evtx`-Dateien, die Sie mit Hayabusa gescannt haben.
- `-t, --timeline <CSV-FILE>`: Hayabusa-CSV-Timeline.

Optionen:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: gibt einen benutzerdefinierten Spaltennamen für die evtx-Spalte an. (Standard: Hayabusas Standardwert `EvtxFile`)
- `-o, --output <TXT-FILE>`: speichert die Ergebnisse in einer Textdatei. (Standard: Ausgabe auf dem Bildschirm)
- `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)

### Beispiele für den `list-undetected-evtx`-Befehl

Bereiten Sie die CSV-Timeline mit Hayabusa vor:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Geben Sie die Ergebnisse auf dem Bildschirm aus:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Speichern Sie die Ergebnisse in einer Textdatei:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules`-Befehl

Listet alle `.yml`-Erkennungsregeln auf, die nichts erkannt haben.
Dies ist hilfreich, um die Zuverlässigkeit von Regeln zu bestimmen.
Das heißt, welche Regeln bekanntermaßen bösartige Aktivitäten finden und welche noch ungetestet sind und beispielhafte `.evtx`-Dateien benötigen.

* Eingabe: CSV
* Profil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Sie müssen Hayabusa zunächst mit einem Profil ausführen, das die Spalteninformationen `%RuleFile%` speichert, und die Ergebnisse in einer CSV-Timeline speichern.
  > Welche Spalten Hayabusa je nach den verschiedenen Profilen speichert, können Sie [hier](https://github.com/Yamato-Security/hayabusa#profiles) sehen.
* Ausgabe: Terminal oder Textdatei

Erforderliche Optionen:

- `-r, --rules-dir <DIR>`: das Verzeichnis der `.yml`-Regeldateien, die Sie mit Hayabusa verwendet haben.
- `-t, --timeline <CSV-FILE>`: von Hayabusa erstellte CSV-Timeline.

Optionen:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: gibt einen benutzerdefinierten Spaltennamen für die Regeldateispalte an. (Standard: Hayabusas Standardwert `RuleFile`)
- `-o, --output <TXT-FILE>`: speichert die Ergebnisse in einer Textdatei. (Standard: Ausgabe auf dem Bildschirm)
- `-q, --quiet`: zeigt das Logo nicht an. (Standard: `false`)

### Beispiele für den `list-unused-rules`-Befehl

Bereiten Sie die CSV-Timeline mit Hayabusa vor:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Geben Sie die Ergebnisse auf dem Bildschirm aus:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Speichern Sie die Ergebnisse in einer Textdatei:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

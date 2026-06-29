# Stack-Befehle

## Befehl `stack-cmdlines`

Dieser Befehl stapelt ausgeführte Befehlszeilen, indem er Informationen aus `Sysmon 1`- und `Security 4688`-Ereignissen extrahiert.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-y, --ignoreSysmon`: schließt Sysmon-1-Ereignisse aus (Standard: `false`)
- `-e, --ignoreSecurity`: schließt Security-4688-Ereignisse aus (Standard: `false`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-cmdlines`

Ausgabe auf dem Terminal:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## Befehl `stack-computers`

Dieser Befehl stapelt Computer-Hostnamen gemäß dem Feld `Computer`.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-c, --sourceComputers`: stapelt Quell-Computer anstelle von Ziel-Computern (Standard: false)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-computers`

Ausgabe auf dem Terminal:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## Befehl `stack-dns`

Dieser Befehl stapelt DNS-Anfragen und -Antworten aus Sysmon-22-Ereignissen.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-dns`

Ausgabe auf dem Terminal:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## Befehl `stack-ip-addresses`

Dieser Befehl stapelt die Ziel-IP-Adressen (Feld `TgtIP`) oder Quell-IP-Adressen (Feld `SrcIP`).

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-a, --targetIpAddresses`: stapelt Ziel-IP-Adressen anstelle von Quell-IP-Adressen (Standard: `false`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-ip-addresses`

Ausgabe auf dem Terminal:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## Befehl `stack-logons`

Erstellt eine Liste von Anmeldungen gemäß `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
Ergebnisse werden standardmäßig herausgefiltert, wenn die Quell-IP-Adresse eine lokale IP-Adresse ist.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --localSrcIpAddresses`: schließt Ergebnisse ein, wenn die Quell-IP-Adresse lokal ist.
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-logons`

Mit Standardeinstellungen ausführen:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Lokale Anmeldungen einschließen:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## Befehl `stack-processes`

Dieser Befehl stapelt ausgeführte Prozesse aus Sysmon-1- und Security-4688-Ereignissen.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `low`)
- `-y, --ignoreSysmon`: schließt Sysmon-1-Ereignisse aus (Standard: `false`)
- `-e, --ignoreSecurity`: schließt Security-4688-Ereignisse aus (Standard: `false`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-processes`

Ausgabe auf dem Terminal:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## Befehl `stack-services`

Dieser Befehl stapelt Dienstnamen und -pfade aus System-7040- und Security-4697-Ereignissen.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-y, --ignoreSystem`: schließt System-7040-Ereignisse aus (Standard: `false`)
- `-e, --ignoreSecurity`: schließt Security-4697-Ereignisse aus (Standard: `false`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-services`

Ausgabe auf dem Terminal:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## Befehl `stack-tasks`

Dieser Befehl stapelt neue geplante Aufgaben aus Security-4698-Ereignissen und parst den XML-Aufgabeninhalt.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-tasks`

Ausgabe auf dem Terminal:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## Befehl `stack-users`

Dieser Befehl stapelt die Zielbenutzer (Feld `TgtUser` (Standard)) oder Quellbenutzer (Feld `SrcUser`) in jedem Ereignis, das diese Felder enthält, und zeigt zudem Warnungsinformationen an.

* Eingabe: JSONL
* Profil: Beliebig, außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: Terminal oder CSV-Datei

Erforderliche Optionen:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa-JSONL-Timeline-Datei oder Verzeichnis mit JSONL-Dateien

Optionen:

- `-s, --sourceUsers`: stapelt Quellbenutzer anstelle von Zielbenutzern (Standard: false)
- `-c, --filterComputerAccounts`: filtert Computerkonten heraus (Standard: true)
- `-f, --filterSystemAccounts`: filtert Systemkonten heraus (Standard: true)
- `-l, --level`: legt die minimale Warnstufe fest (Standard: `informational`)
- `-o, --output <CSV-FILE>`: die CSV-Datei, in der die Ergebnisse gespeichert werden (Standard: `stdout`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)
- `-s, --skipProgressBar`: den Fortschrittsbalken nicht anzeigen (Standard: `false`)

### Beispiele für den Befehl `stack-users`

Ausgabe auf dem Terminal:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

In CSV speichern:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

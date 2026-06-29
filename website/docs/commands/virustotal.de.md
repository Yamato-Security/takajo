# VirusTotal-Befehle

## Befehl `vt-domain-lookup`

Eine Liste von Domains auf VirusTotal nachschlagen

* Eingabe: Textdatei
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: CSV

Erforderliche Optionen:

- `-a, --apiKey <API-KEY>`: Ihr VirusTotal-API-Schlüssel.
- `-d, --domainList <TXT-FILE>`: eine Textdatei mit einer Liste von Domains.
- `-o, --output <CSV-FILE>`: die Ergebnisse in einer CSV-Datei speichern.

Optionen:

- `-j, --jsonOutput <JSON-FILE>`: alle JSON-Antworten von VirusTotal in eine JSON-Datei ausgeben.
- `-r, --rateLimit <NUMBER>`: die Rate pro Minute, mit der Anfragen gesendet werden. (Standard: `4`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)

### Beispiele für den Befehl `vt-domain-lookup`

Erstellen Sie zunächst mit dem Befehl `list-domains` eine Liste von Domains.
Schlagen Sie diese Domains dann wie folgt nach:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## Befehl `vt-hash-lookup`

Eine Liste von Hashes auf VirusTotal nachschlagen.

* Eingabe: Textdatei
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: CSV

Erforderliche Optionen:

- `-a, --apiKey <API-KEY>`: Ihr VirusTotal-API-Schlüssel.
- `-H, --hashList <HASH-LIST>`: eine Textdatei mit Hashes.
- `-o, --output <CSV-FILE>`: die Ergebnisse in einer CSV-Datei speichern.

Optionen:

- `-j, --jsonOutput <JSON-FILE>`: alle JSON-Antworten von VirusTotal in eine JSON-Datei ausgeben.
- `-r, --rateLimit <NUMBER>`: die Rate pro Minute, mit der Anfragen gesendet werden. (Standard: `4`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)

### Beispiele für den Befehl `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## Befehl `vt-ip-lookup`

Eine Liste von IP-Adressen auf VirusTotal nachschlagen.

* Eingabe: Textdatei
* Profil: Jedes außer `all-field-info` und `all-field-info-verbose`
* Ausgabe: CSV

Erforderliche Optionen:

- `-a, --apiKey <API-KEY>`: Ihr VirusTotal-API-Schlüssel.
- `-i, --ipList <IP-ADDRESS-LIST>`: eine Textdatei mit IP-Adressen.
- `-o, --output <CSV-FILE>`: die Ergebnisse in einer CSV-Datei speichern.

Optionen:

- `-j, --jsonOutput <JSON-FILE>`: alle JSON-Antworten von VirusTotal in eine JSON-Datei ausgeben.
- `-r, --rateLimit <NUMBER>`: die Rate pro Minute, mit der Anfragen gesendet werden. (Standard: `4`)
- `-q, --quiet`: das Logo nicht anzeigen. (Standard: `false`)

### Beispiele für den Befehl `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

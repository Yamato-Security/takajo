# Befehlsliste

## Automatisierungsbefehle
* `automagic`: führt automatisch so viele Befehle wie möglich aus und gibt die Ergebnisse in einen neuen Ordner aus

## Extraktionsbefehle
* `extract-scriptblocks`: extrahiert und setzt PowerShell-EID-4104-Skriptblock-Protokolle wieder zusammen

## HTML-Befehle
* `html-report`: erstellt statische HTML-Zusammenfassungsberichte
* `html-server`: erstellt einen dynamischen Webserver zum Anzeigen von HTML-Zusammenfassungsberichten

## Listenbefehle
* `list-domains`: erstellt eine Liste eindeutiger Domains zur Verwendung mit `vt-domain-lookup`
* `list-hashes`: erstellt eine Liste von Prozess-Hashes zur Verwendung mit `vt-hash-lookup`
* `list-ip-addresses`: erstellt eine Liste eindeutiger Ziel- und/oder Quell-IP-Adressen zur Verwendung mit `vt-ip-lookup`
* `list-undetected-evtx`: erstellt eine Liste nicht erkannter evtx-Dateien
* `list-unused-rules`: erstellt eine Liste ungenutzter Erkennungsregeln

## Aufteilungsbefehle
* `split-csv-timeline`: teilt eine große CSV-Zeitleiste anhand des Computernamens in kleinere auf
* `split-json-timeline`: teilt eine große JSONL-Zeitleiste anhand des Computernamens in kleinere auf

## Stack-Befehle
* `stack-cmdlines`: stapelt ausgeführte Befehlszeilen
* `stack-computers`: stapelt Computer
* `stack-dns`: stapelt DNS-Abfragen und -Antworten
* `stack-ip-addresses`: stapelt Ziel-IP-Adressen (`TgtIP`-Feld) oder Quell-IP-Adressen (`SrcIP`-Feld)
* `stack-logons`: stapelt Anmeldungen nach Zielbenutzer, Zielcomputer, Quell-IP-Adresse und Quellcomputer
* `stack-processes`: stapelt ausgeführte Prozesse
* `stack-services`: stapelt Dienstnamen und -pfade aus `System 7040`- und `Security 4697`-Ereignissen
* `stack-tasks`: stapelt neue geplante Aufgaben aus `Security 4698`-Ereignissen und parst den XML-Aufgabeninhalt
* `stack-users`: stapelt Zielbenutzer (`TgtUser`-Feld) oder Quellbenutzer (`SrcUser`-Feld)

## Sysmon-Befehle
* `sysmon-process-tree`: gibt den Prozessbaum eines bestimmten Prozesses aus

## Zeitleistenbefehle
* `timeline-logon`: erstellt eine CSV-Zeitleiste von Anmeldeereignissen
* `timeline-partition-diagnostic`: erstellt eine CSV-Zeitleiste von Partitionsdiagnoseereignissen
* `timeline-suspicious-processes`: erstellt eine CSV-Zeitleiste verdächtiger Prozesse
* `timeline-tasks`: erstellt eine CSV-Zeitleiste geplanter Aufgaben

## TTP-Befehle
* `ttp-summary`: fasst die in jedem Computer gefundenen Taktiken und Techniken zusammen
* `ttp-visualize`: extrahiert TTPs und erstellt eine JSON-Datei zur Visualisierung im MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: extrahiert TTPs aus Sigma-Regeln und erstellt eine JSON-Datei zur Visualisierung im MITRE ATT&CK Navigator

## VirusTotal-Befehle
* `vt-domain-lookup`: schlägt eine Liste von Domains auf VirusTotal nach und meldet bösartige
* `vt-hash-lookup`: schlägt eine Liste von Hashes auf VirusTotal nach und meldet bösartige
* `vt-ip-lookup`: schlägt eine Liste von IP-Adressen auf VirusTotal nach und meldet bösartige

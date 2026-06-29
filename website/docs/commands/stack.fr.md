# Commandes Stack

## Commande `stack-cmdlines`

Cette commande empile les lignes de commande exécutées en extrayant les informations des événements `Sysmon 1` et `Security 4688`.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-y, --ignoreSysmon` : exclut les événements Sysmon 1 (par défaut : `false`)
- `-e, --ignoreSecurity` : exclut les événements Security 4688 (par défaut : `false`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-cmdlines`

Sortie vers le terminal :

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## Commande `stack-computers`

Cette commande empile les noms d'hôtes des ordinateurs selon le champ `Computer`.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-c, --sourceComputers` : empile les ordinateurs source au lieu des ordinateurs cible (par défaut : false)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-computers`

Sortie vers le terminal :

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## Commande `stack-dns`

Cette commande empile les requêtes et réponses DNS issues des événements Sysmon 22.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-dns`

Sortie vers le terminal :

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## Commande `stack-ip-addresses`

Cette commande empile les adresses IP cible (champ `TgtIP`) ou les adresses IP source (champ `SrcIP`).

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-a, --targetIpAddresses` : empile les adresses IP cible au lieu des adresses IP source (par défaut : `false`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-ip-addresses`

Sortie vers le terminal :

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## Commande `stack-logons`

Crée une liste de connexions selon `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
Par défaut, les résultats sont filtrés lorsque l'adresse IP source est une adresse IP locale.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --localSrcIpAddresses` : inclut les résultats lorsque l'adresse IP source est locale.
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-logons`

Exécution avec les paramètres par défaut :

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Inclusion des connexions locales :

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## Commande `stack-processes`

Cette commande empile les processus exécutés issus des événements Sysmon 1 et Security 4688.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `low`)
- `-y, --ignoreSysmon` : exclut les événements Sysmon 1 (par défaut : `false`)
- `-e, --ignoreSecurity` : exclut les événements Security 4688 (par défaut : `false`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-processes`

Sortie vers le terminal :

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## Commande `stack-services`

Cette commande empile les noms et chemins des services issus des événements System 7040 et Security 4697.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-y, --ignoreSystem` : exclut les événements System 7040 (par défaut : `false`)
- `-e, --ignoreSecurity` : exclut les événements Security 4697 (par défaut : `false`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-services`

Sortie vers le terminal :

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## Commande `stack-tasks`

Cette commande empile les nouvelles tâches planifiées issues des événements Security 4698 et analyse le contenu XML des tâches.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-tasks`

Sortie vers le terminal :

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## Commande `stack-users`

Cette commande empile les utilisateurs cible (champ `TgtUser` (par défaut)) ou les utilisateurs source (champ `SrcUser`) dans tout événement qui contient ces champs et affiche également les informations d'alerte.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-s, --sourceUsers` : empile les utilisateurs source au lieu des utilisateurs cible (par défaut : false)
- `-c, --filterComputerAccounts` : filtre les comptes d'ordinateur (par défaut : true)
- `-f, --filterSystemAccounts` : filtre les comptes système (par défaut : true)
- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `informational`)
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)
- `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemples de la commande `stack-users`

Sortie vers le terminal :

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

Enregistrement dans un CSV :

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

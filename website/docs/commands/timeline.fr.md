# Commandes de chronologie

## Commande `timeline-logon`

Cette commande extrait les informations des événements de connexion suivants, normalise les champs et enregistre les résultats dans un fichier CSV :

- `4624` - Connexion réussie
- `4625` - Échec de connexion
- `4634` - Déconnexion de compte
- `4647` - Déconnexion initiée par l'utilisateur
- `4648` - Connexion explicite
- `4672` - Connexion administrateur

Cela facilite la détection des mouvements latéraux, des attaques par devinette/pulvérisation de mots de passe, de l'élévation de privilèges, etc...

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : CSV

Options requises :

- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats.
- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-c, --calculateElapsedTime` : calcule le temps écoulé pour les connexions réussies. (par défaut : `true`)
- `-l, --outputLogoffEvents` : émet les événements de déconnexion en tant qu'entrées distinctes. (par défaut : `false`)
- `-a, --outputAdminLogonEvents` : émet les événements de connexion administrateur en tant qu'entrées distinctes. (par défaut : `false`)
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `timeline-logon`

Préparez une chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Enregistrez la chronologie de connexion dans un fichier CSV :

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### Capture d'écran de `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## Commande `timeline-partition-diagnostic`

Crée une chronologie CSV des événements de diagnostic de partition en analysant les fichiers Windows 10 `Microsoft-Windows-Partition%4Diagnostic.evtx` et en rapportant des informations sur tous les périphériques connectés et leurs numéros de série de volume, qu'ils soient actuellement présents sur l'appareil ou qu'ils aient existé auparavant.
Ce processus est basé sur l'outil [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Entrée : JSONL
* Profil : N'importe lequel
* Sortie : Terminal ou CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats.
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `timeline-partition-diagnostic`

Préparez une chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Créez une chronologie CSV des périphériques connectés :

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## Commande `timeline-suspicious-processes`

Crée une chronologie CSV des processus suspects.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL
- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats (par défaut : `stdout`)

Options :

- `-l, --level <LEVEL>` : spécifie le niveau d'alerte minimum (par défaut : `high`)
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `timeline-suspicious-processes`

Préparez une chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Recherchez les processus ayant un niveau d'alerte de `high` ou supérieur et affichez les résultats à l'écran :

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Recherchez les processus ayant un niveau d'alerte de `low` ou supérieur et affichez les résultats à l'écran :

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Enregistrez les résultats dans un fichier CSV :

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### Capture d'écran de `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## Commande `timeline-tasks`

Cette commande empile les nouvelles tâches planifiées à partir des événements Security 4698 et analyse le contenu XML des tâches.

* Entrée : JSONL
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier CSV

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-o, --output <CSV-FILE>` : le fichier CSV dans lequel enregistrer les résultats.
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `timeline-tasks`

Sortie vers le terminal :

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Enregistrement au format CSV :

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

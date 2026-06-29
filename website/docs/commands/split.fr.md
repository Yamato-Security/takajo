# Commandes de division

## Commande `split-csv-timeline`

Divise une grande chronologie CSV en plusieurs plus petites en fonction du nom de l'ordinateur.

* Entrée : CSV non multiligne
* Profil : Tous
* Sortie : Plusieurs fichiers CSV

Options requises :

- `-t, --timeline <CSV-FILE>` : chronologie CSV créée par Hayabusa.

Options :

- `-m, --makeMultiline` : affiche les champs sur plusieurs lignes. (par défaut : `false`)
- `-o, --output <DIR>` : répertoire dans lequel enregistrer les fichiers CSV. (par défaut : `output`)
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `split-csv-timeline`

Préparez la chronologie CSV avec Hayabusa :

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Divisez la chronologie CSV unique en plusieurs chronologies CSV dans le répertoire `output` par défaut :

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Séparez les informations des champs avec des caractères de saut de ligne pour créer des entrées multilignes et enregistrez dans le répertoire `case-1-csv` :

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## Commande `split-json-timeline`

Divise une grande chronologie JSONL en plusieurs plus petites en fonction du nom de l'ordinateur.

* Entrée : JSONL
* Profil : Tous
* Sortie : Plusieurs fichiers JSONL

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier ou répertoire de chronologie JSONL Hayabusa.

Options :

- `-o, --output <DIR>` : répertoire dans lequel enregistrer les fichiers JSONL. (par défaut : `output`)
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `split-json-timeline`

Préparez la chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Divisez la chronologie JSONL unique en plusieurs chronologies JSONL dans le répertoire `output` par défaut :

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Enregistrez dans le répertoire `case-1-jsonl` :

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

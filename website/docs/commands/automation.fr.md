# Commandes d'automatisation

## Commande `automagic`

Exécute automatiquement autant de commandes que possible et écrit les résultats dans un nouveau dossier

> Note : Vous devez utiliser le profil `verbose` ou `super-verbose` pour utiliser toutes les commandes.

* Entrée : fichier JSONL ou répertoire de fichiers JSONL
* Profil : tout profil sauf `all-field-info` et `all-field-info-verbose`
* Sortie : un nouveau dossier contenant tous les résultats dans différents fichiers

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier ou répertoire de chronologie JSONL Hayabusa.

Options :

- `-d, --displayTable` : affiche le tableau des résultats (par défaut : `false`)
- `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `low`)
- `-o, --output` : répertoire de sortie (par défaut : `case-1`)
- `-q, --quiet` : n'affiche pas la bannière de lancement (par défaut : `false`)
- `-s, --skipProgressBar` : n'affiche pas la barre de progression (par défaut : `false`)

### Exemples de la commande `automagic`

Préparez la chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Exécutez autant de commandes Takajo que possible et enregistrez les résultats dans le dossier `case-1` :

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Exécutez autant de commandes Takajo que possible sur le répertoire `hayabusa-results` et enregistrez les résultats dans le dossier `case-1` :

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

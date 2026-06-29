# Commandes d'extraction

## Commande `extract-scriptblocks`

Extrait et réassemble les journaux de blocs de script PowerShell EID 4104.

> Note : Les scripts PowerShell s'ouvrent de préférence en tant que fichiers `.ps1` avec coloration syntaxique du code, mais nous utilisons l'extension `.txt` afin d'éviter toute exécution accidentelle de code malveillant.

* Entrée : JSONL
* Profil : N'importe lequel
* Sortie : Terminal et répertoire de scripts PowerShell

Options requises :

- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier ou répertoire de chronologie JSONL Hayabusa

Options :

 - `-l, --level` : spécifie le niveau d'alerte minimum (par défaut : `low`)
 - `-o, --output` : répertoire de sortie (par défaut : `scriptblock-logs`)
 - `-q, --quiet` : ne pas afficher la bannière de lancement (par défaut : `false`)
 - `-s, --skipProgressBar` : ne pas afficher la barre de progression (par défaut : `false`)

### Exemple de commande `extract-scriptblocks`

Préparez la chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Extrayez les journaux de blocs de script PowerShell EID 4104 vers le répertoire `scriptblock-logs` :

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### Capture d'écran de `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

# Commandes de liste

## Commande `list-domains`

Crée une liste de domaines uniques à utiliser avec `vt-domain-lookup`.
Actuellement, elle ne vérifie que les domaines interrogés dans les logs Sysmon EID 22, mais sera mise à jour pour prendre en charge les logs intégrés du client et du serveur DNS de Windows.

* Entrée : JSONL
* Profil : Tout sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Fichier texte

Options requises :

 - `-o, --output <TXT-FILE>` : enregistre les résultats dans un fichier texte.
 - `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier ou répertoire de chronologie JSONL Hayabusa.

Options :

 - `-s, --includeSubdomains` : inclut les sous-domaines (par défaut : `false`)
 - `-w, --includeWorkstations` : inclut les noms des postes de travail locaux (par défaut : `false`)
 - `-q, --quiet` : n'affiche pas le logo (par défaut : `false`)
 - `-s, --skipProgressBar` : n'affiche pas la barre de progression (par défaut : `false`)

### Exemples de la commande `list-domains`

Préparez la chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Enregistrez les résultats dans un fichier texte :

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Incluez les sous-domaines :

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## Commande `list-hashes`

Crée une liste de hachages de processus à utiliser avec vt-hash-lookup (entrée : JSONL, profil : standard)

* Entrée : JSONL
* Profil : Tout sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Fichier texte

Options requises :

 - `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier ou répertoire de fichiers JSONL de chronologie Hayabusa
 - `-o, --output <BASE-NAME>` : spécifie le nom de base pour enregistrer les résultats texte.

Options :

 - `-l, --level` : spécifie le niveau minimum. (par défaut : `high`)
 - `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)
 - `-s, --skipProgressBar` : n'affiche pas la barre de progression (par défaut : `false`)

### Exemples de la commande `list-hashes`

Préparez la chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Enregistrez les résultats dans un fichier texte différent pour chaque type de hachage :

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Par exemple, si des hachages `MD5`, `SHA1` et `IMPHASH` sont stockés dans les logs sysmon, les fichiers suivants seront créés : `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## Commande `list-ip-addresses`

Crée une liste d'adresses IP cibles et/ou sources uniques à utiliser avec `vt-ip-lookup`.
Elle extrait les champs `TgtIP` pour les adresses IP cibles et les champs `SrcIP` pour les adresses IP sources dans tous les résultats et n'affiche que les adresses IP uniques dans un fichier texte.

* Entrée : JSONL
* Profil : Tout sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Fichier texte

Options requises :

 - `-o, --output <TXT-FILE>` : enregistre les résultats dans un fichier texte.
 - `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier ou répertoire de chronologie JSONL Hayabusa.

Options :

 - `-i, --inbound` : inclut le trafic entrant. (par défaut : `true`)
 - `-O, --outbound` : inclut le trafic sortant. (par défaut : `true`)
 - `-p, --privateIp` : inclut les adresses IP privées (par défaut : `false`)
 - `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)
 - `-s, --skipProgressBar` : "n'affiche pas la barre de progression (par défaut : `false`)

### Exemples de la commande `list-ip-addresses`

Préparez la chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Enregistrez les résultats dans un fichier texte :

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Excluez le trafic entrant :

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Incluez les adresses IP privées :

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## Commande `list-undetected-evtx`

Liste tous les fichiers `.evtx` pour lesquels Hayabusa n'avait pas de règle de détection.
Ceci est destiné à être utilisé sur des exemples de fichiers evtx qui contiennent tous des preuves d'activité malveillante, comme les exemples de fichiers evtx du dépôt [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx).

* Entrée : CSV
* Profil : `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Vous devez d'abord exécuter Hayabusa avec un profil qui enregistre les informations de colonne `%EvtxFile%` et enregistrer les résultats dans une chronologie CSV.
  > Vous pouvez voir quelles colonnes Hayabusa enregistre selon les différents profils [ici](https://github.com/Yamato-Security/hayabusa#profiles).
* Sortie : Terminal ou fichier texte

Options requises :

- `-e, --evtx-dir <EVTX-DIR>` : le répertoire des fichiers `.evtx` que vous avez analysés avec Hayabusa.
- `-t, --timeline <CSV-FILE>` : chronologie CSV Hayabusa.

Options :

- `-c, --column-name <CUSTOM-EVTX-COLUMN>` : spécifie un nom de colonne personnalisé pour la colonne evtx. (par défaut : la valeur par défaut de Hayabusa, `EvtxFile`)
- `-o, --output <TXT-FILE>` : enregistre les résultats dans un fichier texte. (par défaut : affichage à l'écran)
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `list-undetected-evtx`

Préparez la chronologie CSV avec Hayabusa :

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Affichez les résultats à l'écran :

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Enregistrez les résultats dans un fichier texte :

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## Commande `list-unused-rules`

Liste toutes les règles de détection `.yml` qui n'ont rien détecté.
Ceci est utile pour aider à déterminer la fiabilité des règles.
C'est-à-dire, quelles règles sont connues pour trouver des activités malveillantes et lesquelles sont encore non testées et nécessitent des exemples de fichiers `.evtx`.

* Entrée : CSV
* Profil : `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Vous devez d'abord exécuter Hayabusa avec un profil qui enregistre les informations de colonne `%RuleFile%` et enregistrer les résultats dans une chronologie CSV.
  > Vous pouvez voir quelles colonnes Hayabusa enregistre selon les différents profils [ici](https://github.com/Yamato-Security/hayabusa#profiles).
* Sortie : Terminal ou fichier texte

Options requises :

- `-r, --rules-dir <DIR>` : le répertoire des fichiers de règles `.yml` que vous avez utilisés avec Hayabusa.
- `-t, --timeline <CSV-FILE>` : chronologie CSV créée par Hayabusa.

Options :

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>` : spécifie un nom de colonne personnalisé pour la colonne du fichier de règle. (par défaut : la valeur par défaut de Hayabusa, `RuleFile`)
- `-o, --output <TXT-FILE>` : enregistre les résultats dans un fichier texte. (par défaut : affichage à l'écran)
- `-q, --quiet` : n'affiche pas le logo. (par défaut : `false`)

### Exemples de la commande `list-unused-rules`

Préparez la chronologie CSV avec Hayabusa :

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Affichez les résultats à l'écran :

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Enregistrez les résultats dans un fichier texte :

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

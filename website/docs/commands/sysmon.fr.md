# Commandes Sysmon

## Commande `sysmon-process-tree`

Affiche l'arborescence des processus d'un certain processus, tel qu'un processus suspect ou malveillant.

* Entrée : JSONL
* Profil : Tout sauf `all-field-info` et `all-field-info-verbose`
* Sortie : Terminal ou fichier texte

Options requises :

- `-p, --processGuid <Process GUID>` : GUID du processus sysmon
- `-t, --timeline <JSONL-FILE-OR-DIR>` : fichier de chronologie JSONL Hayabusa ou répertoire de fichiers JSONL

Options :

- `-o, --output <TXT-FILE>` : un fichier texte dans lequel enregistrer les résultats.
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)

### Exemples de la commande `sysmon-process-tree`

Préparer une chronologie JSONL avec Hayabusa :

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Enregistrer les résultats dans un fichier texte :

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### Capture d'écran de `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

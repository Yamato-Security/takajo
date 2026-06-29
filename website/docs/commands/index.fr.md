# Liste des commandes

## Commandes d'automatisation
* `automagic` : exécute automatiquement autant de commandes que possible et écrit les résultats dans un nouveau dossier

## Commandes d'extraction
* `extract-scriptblocks` : extrait et réassemble les journaux de blocs de script PowerShell EID 4104

## Commandes HTML
* `html-report` : crée des rapports de synthèse HTML statiques
* `html-server` : crée un serveur web dynamique pour consulter les rapports de synthèse HTML

## Commandes de liste
* `list-domains` : crée une liste de domaines uniques à utiliser avec `vt-domain-lookup`
* `list-hashes` : crée une liste de hachages de processus à utiliser avec `vt-hash-lookup`
* `list-ip-addresses` : crée une liste d'adresses IP cibles et/ou sources uniques à utiliser avec `vt-ip-lookup`
* `list-undetected-evtx` : crée une liste de fichiers evtx non détectés
* `list-unused-rules` : crée une liste de règles de détection inutilisées

## Commandes de découpage
* `split-csv-timeline` : découpe une grande chronologie CSV en plusieurs plus petites en fonction du nom de l'ordinateur
* `split-json-timeline` : découpe une grande chronologie JSONL en plusieurs plus petites en fonction du nom de l'ordinateur

## Commandes d'empilement
* `stack-cmdlines` : empile les lignes de commande exécutées
* `stack-computers` : empile les ordinateurs
* `stack-dns` : empile les requêtes et réponses DNS
* `stack-ip-addresses` : empile les adresses IP cibles (champ `TgtIP`) ou les adresses IP sources (champ `SrcIP`)
* `stack-logons` : empile les connexions par utilisateur cible, ordinateur cible, adresse IP source et ordinateur source
* `stack-processes` : empile les processus exécutés
* `stack-services` : empile les noms et chemins de services à partir des événements `System 7040` et `Security 4697`
* `stack-tasks` : empile les nouvelles tâches planifiées à partir des événements `Security 4698` et analyse le contenu XML des tâches
* `stack-users` : empile les utilisateurs cibles (champ `TgtUser`) ou les utilisateurs sources (champ `SrcUser`)

## Commandes Sysmon
* `sysmon-process-tree` : affiche l'arborescence des processus d'un processus donné

## Commandes de chronologie
* `timeline-logon` : crée une chronologie CSV des événements de connexion
* `timeline-partition-diagnostic` : crée une chronologie CSV des événements de diagnostic de partition
* `timeline-suspicious-processes` : crée une chronologie CSV des processus suspects
* `timeline-tasks` : crée une chronologie CSV des tâches planifiées

## Commandes TTP
* `ttp-summary` : résume les tactiques et techniques trouvées sur chaque ordinateur
* `ttp-visualize` : extrait les TTP et crée un fichier JSON à visualiser dans MITRE ATT&CK Navigator
* `ttp-visualize-sigma` : extrait les TTP des règles Sigma et crée un fichier JSON à visualiser dans MITRE ATT&CK Navigator

## Commandes VirusTotal
* `vt-domain-lookup` : recherche une liste de domaines sur VirusTotal et signale les domaines malveillants
* `vt-hash-lookup` : recherche une liste de hachages sur VirusTotal et signale les hachages malveillants
* `vt-ip-lookup` : recherche une liste d'adresses IP sur VirusTotal et signale les adresses IP malveillantes

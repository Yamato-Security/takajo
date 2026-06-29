# Commandes VirusTotal

## Commande `vt-domain-lookup`

Recherche une liste de domaines sur VirusTotal

* Entrée : Fichier texte
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : CSV

Options requises :

- `-a, --apiKey <API-KEY>` : votre clé d'API VirusTotal.
- `-d, --domainList <TXT-FILE>` : un fichier texte contenant une liste de domaines.
- `-o, --output <CSV-FILE>` : enregistre les résultats dans un fichier CSV.

Options :

- `-j, --jsonOutput <JSON-FILE>` : exporte toutes les réponses JSON de VirusTotal dans un fichier JSON.
- `-r, --rateLimit <NUMBER>` : le débit par minute auquel envoyer les requêtes. (par défaut : `4`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)

### Exemples de la commande `vt-domain-lookup`

Créez d'abord une liste de domaines avec la commande `list-domains`.
Recherchez ensuite ces domaines avec ce qui suit :

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## Commande `vt-hash-lookup`

Recherche une liste de hachages sur VirusTotal.

* Entrée : Fichier texte
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : CSV

Options requises :

- `-a, --apiKey <API-KEY>` : votre clé d'API VirusTotal.
- `-H, --hashList <HASH-LIST>` : un fichier texte de hachages.
- `-o, --output <CSV-FILE>` : enregistre les résultats dans un fichier CSV.

Options :

- `-j, --jsonOutput <JSON-FILE>` : exporte toutes les réponses JSON de VirusTotal dans un fichier JSON.
- `-r, --rateLimit <NUMBER>` : le débit par minute auquel envoyer les requêtes. (par défaut : `4`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)

### Exemples de la commande `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## Commande `vt-ip-lookup`

Recherche une liste d'adresses IP sur VirusTotal.

* Entrée : Fichier texte
* Profil : N'importe lequel sauf `all-field-info` et `all-field-info-verbose`
* Sortie : CSV

Options requises :

- `-a, --apiKey <API-KEY>` : votre clé d'API VirusTotal.
- `-i, --ipList <IP-ADDRESS-LIST>` : un fichier texte d'adresses IP.
- `-o, --output <CSV-FILE>` : enregistre les résultats dans un fichier CSV.

Options :

- `-j, --jsonOutput <JSON-FILE>` : exporte toutes les réponses JSON de VirusTotal dans un fichier JSON.
- `-r, --rateLimit <NUMBER>` : le débit par minute auquel envoyer les requêtes. (par défaut : `4`)
- `-q, --quiet` : ne pas afficher le logo. (par défaut : `false`)

### Exemples de la commande `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

# VirusTotal Commands

## `vt-domain-lookup` command

Look up a list of domains on VirusTotal

* Input: Text file
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: CSV

Required options:

- `-a, --apiKey <API-KEY>`: your VirusTotal API key.
- `-d, --domainList <TXT-FILE>`: a text file list of domains.
- `-o, --output <CSV-FILE>`: save the results to a CSV file.

Options:

- `-j, --jsonOutput <JSON-FILE>`: output all of the JSON responses from VirusTotal to a JSON file.
- `-r, --rateLimit <NUMBER>`: the rate per minute to send requests. (default: `4`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `vt-domain-lookup` command examples

First create a list of domains with the `list-domains` command.
Then lookup those domains with the following:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup` command

Look up a list of hashes on VirusTotal.

* Input: Text file
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: CSV

Required options:

- `-a, --apiKey <API-KEY>`: your VirusTotal API key.
- `-H, --hashList <HASH-LIST>`: a text file of hashes.
- `-o, --output <CSV-FILE>`: save the results to a CSV file.

Options:

- `-j, --jsonOutput <JSON-FILE>`: output all of the JSON responses from VirusTotal to a JSON file.
- `-r, --rateLimit <NUMBER>`: the rate per minute to send requests. (default: `4`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `vt-hash-lookup` command examples

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup` command

Look up a list of IP addresses on VirusTotal.

* Input: Text file
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: CSV

Required options:

- `-a, --apiKey <API-KEY>`: your VirusTotal API key.
- `-i, --ipList <IP-ADDRESS-LIST>`: a text file of IP addresses.
- `-o, --output <CSV-FILE>`: save the results to a CSV file.

Options:

- `-j, --jsonOutput <JSON-FILE>`: output all of the JSON responses from VirusTotal to a JSON file.
- `-r, --rateLimit <NUMBER>`: the rate per minute to send requests. (default: `4`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `vt-ip-lookup` command examples

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

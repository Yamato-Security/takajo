# Comandos do VirusTotal

## Comando `vt-domain-lookup`

Consulta uma lista de domínios no VirusTotal

* Entrada: Arquivo de texto
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: CSV

Opções obrigatórias:

- `-a, --apiKey <API-KEY>`: sua chave de API do VirusTotal.
- `-d, --domainList <TXT-FILE>`: um arquivo de texto com uma lista de domínios.
- `-o, --output <CSV-FILE>`: salva os resultados em um arquivo CSV.

Opções:

- `-j, --jsonOutput <JSON-FILE>`: gera todas as respostas JSON do VirusTotal em um arquivo JSON.
- `-r, --rateLimit <NUMBER>`: a taxa por minuto de envio de requisições. (padrão: `4`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `vt-domain-lookup`

Primeiro, crie uma lista de domínios com o comando `list-domains`.
Em seguida, consulte esses domínios da seguinte forma:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## Comando `vt-hash-lookup`

Consulta uma lista de hashes no VirusTotal.

* Entrada: Arquivo de texto
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: CSV

Opções obrigatórias:

- `-a, --apiKey <API-KEY>`: sua chave de API do VirusTotal.
- `-H, --hashList <HASH-LIST>`: um arquivo de texto com hashes.
- `-o, --output <CSV-FILE>`: salva os resultados em um arquivo CSV.

Opções:

- `-j, --jsonOutput <JSON-FILE>`: gera todas as respostas JSON do VirusTotal em um arquivo JSON.
- `-r, --rateLimit <NUMBER>`: a taxa por minuto de envio de requisições. (padrão: `4`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## Comando `vt-ip-lookup`

Consulta uma lista de endereços IP no VirusTotal.

* Entrada: Arquivo de texto
* Profile: Qualquer um, exceto `all-field-info` e `all-field-info-verbose`
* Saída: CSV

Opções obrigatórias:

- `-a, --apiKey <API-KEY>`: sua chave de API do VirusTotal.
- `-i, --ipList <IP-ADDRESS-LIST>`: um arquivo de texto com endereços IP.
- `-o, --output <CSV-FILE>`: salva os resultados em um arquivo CSV.

Opções:

- `-j, --jsonOutput <JSON-FILE>`: gera todas as respostas JSON do VirusTotal em um arquivo JSON.
- `-r, --rateLimit <NUMBER>`: a taxa por minuto de envio de requisições. (padrão: `4`)
- `-q, --quiet`: não exibe o logo. (padrão: `false`)

### Exemplos do comando `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

# Comandos de VirusTotal

## Comando `vt-domain-lookup`

Buscar una lista de dominios en VirusTotal

* Entrada: Archivo de texto
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: CSV

Opciones requeridas:

- `-a, --apiKey <API-KEY>`: tu clave de API de VirusTotal.
- `-d, --domainList <TXT-FILE>`: un archivo de texto con una lista de dominios.
- `-o, --output <CSV-FILE>`: guarda los resultados en un archivo CSV.

Opciones:

- `-j, --jsonOutput <JSON-FILE>`: exporta todas las respuestas JSON de VirusTotal a un archivo JSON.
- `-r, --rateLimit <NUMBER>`: la tasa por minuto con la que enviar solicitudes. (predeterminado: `4`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)

### Ejemplos del comando `vt-domain-lookup`

Primero crea una lista de dominios con el comando `list-domains`.
Luego busca esos dominios con lo siguiente:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## Comando `vt-hash-lookup`

Buscar una lista de hashes en VirusTotal.

* Entrada: Archivo de texto
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: CSV

Opciones requeridas:

- `-a, --apiKey <API-KEY>`: tu clave de API de VirusTotal.
- `-H, --hashList <HASH-LIST>`: un archivo de texto con hashes.
- `-o, --output <CSV-FILE>`: guarda los resultados en un archivo CSV.

Opciones:

- `-j, --jsonOutput <JSON-FILE>`: exporta todas las respuestas JSON de VirusTotal a un archivo JSON.
- `-r, --rateLimit <NUMBER>`: la tasa por minuto con la que enviar solicitudes. (predeterminado: `4`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)

### Ejemplos del comando `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## Comando `vt-ip-lookup`

Buscar una lista de direcciones IP en VirusTotal.

* Entrada: Archivo de texto
* Perfil: Cualquiera excepto `all-field-info` y `all-field-info-verbose`
* Salida: CSV

Opciones requeridas:

- `-a, --apiKey <API-KEY>`: tu clave de API de VirusTotal.
- `-i, --ipList <IP-ADDRESS-LIST>`: un archivo de texto con direcciones IP.
- `-o, --output <CSV-FILE>`: guarda los resultados en un archivo CSV.

Opciones:

- `-j, --jsonOutput <JSON-FILE>`: exporta todas las respuestas JSON de VirusTotal a un archivo JSON.
- `-r, --rateLimit <NUMBER>`: la tasa por minuto con la que enviar solicitudes. (predeterminado: `4`)
- `-q, --quiet`: no mostrar el logo. (predeterminado: `false`)

### Ejemplos del comando `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

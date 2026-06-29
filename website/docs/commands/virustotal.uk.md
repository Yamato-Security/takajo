# Команди VirusTotal

## Команда `vt-domain-lookup`

Пошук списку доменів у VirusTotal

* Вхідні дані: текстовий файл
* Профіль: будь-який, крім `all-field-info` та `all-field-info-verbose`
* Вихідні дані: CSV

Обовʼязкові параметри:

- `-a, --apiKey <API-KEY>`: ваш API-ключ VirusTotal.
- `-d, --domainList <TXT-FILE>`: текстовий файл зі списком доменів.
- `-o, --output <CSV-FILE>`: зберегти результати у файл CSV.

Параметри:

- `-j, --jsonOutput <JSON-FILE>`: вивести всі JSON-відповіді від VirusTotal у файл JSON.
- `-r, --rateLimit <NUMBER>`: частота надсилання запитів за хвилину. (за замовчуванням: `4`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `vt-domain-lookup`

Спочатку створіть список доменів за допомогою команди `list-domains`.
Потім виконайте пошук цих доменів так:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## Команда `vt-hash-lookup`

Пошук списку хешів у VirusTotal.

* Вхідні дані: текстовий файл
* Профіль: будь-який, крім `all-field-info` та `all-field-info-verbose`
* Вихідні дані: CSV

Обовʼязкові параметри:

- `-a, --apiKey <API-KEY>`: ваш API-ключ VirusTotal.
- `-H, --hashList <HASH-LIST>`: текстовий файл із хешами.
- `-o, --output <CSV-FILE>`: зберегти результати у файл CSV.

Параметри:

- `-j, --jsonOutput <JSON-FILE>`: вивести всі JSON-відповіді від VirusTotal у файл JSON.
- `-r, --rateLimit <NUMBER>`: частота надсилання запитів за хвилину. (за замовчуванням: `4`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## Команда `vt-ip-lookup`

Пошук списку IP-адрес у VirusTotal.

* Вхідні дані: текстовий файл
* Профіль: будь-який, крім `all-field-info` та `all-field-info-verbose`
* Вихідні дані: CSV

Обовʼязкові параметри:

- `-a, --apiKey <API-KEY>`: ваш API-ключ VirusTotal.
- `-i, --ipList <IP-ADDRESS-LIST>`: текстовий файл з IP-адресами.
- `-o, --output <CSV-FILE>`: зберегти результати у файл CSV.

Параметри:

- `-j, --jsonOutput <JSON-FILE>`: вивести всі JSON-відповіді від VirusTotal у файл JSON.
- `-r, --rateLimit <NUMBER>`: частота надсилання запитів за хвилину. (за замовчуванням: `4`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

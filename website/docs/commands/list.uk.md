# Команди списків

## Команда `list-domains`

Створює список унікальних доменів для використання з `vt-domain-lookup`.
Наразі вона перевіряє лише запитувані домени в журналах Sysmon EID 22, але буде оновлена для підтримки вбудованих журналів клієнта та сервера Windows DNS.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Текстовий файл

Обов'язкові параметри:

 - `-o, --output <TXT-FILE>`: зберегти результати в текстовий файл.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог хронології Hayabusa у форматі JSONL.

Параметри:

 - `-s, --includeSubdomains`: включати субдомени (за замовчуванням: `false`)
 - `-w, --includeWorkstations`: включати імена локальних робочих станцій (за замовчуванням: `false`)
 - `-q, --quiet`: не відображати логотип (за замовчуванням: `false`)
 - `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `list-domains`

Підготуйте хронологію JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Збережіть результати в текстовий файл:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Включіть субдомени:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## Команда `list-hashes`

Створює список хешів процесів для використання з vt-hash-lookup (вхід: JSONL, профіль: standard)

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Текстовий файл

Обов'язкові параметри:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог файлів JSONL хронології Hayabusa
 - `-o, --output <BASE-NAME>`: вкажіть базове ім'я для збереження текстових результатів.

Параметри:

 - `-l, --level`: вкажіть мінімальний рівень. (за замовчуванням: `high`)
 - `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
 - `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `list-hashes`

Підготуйте хронологію JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Збережіть результати в окремий текстовий файл для кожного типу хешу:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Наприклад, якщо в журналах sysmon зберігаються хеші `MD5`, `SHA1` та `IMPHASH`, то будуть створені такі файли: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## Команда `list-ip-addresses`

Створює список унікальних цільових та/або вихідних IP-адрес для використання з `vt-ip-lookup`.
Вона витягує поля `TgtIP` для цільових IP-адрес та поля `SrcIP` для вихідних IP-адрес у всіх результатах і виводить лише унікальні IP-адреси в текстовий файл.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Текстовий файл

Обов'язкові параметри:

 - `-o, --output <TXT-FILE>`: зберегти результати в текстовий файл.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог хронології Hayabusa у форматі JSONL.

Параметри:

 - `-i, --inbound`: включати вхідний трафік. (за замовчуванням: `true`)
 - `-O, --outbound`: включати вихідний трафік. (за замовчуванням: `true`)
 - `-p, --privateIp`: включати приватні IP-адреси (за замовчуванням: `false`)
 - `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
 - `-s, --skipProgressBar`: "не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `list-ip-addresses`

Підготуйте хронологію JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Збережіть результати в текстовий файл:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Виключіть вхідний трафік:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Включіть приватні IP-адреси:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## Команда `list-undetected-evtx`

Перелічує всі файли `.evtx`, для яких у Hayabusa не було правила виявлення.
Це призначено для використання на зразкових файлах evtx, що містять докази шкідливої активності, таких як зразкові файли evtx у репозиторії [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx).

* Вхід: CSV
* Профіль: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Спочатку потрібно запустити Hayabusa з профілем, який зберігає інформацію стовпця `%EvtxFile%`, і зберегти результати в хронологію CSV.
  > Ви можете побачити, які стовпці зберігає Hayabusa відповідно до різних профілів, [тут](https://github.com/Yamato-Security/hayabusa#profiles).
* Вихід: Термінал або текстовий файл

Обов'язкові параметри:

- `-e, --evtx-dir <EVTX-DIR>`: Каталог файлів `.evtx`, які ви сканували за допомогою Hayabusa.
- `-t, --timeline <CSV-FILE>`: Хронологія Hayabusa у форматі CSV.

Параметри:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: вкажіть користувацьке ім'я стовпця для стовпця evtx. (за замовчуванням: значення Hayabusa за замовчуванням `EvtxFile`)
- `-o, --output <TXT-FILE>`: зберегти результати в текстовий файл. (за замовчуванням: вивід на екран)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `list-undetected-evtx`

Підготуйте хронологію CSV за допомогою Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Виведіть результати на екран:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Збережіть результати в текстовий файл:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## Команда `list-unused-rules`

Перелічує всі правила виявлення `.yml`, які нічого не виявили.
Це корисно для визначення надійності правил.
Тобто, які правила, як відомо, знаходять шкідливу активність, а які ще не перевірені та потребують зразкових файлів `.evtx`.

* Вхід: CSV
* Профіль: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Спочатку потрібно запустити Hayabusa з профілем, який зберігає інформацію стовпця `%RuleFile%`, і зберегти результати в хронологію CSV.
  > Ви можете побачити, які стовпці зберігає Hayabusa відповідно до різних профілів, [тут](https://github.com/Yamato-Security/hayabusa#profiles).
* Вихід: Термінал або текстовий файл

Обов'язкові параметри:

- `-r, --rules-dir <DIR>`: каталог файлів правил `.yml`, які ви використовували з Hayabusa.
- `-t, --timeline <CSV-FILE>`: Хронологія CSV, створена Hayabusa.

Параметри:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: вкажіть користувацьке ім'я стовпця для стовпця файлу правила. (за замовчуванням: значення Hayabusa за замовчуванням `RuleFile`)
- `-o, --output <TXT-FILE>`: зберегти результати в текстовий файл. (за замовчуванням: вивід на екран)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `list-unused-rules`

Підготуйте хронологію CSV за допомогою Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Виведіть результати на екран:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Збережіть результати в текстовий файл:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

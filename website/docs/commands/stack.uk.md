# Команди Stack

## Команда `stack-cmdlines`

Ця команда формує стек виконаних командних рядків, витягуючи інформацію з подій `Sysmon 1` та `Security 4688`.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-y, --ignoreSysmon`: виключити події Sysmon 1 (за замовчуванням: `false`)
- `-e, --ignoreSecurity`: виключити події Security 4688 (за замовчуванням: `false`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-cmdlines`

Вивід у термінал:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## Команда `stack-computers`

Ця команда формує стек імен хостів комп'ютерів відповідно до поля `Computer`.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-c, --sourceComputers`: формувати стек комп'ютерів-джерел замість цільових комп'ютерів (за замовчуванням: false)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-computers`

Вивід у термінал:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## Команда `stack-dns`

Ця команда формує стек DNS-запитів та відповідей з подій Sysmon 22.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-dns`

Вивід у термінал:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## Команда `stack-ip-addresses`

Ця команда формує стек цільових IP-адрес (поле `TgtIP`) або IP-адрес джерел (поле `SrcIP`).

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-a, --targetIpAddresses`: формувати стек цільових IP-адрес замість IP-адрес джерел (за замовчуванням: `false`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-ip-addresses`

Вивід у термінал:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## Команда `stack-logons`

Створює список входів у систему відповідно до `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
За замовчуванням результати відфільтровуються, коли IP-адреса джерела є локальною IP-адресою.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --localSrcIpAddresses`: включати результати, коли IP-адреса джерела є локальною.
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-logons`

Запуск з налаштуваннями за замовчуванням:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Включити локальні входи у систему:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## Команда `stack-processes`

Ця команда формує стек виконаних процесів з подій Sysmon 1 та Security 4688.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `low`)
- `-y, --ignoreSysmon`: виключити події Sysmon 1 (за замовчуванням: `false`)
- `-e, --ignoreSecurity`: виключити події Security 4688 (за замовчуванням: `false`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-processes`

Вивід у термінал:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## Команда `stack-services`

Ця команда формує стек імен та шляхів служб з подій System 7040 та Security 4697.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-y, --ignoreSystem`: виключити події System 7040 (за замовчуванням: `false`)
- `-e, --ignoreSecurity`: виключити події Security 4697 (за замовчуванням: `false`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-services`

Вивід у термінал:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## Команда `stack-tasks`

Ця команда формує стек нових запланованих завдань з подій Security 4698 та розбирає XML-вміст завдання.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-tasks`

Вивід у термінал:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## Команда `stack-users`

Ця команда формує стек цільових користувачів (поле `TgtUser` (за замовчуванням)) або користувачів-джерел (поле `SrcUser`) у будь-якій події, що містить ці поля, а також відображає інформацію про сповіщення.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV-файл

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Файл часової шкали Hayabusa у форматі JSONL або каталог JSONL-файлів

Опції:

- `-s, --sourceUsers`: формувати стек користувачів-джерел замість цільових користувачів (за замовчуванням: false)
- `-c, --filterComputerAccounts`: відфільтрувати облікові записи комп'ютерів (за замовчуванням: true)
- `-f, --filterSystemAccounts`: відфільтрувати системні облікові записи (за замовчуванням: true)
- `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `informational`)
- `-o, --output <CSV-FILE>`: CSV-файл для збереження результатів (за замовчуванням: `stdout`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)
- `-s, --skipProgressBar`: не відображати індикатор прогресу (за замовчуванням: `false`)

### Приклади команди `stack-users`

Вивід у термінал:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

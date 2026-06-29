# Команди Timeline

## Команда `timeline-logon`

Ця команда витягує інформацію з наведених нижче подій входу, нормалізує поля та зберігає результати у файл CSV:

- `4624` - Успішний вхід
- `4625` - Невдалий вхід
- `4634` - Вихід з облікового запису
- `4647` - Вихід, ініційований користувачем
- `4648` - Явний вхід
- `4672` - Вхід адміністратора

Це полегшує виявлення латерального переміщення, вгадування/розпилення паролів, підвищення привілеїв тощо...

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: CSV

Обов'язкові опції:

- `-o, --output <CSV-FILE>`: файл CSV для збереження результатів.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa JSONL або каталог файлів JSONL

Опції:

- `-c, --calculateElapsedTime`: обчислити час, що минув, для успішних входів. (за замовчуванням: `true`)
- `-l, --outputLogoffEvents`: виводити події виходу як окремі записи. (за замовчуванням: `false`)
- `-a, --outputAdminLogonEvents`: виводити події входу адміністратора як окремі записи. (за замовчуванням: `false`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `timeline-logon`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Збережіть часову шкалу входів у файл CSV:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### Знімок екрана `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## Команда `timeline-partition-diagnostic`

Створює часову шкалу CSV подій діагностики розділів шляхом аналізу файлів Windows 10 `Microsoft-Windows-Partition%4Diagnostic.evtx` та звітування про всі підключені пристрої та їхні серійні номери томів (Volume Serial Numbers), як ті, що наразі присутні на пристрої, так і ті, що існували раніше.
Цей процес базується на інструменті [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Вхід: JSONL
* Профіль: Будь-який
* Вихід: Термінал або CSV

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa JSONL або каталог файлів JSONL

Опції:

- `-o, --output <CSV-FILE>`: файл CSV для збереження результатів.
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `timeline-partition-diagnostic`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Створіть часову шкалу CSV підключених пристроїв:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## Команда `timeline-suspicious-processes`

Створіть часову шкалу CSV підозрілих процесів.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або CSV

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa JSONL або каталог файлів JSONL
- `-o, --output <CSV-FILE>`: файл CSV для збереження результатів (за замовчуванням: `stdout`)

Опції:

- `-l, --level <LEVEL>`: вказати мінімальний рівень сповіщення (за замовчуванням: `high`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `timeline-suspicious-processes`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Знайдіть процеси, що мали рівень сповіщення `high` або вищий, і виведіть результати на екран:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Знайдіть процеси, що мали рівень сповіщення `low` або вищий, і виведіть результати на екран:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Збережіть результати у файл CSV:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### Знімок екрана `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## Команда `timeline-tasks`

Ця команда складає нові заплановані завдання з подій Security 4698 та аналізує вміст завдання у форматі XML.

* Вхід: JSONL
* Профіль: Будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихід: Термінал або файл CSV

Обов'язкові опції:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa JSONL або каталог файлів JSONL

Опції:

- `-o, --output <CSV-FILE>`: файл CSV для збереження результатів.
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `timeline-tasks`

Вивід у термінал:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Збереження у CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

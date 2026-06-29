# Команди розділення

## Команда `split-csv-timeline`

Розділити велику хронологію CSV на менші на основі імені комп'ютера.

* Вхідні дані: Однорядковий CSV
* Профіль: Будь-який
* Вихідні дані: Декілька файлів CSV

Обов'язкові параметри:

- `-t, --timeline <CSV-FILE>`: хронологія CSV, створена Hayabusa.

Параметри:

- `-m, --makeMultiline`: виводити поля в декількох рядках. (за замовчуванням: `false`)
- `-o, --output <DIR>`: каталог для збереження файлів CSV. (за замовчуванням: `output`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `split-csv-timeline`

Підготуйте хронологію CSV за допомогою Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Розділіть єдину хронологію CSV на декілька хронологій CSV у каталозі `output` за замовчуванням:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Розділіть інформацію полів символами нового рядка, щоб створити багаторядкові записи, та збережіть у каталог `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## Команда `split-json-timeline`

Розділити велику хронологію JSONL на менші на основі імені комп'ютера.

* Вхідні дані: JSONL
* Профіль: Будь-який
* Вихідні дані: Декілька файлів JSONL

Обов'язкові параметри:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог хронології JSONL Hayabusa.

Параметри:

- `-o, --output <DIR>`: каталог для збереження файлів JSONL. (за замовчуванням: `output`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `split-json-timeline`

Підготуйте хронологію JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Розділіть єдину хронологію JSONL на декілька хронологій JSONL у каталозі `output` за замовчуванням:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Збережіть у каталог `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

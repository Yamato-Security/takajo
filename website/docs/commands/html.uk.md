# Команди HTML

## Команда `html-report`

Створює зведені звіти HTML для правил і комп'ютерів із виявленнями.
Ця команда спочатку створює індексований файл бази даних DuckDB (за замовчуванням) або файл бази даних SQLite, щоб виконувати швидкий пошук даних, потрібних для створення зведених звітів.

* Вхідні дані: JSONL
* Профіль: будь-який докладний профіль
* Вихідні дані: окремі зведені звіти HTML на основі імені комп'ютера, а також головна сторінка `index.html`

Обов'язкові параметри:

- `-o, --output`: ім'я каталогу звіту html
- `-r, --rulepath`: шлях до каталогу правил Hayabusa
- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог часової шкали Hayabusa JSONL

Параметри:

- `-C, --clobber`: перезаписувати файл бази даних під час збереження (за замовчуванням: `false`)
- `-q, --quiet`: не відображати банер запуску (за замовчуванням: `false`)
- `-s, --dboutput`: зберігати результати у файл бази даних (за замовчуванням: `html-report.duckdb` або `html-report.sqlite` з `--sqlite`)
- `--skipProgressBar`: не відображати індикатор виконання (за замовчуванням: `false`)
- `--sqlite`: використовувати бекенд SQLite замість DuckDB (за замовчуванням: `false`)

### Приклад команди `html-report`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

або

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Створіть зведені звіти HTML:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### Знімки екрана `html-report`

#### Зведення за правилами

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Зведення за комп'ютерами

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Список правил

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## Команда `html-server`

Створює динамічний вебсервер для перегляду зведених звітів HTML.
Ця команда спочатку створює індексований файл бази даних DuckDB (за замовчуванням) або файл бази даних SQLite, щоб виконувати швидкий пошук даних, потрібних для створення зведених звітів.
Вона схожа на команду `html-report`, але краще масштабується та дозволяє фільтрувати за датами й правилами.

* Вхідні дані: JSONL
* Профіль: будь-який докладний профіль
* Вихідні дані: за замовчуванням слухатиме на `http://localhost:8823`

Обов'язкові параметри:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог часової шкали Hayabusa JSONL

Параметри:

- `-C, --clobber`: перезаписувати файл бази даних під час збереження (за замовчуванням: `false`)
- `-p, --port`: номер порту вебсервера (за замовчуванням: `8823`)
- `-q, --quiet`: не відображати банер запуску (за замовчуванням: `false`)
- `-r, --rulepath`: шлях до каталогу правил Hayabusa (це необов'язково, але потрібно для створення правильних посилань на файли правил)
- `-s, --dboutput`: зберігати результати у файл бази даних (за замовчуванням: `html-report.duckdb` або `html-report.sqlite` з `--sqlite`)
- `--skipProgressBar`: не відображати індикатор виконання (за замовчуванням: `false`)
- `--sqlite`: використовувати бекенд SQLite замість DuckDB (за замовчуванням: `false`)

### Приклад команди `html-report`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

або

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Запустіть вебсервер:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### Знімки екрана `html-server`

#### Список правил

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Зведення за комп'ютерами

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Фільтрування правил

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Фільтрування правил

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

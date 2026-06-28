# HTML Commands

## `html-report` command

Create HTML summary reports for rules and computers with detections.
This command first creates an indexed DuckDB database file (default) or SQLite database file in order to perform fast lookups on the data needed to create the summary reports.

* Input: JSONL
* Profile: Any verbose profile
* Output: Individual HTML summary reports based on computer name as well as an `index.html` main page

Required options:

- `-o, --output`: html report directory name
- `-r, --rulepath`: path to the Hayabusa rules directory
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory

Options:

- `-C, --clobber`: overwrite the database file when saving (default: `false`)
- `-q, --quiet`: do not display the launch banner (default: `false`)
- `-s, --dboutput`: save results to a database file (default: `html-report.duckdb` or `html-report.sqlite` with `--sqlite`)
- `--skipProgressBar`: do not display the progress bar (default: `false`)
- `--sqlite`: use SQLite backend instead of DuckDB (default: `false`)

### `html-report` command example

Prepare the JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

or

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Create the HTML summary reports:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report` screenshots

#### Rule Summary

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Computer Summary

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Rule List

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server` command

Create a dynamic web server to view HTML summary reports.
This command first creates an indexed DuckDB database file (default) or SQLite database file in order to perform fast lookups on the data needed to create the summary reports.
It is similar to the `html-report` command but is more scalable and allows for filtering on dates and rules.

* Input: JSONL
* Profile: Any verbose profile
* Output: By default, will listen on `http://localhost:8823`

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory

Options:

- `-C, --clobber`: overwrite the database file when saving (default: `false`)
- `-p, --port`: web server port number (default: `8823`)
- `-q, --quiet`: do not display the launch banner (default: `false`)
- `-r, --rulepath`: path to the Hayabusa rules directory (this is optional but needed to create correct links to the rule files)
- `-s, --dboutput`: save results to a database file (default: `html-report.duckdb` or `html-report.sqlite` with `--sqlite`)
- `--skipProgressBar`: do not display the progress bar (default: `false`)
- `--sqlite`: use SQLite backend instead of DuckDB (default: `false`)

### `html-report` command example

Prepare the JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

or

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Start the web server:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server` screenshots

#### Rules List

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Computer Summary

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Rule Filtering

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Rule Filtering

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

# Timeline Commands

## `timeline-logon` command

This command extracts information from the following logon events, normalizes the fields and saves the results to a CSV file:

- `4624` - Successful Logon
- `4625` - Failed Logon
- `4634` - Account Logoff
- `4647` - User Initiated Logoff
- `4648` - Explicit Logon
- `4672` - Admin Logon

This makes it easier to detect lateral movement, password guessing/spraying, privilege escalation, etc...

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: CSV

Required options:

- `-o, --output <CSV-FILE>`: the CSV file to save the results to.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-c, --calculateElapsedTime`: calculate the elapsed time for successful logons. (default: `true`)
- `-l, --outputLogoffEvents`: output logoff events as separate entries. (default: `false`)
- `-a, --outputAdminLogonEvents`: output admin logon events as separate entries. (default: `false`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `timeline-logon` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Save logon timeline to a CSV file:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-logon` screenshot

![timeline-logon](../assets/screenshots/timeline-logon.png)

## `timeline-partition-diagnostic` command

Creates a CSV timeline of partition diagnostic events by parsing Windows 10 `Microsoft-Windows-Partition%4Diagnostic.evtx` files and reporting information about all the connected devices and their Volume Serial Numbers, both currently present on the device and previously existed.
This process is based on the tool [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Input: JSONL
* Profile: Any
* Output: Terminal or CSV

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-o, --output <CSV-FILE>`: the CSV file to save the results to.
- `-q, --quiet`: do not display logo. (default: `false`)

### `timeline-partition-diagnostic` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Create a CSV timeline of connected devices:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## `timeline-suspicious-processes` command

Create a CSV timeline of suspicious processes.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)

Options:

- `-l, --level <LEVEL>`: specify the minimum alert level (default: `high`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `timeline-suspicious-processes` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Search for processes that had an alert level of `high` or above and output results to screen:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Search for processes that had an alert level of `low` or above and output results to screen:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Save the results to a CSV file:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### `timeline-suspicious-processes` screenshot

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## `timeline-tasks` command

This command will stack new scheduled tasks from Security 4698 events and parse out the XML task content.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-o, --output <CSV-FILE>`: the CSV file to save the results to.
- `-q, --quiet`: do not display logo. (default: `false`)

### `timeline-tasks` command examples

Output to terminal:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

# Stack Commands

## `stack-cmdlines` command

This command will stack executed command lines by extracting information from `Sysmon 1` and `Security 4688` events.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-y, --ignoreSysmon`: exclude Sysmon 1 events (default: `false`)
- `-e, --ignoreSecurity`: exclude Security 4688 events (default: `false`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-cmdlines` command examples

Output to terminal:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers` command

This command will stack computer hostnames according to the `Computer` field.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-c, --sourceComputers`: stack source computers instead of target computers (default: false)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-computers` command examples

Output to terminal:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns` command

This command will stack DNS queries and responses from Sysmon 22 events.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-dns` command examples

Output to terminal:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses` command

This command will stack the target IP addresses (`TgtIP` field) or source IP addresses (`SrcIP` field).

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-a, --targetIpAddresses`: stack target IP addresses instead of source IP addresses (default: `false`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-ip-addresses` command examples

Output to terminal:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons` command

Creates a list logons according to `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
Results are filtered out when the source IP address is a local IP address by default.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --localSrcIpAddresses`: include results when the source IP address is local.
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-logons` command examples

Run with default settings:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Include local logons:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes` command

This command will stack executed processes from Sysmon 1 and Security 4688 events.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `low`)
- `-y, --ignoreSysmon`: exclude Sysmon 1 events (default: `false`)
- `-e, --ignoreSecurity`: exclude Security 4688 events (default: `false`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-processes` command examples

Output to terminal:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services` command

This command will stack service names and paths from System 7040 and Security 4697 events.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-y, --ignoreSystem`: exclude System 7040 events (default: `false`)
- `-e, --ignoreSecurity`: exclude Security 4697 events (default: `false`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-services` command examples

Output to terminal:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks` command

This command will stack new scheduled tasks from Security 4698 events and parse out the XML task content.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-tasks` command examples

Output to terminal:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users` command

This command will stack the target users (`TgtUser` field (default)) or source users (`SrcUser` field) in any event that has those fields as well as show alert information.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or CSV file

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-s, --sourceUsers`: stack source users instead of target users (default: false)
- `-c, --filterComputerAccounts`: filter out computer accounts (default: true)
- `-f, --filterSystemAccounts`: filter out system accounts (default: true)
- `-l, --level`: specify the minimum alert level (default: `informational`)
- `-o, --output <CSV-FILE>`: the CSV file to save the results to (default: `stdout`)
- `-q, --quiet`: do not display logo. (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `stack-users` command examples

Output to terminal:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

Save to CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

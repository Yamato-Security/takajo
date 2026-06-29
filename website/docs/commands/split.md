# Split Commands

## `split-csv-timeline` command

Split up a large CSV timeline into smaller ones based on the computer name.

* Input: Non-multiline CSV
* Profile: Any
* Output: Multiple CSV files

Required options:

- `-t, --timeline <CSV-FILE>`: CSV timeline created by Hayabusa.

Options:

- `-m, --makeMultiline`: output fields in multiple lines. (default: `false`)
- `-o, --output <DIR>`: directory to save the CSV files to. (default: `output`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `split-csv-timeline` command examples

Prepare the CSV timeline with Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Split the single CSV timeline into multiple CSV timelines in the default `output` directory:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Separate field information with newline characters to make multi-line entries and save to the `case-1-csv` directory:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline` command

Split up a large JSONL timeline into smaller ones based on the computer name.

* Input: JSONL
* Profile: Any
* Output: Multiple JSONL files

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory.

Options:

- `-o, --output <DIR>`: directory to save the JSONL files to. (default: `output`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `split-json-timeline` command examples

Prepare the JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Split the single JSONL timeline into multiple JSONL timelines in the default `output` directory:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Save to the `case-1-jsonl` directory:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

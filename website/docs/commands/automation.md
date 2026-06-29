# Automation Commands

## `automagic` command

Automatically executes as many commands as possible and output results to a new folder

> Note: You should use the `verbose` or `super-verbose` profile to utilize all commands.

* Input: JSONL file or directory of JSONL files
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: A new folder with all of the results in different files

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory.

Options:

- `-d, --displayTable`: display the results table (default: `false`)
- `-l, --level`: specify the minimum alert level (default: `low`)
- `-o, --output`: output directory (default: `case-1`)
- `-q, --quiet`: do not display the launch banner (default: `false`)
- `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `automagic` command examples

Prepare the JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Run as many Takajo commands as possible and save results under the `case-1` folder:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Run as many Takajo commands as possible on the `hayabusa-results` directory and save results under the `case-1` folder:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

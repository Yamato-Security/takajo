# Sysmon Commands

## `sysmon-process-tree` command

Output the process tree of a certain process, such as a suspicious or malicious process.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Terminal or text file

Required options:

- `-p, --processGuid <Process GUID>`: sysmon process GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-o, --output <TXT-FILE>`: a text file to save the results to.
- `-q, --quiet`: do not display logo. (default: `false`)

### `sysmon-process-tree` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Save the results to a text file:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree` screenshot

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

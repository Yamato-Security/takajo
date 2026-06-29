# List Commands

## `list-domains` command

Creates a list of unique domains to be used with `vt-domain-lookup`.
Currently it will only check queried domains in Sysmon EID 22 logs but will be updated to support built-in Windows DNS Client and Server logs.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Text file

Required options:

 - `-o, --output <TXT-FILE>`: save results to a text file.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory.

Options:

 - `-s, --includeSubdomains`: include subdomains (default: `false`)
 - `-w, --includeWorkstations`: include local workstation names (default: `false`)
 - `-q, --quiet`: do not display logo (default: `false`)
 - `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `list-domains` command examples

Prepare the JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Save the results to a text file:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Include subdomains:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes` command

Create a list of process hashes to be used with vt-hash-lookup (input: JSONL, profile: standard)

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Text file

Required options:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files
 - `-o, --output <BASE-NAME>`: specify the base name to save the text results to.

Options:

 - `-l, --level`: specify the minimum level. (default: `high`)
 - `-q, --quiet`: do not display logo. (default: `false`)
 - `-s, --skipProgressBar`: do not display the progress bar (default: `false`)

### `list-hashes` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Save the results to a different text file for each hash type:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

For example, if `MD5`, `SHA1` and `IMPHASH` hashes are stored in the sysmon logs, then the following files will be created: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses` command

Creates a list of unique target and/or source IP addresses to be used with `vt-ip-lookup`.
It will extract the `TgtIP` fields for target IP addresses and `SrcIP` fields for source IP addresses in all results and output just the unique IP addresses to a text file.

* Input: JSONL
* Profile: Any besides `all-field-info` and `all-field-info-verbose`
* Output: Text file

Required options:

 - `-o, --output <TXT-FILE>`: save results to a text file.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory.

Options:

 - `-i, --inbound`: include inbound traffic. (default: `true`)
 - `-O, --outbound`: include outbound traffic. (default: `true`)
 - `-p, --privateIp`: include private IP addresses (default: `false`)
 - `-q, --quiet`: do not display logo. (default: `false`)
 - `-s, --skipProgressBar`: "do not display the progress bar (default: `false`)

### `list-ip-addresses` command examples

Prepare the JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Save the results to a text file:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Exclude inbound traffic:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Include private IP addresses:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx` command

List up all of the `.evtx` files that Hayabusa didn't have a detection rule for.
This is meant to be used on sample evtx files that all contain evidence of malicious activity such as the sample evtx files in the [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) repository.

* Input: CSV
* Profile: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > You first need to run Hayabusa with a profile that saves the `%EvtxFile%` column information and save the results to a CSV timeline.
  > You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).
* Output: Terminal or text file

Required options:

- `-e, --evtx-dir <EVTX-DIR>`: The directory of `.evtx` files you scanned with Hayabusa.
- `-t, --timeline <CSV-FILE>`: Hayabusa CSV timeline.

Options:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: specify a custom column name for the evtx column. (default: Hayabusa's default of `EvtxFile`)
- `-o, --output <TXT-FILE>`: save the results to a text file. (default: output to screen)
- `-q, --quiet`: do not display logo. (default: `false`)

### `list-undetected-evtx` command examples

Prepare the CSV timeline with Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Output the results to screen:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Save the results to a text file:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules` command

List up all of the `.yml` detection rules that did not detect anything.
This is useful to help determine the reliablity of rules.
That is, which rules are known to find malicious activity and which are still untested and need sample `.evtx` files.

* Input: CSV
* Profile: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > You first need to run Hayabusa with a profile that saves the `%RuleFile%` column information and save the results to a CSV timeline.
  > You can see which columns Hayabusa saves according to the different profiles [here](https://github.com/Yamato-Security/hayabusa#profiles).
* Output: Termianl or text file

Required options:

- `-r, --rules-dir <DIR>`: the directory of `.yml` rules files you used with Hayabusa.
- `-t, --timeline <CSV-FILE>`: CSV timeline created by Hayabusa.

Options:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: specify a custom column name for the rule file column. (default: Hayabusa's default of `RuleFile`)
- `-o, --output <TXT-FILE>`: save the results to a text file. (default: output to screen)
- `-q, --quiet`: do not display logo. (default: `false`)

### `list-unused-rules` command examples

Prepare the CSV timeline with Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Output the results to screen:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Save the results to a text file:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

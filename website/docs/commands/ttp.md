# TTP Commands

## `ttp-summary` command

This command summarize tactics and techniques found in each computer according to the MITRE ATT&CK TTPs defined in the `tags` field of the sigma rules.

* Input: JSONL
* Profile: A profile that outputs `%MitreTactics%` and `%MitreTags%` fields. (Ex: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Output: Terminal or CSV

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-o, --output <CSV-FILE>`: the CSV file to save the results to.
- `-q, --quiet`: do not display logo. (default: `false`)

### `ttp-summary` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Print TTP summary to terminal:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Save the results to a CSV file:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary` screenshot

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize` command

This command extracts TTPs and create a JSON file to visualize in [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Input: JSONL
* Profile: A profile that outputs `%MitreTactics%` and `%MitreTags%` fields. (Ex: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Output: JSON

Required options:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file or directory of JSONL files

Options:

- `-o, --output <JSON-FILE>`: the JSON file to save the results to. (default: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `ttp-visualize` command examples

Prepare JSONL timeline with Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Extract out the TTPs and save to `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

Open [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), click `Open Existing Layer` and upload the saved JSON file.

### `ttp-visualize` screenshot

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma` command

This command extracts TTPs from Sigma and create a JSON file to visualize in [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Input: Sigma rules directory
* Output: JSON

Required options:

- `-r, --ruleDir <SIGMA-DIR>`: Sigma rules directory

Options:

- `-o, --output <JSON-FILE>`: the JSON file to save the results to. (default: `mitre-attack-navigator.json`)
- `-q, --quiet`: do not display logo. (default: `false`)

### `ttp-visualize-sigma` command examples

Clone the Sigma repository:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Extract out the TTPs from Sigma and save to `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

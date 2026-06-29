# TTP 指令

## `ttp-summary` 指令

此指令會依據 sigma 規則中 `tags` 欄位所定義的 MITRE ATT&CK TTP，彙總在各台電腦中發現的戰術與技術。

* 輸入：JSONL
* Profile：可輸出 `%MitreTactics%` 與 `%MitreTags%` 欄位的 profile。（例如：`verbose`、`all-field-info-verbose`、`super-verbose`）
* 輸出：終端機或 CSV

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa 的 JSONL 時間軸檔案，或包含多個 JSONL 檔案的目錄

選項：

- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案。
- `-q, --quiet`：不顯示 logo。（預設值：`false`）

### `ttp-summary` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

將 TTP 彙總列印到終端機：

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

將結果儲存到 CSV 檔案：

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary` 螢幕截圖

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize` 指令

此指令會擷取 TTP 並建立一個 JSON 檔案，以便在 [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) 中進行視覺化呈現。

* 輸入：JSONL
* Profile：可輸出 `%MitreTactics%` 與 `%MitreTags%` 欄位的 profile。（例如：`verbose`、`all-field-info-verbose`、`super-verbose`）
* 輸出：JSON

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa 的 JSONL 時間軸檔案，或包含多個 JSONL 檔案的目錄

選項：

- `-o, --output <JSON-FILE>`：用來儲存結果的 JSON 檔案。（預設值：`mitre-ttp-heatmap.json`）
- `-q, --quiet`：不顯示 logo。（預設值：`false`）

### `ttp-visualize` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

擷取 TTP 並儲存到 `mitre-ttp-heatmap.json`：

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

開啟 [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/)，點選 `Open Existing Layer` 並上傳已儲存的 JSON 檔案。

### `ttp-visualize` 螢幕截圖

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma` 指令

此指令會從 Sigma 擷取 TTP 並建立一個 JSON 檔案，以便在 [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) 中進行視覺化呈現。

* 輸入：Sigma 規則目錄
* 輸出：JSON

必要選項：

- `-r, --ruleDir <SIGMA-DIR>`：Sigma 規則目錄

選項：

- `-o, --output <JSON-FILE>`：用來儲存結果的 JSON 檔案。（預設值：`mitre-attack-navigator.json`）
- `-q, --quiet`：不顯示 logo。（預設值：`false`）

### `ttp-visualize-sigma` 指令範例

複製 Sigma 儲存庫：

```
git clone https://github.com/SigmaHQ/sigma.git
```

從 Sigma 擷取 TTP 並儲存到 `mitre-attack-navigator.json`：

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

# 分割指令

## `split-csv-timeline` 指令

依據電腦名稱將大型 CSV 時間軸分割成較小的檔案。

* 輸入：非多行 CSV
* 設定檔：任意
* 輸出：多個 CSV 檔案

必要選項：

- `-t, --timeline <CSV-FILE>`：由 Hayabusa 建立的 CSV 時間軸。

選項：

- `-m, --makeMultiline`：以多行方式輸出欄位。（預設：`false`）
- `-o, --output <DIR>`：用來儲存 CSV 檔案的目錄。（預設：`output`）
- `-q, --quiet`：不顯示標誌。（預設：`false`）

### `split-csv-timeline` 指令範例

使用 Hayabusa 準備 CSV 時間軸：

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

將單一 CSV 時間軸分割成多個 CSV 時間軸，並存放於預設的 `output` 目錄：

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

以換行字元分隔欄位資訊以建立多行項目，並儲存至 `case-1-csv` 目錄：

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline` 指令

依據電腦名稱將大型 JSONL 時間軸分割成較小的檔案。

* 輸入：JSONL
* 設定檔：任意
* 輸出：多個 JSONL 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或目錄。

選項：

- `-o, --output <DIR>`：用來儲存 JSONL 檔案的目錄。（預設：`output`）
- `-q, --quiet`：不顯示標誌。（預設：`false`）

### `split-json-timeline` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

將單一 JSONL 時間軸分割成多個 JSONL 時間軸，並存放於預設的 `output` 目錄：

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

儲存至 `case-1-jsonl` 目錄：

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

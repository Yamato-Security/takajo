# 自動化指令

## `automagic` 指令

自動執行盡可能多的指令，並將結果輸出至新資料夾

> 注意：您應使用 `verbose` 或 `super-verbose` 設定檔以充分運用所有指令。

* 輸入：JSONL 檔案或包含 JSONL 檔案的目錄
* 設定檔：除 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：包含所有結果（分散於不同檔案）的新資料夾

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 時間軸檔案或目錄。

選項：

- `-d, --displayTable`: 顯示結果表格（預設：`false`）
- `-l, --level`: 指定最低警示等級（預設：`low`）
- `-o, --output`: 輸出目錄（預設：`case-1`）
- `-q, --quiet`: 不顯示啟動橫幅（預設：`false`）
- `-s, --skipProgressBar`: 不顯示進度條（預設：`false`）

### `automagic` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

執行盡可能多的 Takajo 指令，並將結果儲存於 `case-1` 資料夾下：

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

對 `hayabusa-results` 目錄執行盡可能多的 Takajo 指令，並將結果儲存於 `case-1` 資料夾下：

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

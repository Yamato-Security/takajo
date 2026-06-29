# 時間軸指令

## `timeline-logon` 指令

此指令會從下列登入事件中擷取資訊、正規化欄位，並將結果儲存為 CSV 檔案：

- `4624` - 登入成功
- `4625` - 登入失敗
- `4634` - 帳戶登出
- `4647` - 使用者主動登出
- `4648` - 明確登入
- `4672` - 管理員登入

這讓偵測橫向移動、密碼猜測／噴灑、權限提升等行為更為容易……

* 輸入：JSONL
* Profile：除 `all-field-info` 與 `all-field-info-verbose` 以外的任何 Profile
* 輸出：CSV

必要選項：

- `-o, --output <CSV-FILE>`：用以儲存結果的 CSV 檔案。
- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或包含 JSONL 檔案的目錄

選項：

- `-c, --calculateElapsedTime`：計算成功登入的經過時間。（預設值：`true`）
- `-l, --outputLogoffEvents`：將登出事件輸出為個別項目。（預設值：`false`）
- `-a, --outputAdminLogonEvents`：將管理員登入事件輸出為個別項目。（預設值：`false`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）

### `timeline-logon` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

將登入時間軸儲存為 CSV 檔案：

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-logon` 螢幕擷圖

![timeline-logon](../assets/screenshots/timeline-logon.png)

## `timeline-partition-diagnostic` 指令

藉由剖析 Windows 10 的 `Microsoft-Windows-Partition%4Diagnostic.evtx` 檔案，建立分割區診斷事件的 CSV 時間軸，並報告所有曾連接裝置及其磁碟區序號的相關資訊，包含目前仍存在於裝置上以及先前曾存在的裝置。
此程序是以工具 [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser) 為基礎。

* 輸入：JSONL
* Profile：任何 Profile
* 輸出：終端機或 CSV

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或包含 JSONL 檔案的目錄

選項：

- `-o, --output <CSV-FILE>`：用以儲存結果的 CSV 檔案。
- `-q, --quiet`：不顯示標誌。（預設值：`false`）

### `timeline-partition-diagnostic` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

建立已連接裝置的 CSV 時間軸：

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## `timeline-suspicious-processes` 指令

建立可疑處理程序的 CSV 時間軸。

* 輸入：JSONL
* Profile：除 `all-field-info` 與 `all-field-info-verbose` 以外的任何 Profile
* 輸出：終端機或 CSV

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或包含 JSONL 檔案的目錄
- `-o, --output <CSV-FILE>`：用以儲存結果的 CSV 檔案（預設值：`stdout`）

選項：

- `-l, --level <LEVEL>`：指定最低警示等級（預設值：`high`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）

### `timeline-suspicious-processes` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

搜尋警示等級為 `high` 或以上的處理程序，並將結果輸出至螢幕：

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

搜尋警示等級為 `low` 或以上的處理程序，並將結果輸出至螢幕：

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

將結果儲存為 CSV 檔案：

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### `timeline-suspicious-processes` 螢幕擷圖

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## `timeline-tasks` 指令

此指令會從 Security 4698 事件堆疊新的排程工作，並剖析出 XML 工作內容。

* 輸入：JSONL
* Profile：除 `all-field-info` 與 `all-field-info-verbose` 以外的任何 Profile
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或包含 JSONL 檔案的目錄

選項：

- `-o, --output <CSV-FILE>`：用以儲存結果的 CSV 檔案。
- `-q, --quiet`：不顯示標誌。（預設值：`false`）

### `timeline-tasks` 指令範例

輸出至終端機：

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

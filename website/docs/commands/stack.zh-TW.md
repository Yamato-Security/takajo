# 堆疊（Stack）指令

## `stack-cmdlines` 指令

此指令會從 `Sysmon 1` 與 `Security 4688` 事件中擷取資訊，將已執行的命令列加以堆疊。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-y, --ignoreSysmon`：排除 Sysmon 1 事件（預設值：`false`）
- `-e, --ignoreSecurity`：排除 Security 4688 事件（預設值：`false`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-cmdlines` 指令範例

輸出到終端機：

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers` 指令

此指令會依據 `Computer` 欄位堆疊電腦主機名稱。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-c, --sourceComputers`：堆疊來源電腦而非目標電腦（預設值：false）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-computers` 指令範例

輸出到終端機：

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns` 指令

此指令會堆疊來自 Sysmon 22 事件的 DNS 查詢與回應。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-dns` 指令範例

輸出到終端機：

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses` 指令

此指令會堆疊目標 IP 位址（`TgtIP` 欄位）或來源 IP 位址（`SrcIP` 欄位）。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-a, --targetIpAddresses`：堆疊目標 IP 位址而非來源 IP 位址（預設值：`false`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-ip-addresses` 指令範例

輸出到終端機：

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons` 指令

依據 `Target User`、`Target Computer`、`Logon Type`、`Source IP Address`、`Source Computer` 建立登入清單。
預設情況下，當來源 IP 位址為本機 IP 位址時，結果會被過濾掉。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --localSrcIpAddresses`：當來源 IP 位址為本機時，將結果納入。
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-logons` 指令範例

以預設設定執行：

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

納入本機登入：

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes` 指令

此指令會堆疊來自 Sysmon 1 與 Security 4688 事件的已執行處理程序。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`low`）
- `-y, --ignoreSysmon`：排除 Sysmon 1 事件（預設值：`false`）
- `-e, --ignoreSecurity`：排除 Security 4688 事件（預設值：`false`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-processes` 指令範例

輸出到終端機：

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services` 指令

此指令會堆疊來自 System 7040 與 Security 4697 事件的服務名稱與路徑。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-y, --ignoreSystem`：排除 System 7040 事件（預設值：`false`）
- `-e, --ignoreSecurity`：排除 Security 4697 事件（預設值：`false`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-services` 指令範例

輸出到終端機：

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks` 指令

此指令會堆疊來自 Security 4698 事件的新排程工作，並剖析出 XML 工作內容。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-tasks` 指令範例

輸出到終端機：

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users` 指令

此指令會在任何具有相關欄位的事件中堆疊目標使用者（`TgtUser` 欄位（預設））或來源使用者（`SrcUser` 欄位），同時顯示警示資訊。

* 輸入：JSONL
* 設定檔（Profile）：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或 CSV 檔案

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案，或包含 JSONL 檔案的目錄

選項：

- `-s, --sourceUsers`：堆疊來源使用者而非目標使用者（預設值：false）
- `-c, --filterComputerAccounts`：過濾掉電腦帳戶（預設值：true）
- `-f, --filterSystemAccounts`：過濾掉系統帳戶（預設值：true）
- `-l, --level`：指定最低警示等級（預設值：`informational`）
- `-o, --output <CSV-FILE>`：用來儲存結果的 CSV 檔案（預設值：`stdout`）
- `-q, --quiet`：不顯示標誌。（預設值：`false`）
- `-s, --skipProgressBar`：不顯示進度條（預設值：`false`）

### `stack-users` 指令範例

輸出到終端機：

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

儲存為 CSV：

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

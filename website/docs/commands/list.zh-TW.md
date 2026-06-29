# List 指令

## `list-domains` 指令

建立一份不重複網域的清單，供 `vt-domain-lookup` 使用。
目前它只會檢查 Sysmon EID 22 日誌中查詢過的網域，但未來將更新以支援內建的 Windows DNS 用戶端與伺服器日誌。

* 輸入：JSONL
* Profile：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何 profile
* 輸出：文字檔

必要選項：

 - `-o, --output <TXT-FILE>`：將結果儲存至文字檔。
 - `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或目錄。

選項：

 - `-s, --includeSubdomains`：包含子網域（預設：`false`）
 - `-w, --includeWorkstations`：包含本機工作站名稱（預設：`false`）
 - `-q, --quiet`：不顯示標誌（預設：`false`）
 - `-s, --skipProgressBar`：不顯示進度條（預設：`false`）

### `list-domains` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

將結果儲存至文字檔：

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

包含子網域：

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes` 指令

建立一份程序雜湊清單，供 vt-hash-lookup 使用（輸入：JSONL，profile：standard）

* 輸入：JSONL
* Profile：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何 profile
* 輸出：文字檔

必要選項：

 - `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或 JSONL 檔案的目錄
 - `-o, --output <BASE-NAME>`：指定用於儲存文字結果的基底名稱。

選項：

 - `-l, --level`：指定最低等級。（預設：`high`）
 - `-q, --quiet`：不顯示標誌。（預設：`false`）
 - `-s, --skipProgressBar`：不顯示進度條（預設：`false`）

### `list-hashes` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

為每種雜湊類型將結果儲存至不同的文字檔：

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

例如，若 sysmon 日誌中儲存了 `MD5`、`SHA1` 與 `IMPHASH` 雜湊，則會建立以下檔案：`case-1-MD5-hashes.txt`、`case-1-SHA1-hashes.txt`、`case-1-ImportHashes.txt`

## `list-ip-addresses` 指令

建立一份不重複的目標及／或來源 IP 位址清單，供 `vt-ip-lookup` 使用。
它會擷取所有結果中的 `TgtIP` 欄位作為目標 IP 位址，以及 `SrcIP` 欄位作為來源 IP 位址，並僅將不重複的 IP 位址輸出至文字檔。

* 輸入：JSONL
* Profile：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何 profile
* 輸出：文字檔

必要選項：

 - `-o, --output <TXT-FILE>`：將結果儲存至文字檔。
 - `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或目錄。

選項：

 - `-i, --inbound`：包含傳入流量。（預設：`true`）
 - `-O, --outbound`：包含傳出流量。（預設：`true`）
 - `-p, --privateIp`：包含私有 IP 位址（預設：`false`）
 - `-q, --quiet`：不顯示標誌。（預設：`false`）
 - `-s, --skipProgressBar`："不顯示進度條（預設：`false`）

### `list-ip-addresses` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

將結果儲存至文字檔：

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

排除傳入流量：

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

包含私有 IP 位址：

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx` 指令

列出所有 Hayabusa 沒有對應偵測規則的 `.evtx` 檔案。
這旨在用於全部都含有惡意活動證據的範例 evtx 檔案，例如 [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) 儲存庫中的範例 evtx 檔案。

* 輸入：CSV
* Profile：`verbose`、`all-field-info-verbose`、`super-verbose`、`timesketch-verbose`
  > 您首先需要使用會儲存 `%EvtxFile%` 欄位資訊的 profile 執行 Hayabusa，並將結果儲存為 CSV 時間軸。
  > 您可以在[這裡](https://github.com/Yamato-Security/hayabusa#profiles)查看 Hayabusa 依不同 profile 所儲存的欄位。
* 輸出：終端機或文字檔

必要選項：

- `-e, --evtx-dir <EVTX-DIR>`：您使用 Hayabusa 掃描的 `.evtx` 檔案目錄。
- `-t, --timeline <CSV-FILE>`：Hayabusa CSV 時間軸。

選項：

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`：為 evtx 欄位指定自訂的欄位名稱。（預設：Hayabusa 的預設值 `EvtxFile`）
- `-o, --output <TXT-FILE>`：將結果儲存至文字檔。（預設：輸出至螢幕）
- `-q, --quiet`：不顯示標誌。（預設：`false`）

### `list-undetected-evtx` 指令範例

使用 Hayabusa 準備 CSV 時間軸：

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

將結果輸出至螢幕：

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

將結果儲存至文字檔：

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules` 指令

列出所有未偵測到任何項目的 `.yml` 偵測規則。
這有助於判斷規則的可靠性。
也就是說，哪些規則已知能找出惡意活動，而哪些規則仍未經測試並需要範例 `.evtx` 檔案。

* 輸入：CSV
* Profile：`verbose`、`all-field-info-verbose`、`super-verbose`、`timesketch-verbose`
  > 您首先需要使用會儲存 `%RuleFile%` 欄位資訊的 profile 執行 Hayabusa，並將結果儲存為 CSV 時間軸。
  > 您可以在[這裡](https://github.com/Yamato-Security/hayabusa#profiles)查看 Hayabusa 依不同 profile 所儲存的欄位。
* 輸出：終端機或文字檔

必要選項：

- `-r, --rules-dir <DIR>`：您搭配 Hayabusa 使用的 `.yml` 規則檔案目錄。
- `-t, --timeline <CSV-FILE>`：由 Hayabusa 建立的 CSV 時間軸。

選項：

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`：為規則檔案欄位指定自訂的欄位名稱。（預設：Hayabusa 的預設值 `RuleFile`）
- `-o, --output <TXT-FILE>`：將結果儲存至文字檔。（預設：輸出至螢幕）
- `-q, --quiet`：不顯示標誌。（預設：`false`）

### `list-unused-rules` 指令範例

使用 Hayabusa 準備 CSV 時間軸：

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

將結果輸出至螢幕：

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

將結果儲存至文字檔：

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

# Sysmon 命令

## `sysmon-process-tree` 命令

輸出特定處理程序的處理程序樹，例如可疑或惡意的處理程序。

* 輸入：JSONL
* 設定檔：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何設定檔
* 輸出：終端機或文字檔

必要選項：

- `-p, --processGuid <Process GUID>`: sysmon 處理程序 GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 時間軸檔案或 JSONL 檔案所在的目錄

選項：

- `-o, --output <TXT-FILE>`: 用於儲存結果的文字檔。
- `-q, --quiet`: 不顯示標誌。（預設值：`false`）

### `sysmon-process-tree` 命令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

將結果儲存至文字檔：

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree` 螢幕截圖

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

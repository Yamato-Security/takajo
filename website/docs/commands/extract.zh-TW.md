# 擷取指令

## `extract-scriptblocks` 指令

擷取並重組 PowerShell EID 4104 指令碼區塊記錄。

> 注意：這些 PowerShell 指令碼最好以具有程式碼語法突顯的 `.ps1` 檔案開啟，但我們使用 `.txt` 副檔名，以避免不慎執行惡意程式碼。

* 輸入：JSONL
* 設定檔：任何
* 輸出：終端機與 PowerShell 指令碼目錄

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 時間軸檔案或目錄

選項：

 - `-l, --level`: 指定最低警示等級（預設值：`low`）
 - `-o, --output`: 輸出目錄（預設值：`scriptblock-logs`）
 - `-q, --quiet`: 不顯示啟動橫幅（預設值：`false`）
 - `-s, --skipProgressBar`: 不顯示進度列（預設值：`false`）

### `extract-scriptblocks` 指令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

將 PowerShell EID 4104 指令碼區塊記錄擷取至 `scriptblock-logs` 目錄：

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### `extract-scriptblocks` 螢幕截圖

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

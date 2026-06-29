# HTML 命令

## `html-report` 命令

為具有偵測結果的規則與電腦建立 HTML 摘要報告。
此命令會先建立一個已建立索引的 DuckDB 資料庫檔案（預設）或 SQLite 資料庫檔案，以便對建立摘要報告所需的資料進行快速查詢。

* 輸入：JSONL
* 設定檔：任何詳細（verbose）設定檔
* 輸出：以電腦名稱為基礎的個別 HTML 摘要報告，以及一個 `index.html` 主頁面

必要選項：

- `-o, --output`：HTML 報告目錄名稱
- `-r, --rulepath`：Hayabusa 規則目錄的路徑
- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或目錄

選項：

- `-C, --clobber`：儲存時覆寫資料庫檔案（預設：`false`）
- `-q, --quiet`：不顯示啟動橫幅（預設：`false`）
- `-s, --dboutput`：將結果儲存至資料庫檔案（預設：`html-report.duckdb`，使用 `--sqlite` 時為 `html-report.sqlite`）
- `--skipProgressBar`：不顯示進度列（預設：`false`）
- `--sqlite`：使用 SQLite 後端而非 DuckDB（預設：`false`）

### `html-report` 命令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

或

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

建立 HTML 摘要報告：

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report` 螢幕截圖

#### 規則摘要

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### 電腦摘要

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### 規則清單

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server` 命令

建立一個動態網頁伺服器以檢視 HTML 摘要報告。
此命令會先建立一個已建立索引的 DuckDB 資料庫檔案（預設）或 SQLite 資料庫檔案，以便對建立摘要報告所需的資料進行快速查詢。
它與 `html-report` 命令類似，但更具擴充性，並允許依日期與規則進行篩選。

* 輸入：JSONL
* 設定檔：任何詳細（verbose）設定檔
* 輸出：預設會在 `http://localhost:8823` 上監聽

必要選項：

- `-t, --timeline <JSONL-FILE-OR-DIR>`：Hayabusa JSONL 時間軸檔案或目錄

選項：

- `-C, --clobber`：儲存時覆寫資料庫檔案（預設：`false`）
- `-p, --port`：網頁伺服器連接埠號碼（預設：`8823`）
- `-q, --quiet`：不顯示啟動橫幅（預設：`false`）
- `-r, --rulepath`：Hayabusa 規則目錄的路徑（此為選用項目，但用於建立指向規則檔案的正確連結時需要）
- `-s, --dboutput`：將結果儲存至資料庫檔案（預設：`html-report.duckdb`，使用 `--sqlite` 時為 `html-report.sqlite`）
- `--skipProgressBar`：不顯示進度列（預設：`false`）
- `--sqlite`：使用 SQLite 後端而非 DuckDB（預設：`false`）

### `html-report` 命令範例

使用 Hayabusa 準備 JSONL 時間軸：

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

或

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

啟動網頁伺服器：

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server` 螢幕截圖

#### 規則清單

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### 電腦摘要

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### 規則篩選

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### 規則篩選

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

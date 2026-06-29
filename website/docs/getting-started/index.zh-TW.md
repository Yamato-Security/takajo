# 下載

請從 [Releases](https://github.com/Yamato-Security/takajo/releases) 頁面下載最新的穩定版 Takajo 編譯後二進位檔，或自行編譯原始碼。

> 注意：我們提供 64 位元 Windows 以及 Intel 和 Arm 架構 macOS 的發行二進位檔，但不提供 Linux 版，因為目前很難為 Linux 提供 MUSL 二進位檔。

## 系統需求

`html-report` 和 `html-server` 命令使用 [DuckDB](https://duckdb.org/) 作為預設的資料庫後端，以進行快速的分析查詢。
在使用這些命令之前，您需要先安裝 DuckDB。
如果您不想安裝 DuckDB，可以使用 `--sqlite` 旗標改用 SQLite。

### macOS (Homebrew)

```
brew install duckdb
```

### Windows (winget)

```
winget install DuckDB.cli
```

### Linux

```
wget -q https://github.com/duckdb/duckdb/releases/download/v1.4.4/libduckdb-linux-amd64.zip
unzip -o libduckdb-linux-amd64.zip -d duckdb_lib
sudo cp duckdb_lib/duckdb.h /usr/local/include/
sudo cp duckdb_lib/libduckdb.so /usr/local/lib/
sudo ldconfig
```

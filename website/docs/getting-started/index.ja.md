# ダウンロード

[Releases](https://github.com/Yamato-Security/takajo/releases)ページからTakajōの安定したバージョンでコンパイルされたバイナリが含まれている最新版もしくはソースコードをダウンロードできます。

> ※ 64ビットのWindows、IntelおよびArmベースのmacOS用のリリースバイナリを提供していますが、Linux用のMUSLバイナリを提供することは現時点では困難なため、Linuxには提供していません。

## 必要条件

`html-report`と`html-server`コマンドは、高速な分析クエリのためにデフォルトで[DuckDB](https://duckdb.org/)をデータベースバックエンドとして使用します。
これらのコマンドを使用する前にDuckDBをインストールする必要があります。
DuckDBをインストールしたくない場合は、`--sqlite`フラグを使用してSQLiteを代わりに使用できます。

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

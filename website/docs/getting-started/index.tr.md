# İndirmeler

Lütfen Takajō'nun derlenmiş ikili dosyalarıyla birlikte en son kararlı sürümünü indirin veya kaynak kodunu [Releases](https://github.com/Yamato-Security/takajo/releases) sayfasından derleyin.

> Not: 64-bit Windows ve Intel ile Arm tabanlı macOS için sürüm ikili dosyaları sağlıyoruz, ancak şu anda Linux için MUSL ikili dosyaları sağlamak zor olduğundan Linux için sağlamıyoruz.

## Gereksinimler

`html-report` ve `html-server` komutları, hızlı analitik sorgular için varsayılan veritabanı arka ucu olarak [DuckDB](https://duckdb.org/) kullanır.
Bu komutları kullanmadan önce DuckDB'yi kurmanız gerekir.
DuckDB'yi kurmak istemiyorsanız, bunun yerine SQLite kullanmak için `--sqlite` bayrağını kullanabilirsiniz.

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

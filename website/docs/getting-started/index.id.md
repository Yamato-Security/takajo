# Unduhan

Silakan unduh versi stabil terbaru dari Takajo dengan biner yang telah dikompilasi atau kompilasi kode sumber dari halaman [Releases](https://github.com/Yamato-Security/takajo/releases).

> Catatan: kami menyediakan biner rilis untuk Windows 64-bit serta macOS berbasis Intel dan Arm tetapi tidak untuk Linux karena saat ini sulit menyediakan biner MUSL untuk Linux.

## Persyaratan

Perintah `html-report` dan `html-server` menggunakan [DuckDB](https://duckdb.org/) sebagai backend basis data default untuk kueri analitis yang cepat.
Anda perlu menginstal DuckDB sebelum menggunakan perintah-perintah ini.
Anda dapat menggunakan flag `--sqlite` untuk menggunakan SQLite sebagai gantinya jika Anda tidak ingin menginstal DuckDB.

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

# Downloads

Please download the latest stable version of Takajo with compiled binaries or compile the source code from the [Releases](https://github.com/Yamato-Security/takajo/releases) page.

> Note: we provide release binaries for 64-bit Windows and Intel and Arm-based macOS but not Linux because it is difficult to provide MUSL binaries for Linux at the moment.

## Requirements

The `html-report` and `html-server` commands use [DuckDB](https://duckdb.org/) as the default database backend for fast analytical queries.
You need to install DuckDB before using these commands.
You can use the `--sqlite` flag to use SQLite instead if you do not want to install DuckDB.

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

# Downloads

Bitte laden Sie die neueste stabile Version von Takajō mit kompilierten Binärdateien herunter oder kompilieren Sie den Quellcode von der Seite [Releases](https://github.com/Yamato-Security/takajo/releases).

> Hinweis: Wir stellen Release-Binärdateien für 64-Bit-Windows sowie Intel- und Arm-basiertes macOS bereit, jedoch nicht für Linux, da es derzeit schwierig ist, MUSL-Binärdateien für Linux anzubieten.

## Requirements

Die Befehle `html-report` und `html-server` verwenden [DuckDB](https://duckdb.org/) als standardmäßiges Datenbank-Backend für schnelle analytische Abfragen.
Sie müssen DuckDB installieren, bevor Sie diese Befehle verwenden.
Sie können das Flag `--sqlite` verwenden, um stattdessen SQLite zu nutzen, falls Sie DuckDB nicht installieren möchten.

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

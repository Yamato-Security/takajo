# Descargas

Descargue la última versión estable de Takajō con los binarios compilados o compile el código fuente desde la página de [Releases](https://github.com/Yamato-Security/takajo/releases).

> Nota: proporcionamos binarios de lanzamiento para Windows de 64 bits y macOS basado en Intel y Arm, pero no para Linux, ya que en este momento es difícil proporcionar binarios MUSL para Linux.

## Requisitos

Los comandos `html-report` y `html-server` utilizan [DuckDB](https://duckdb.org/) como backend de base de datos predeterminado para consultas analíticas rápidas.
Debe instalar DuckDB antes de utilizar estos comandos.
Puede usar la opción `--sqlite` para utilizar SQLite en su lugar si no desea instalar DuckDB.

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

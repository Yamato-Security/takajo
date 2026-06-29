# Downloads

Por favor, baixe a versão estável mais recente do Takajō com binários compilados ou compile o código-fonte a partir da página de [Releases](https://github.com/Yamato-Security/takajo/releases).

> Nota: fornecemos binários de release para Windows 64-bit e macOS baseado em Intel e Arm, mas não para Linux, porque atualmente é difícil fornecer binários MUSL para Linux.

## Requirements

Os comandos `html-report` e `html-server` usam o [DuckDB](https://duckdb.org/) como backend de banco de dados padrão para consultas analíticas rápidas.
Você precisa instalar o DuckDB antes de usar esses comandos.
Você pode usar a flag `--sqlite` para usar o SQLite em vez disso, caso não queira instalar o DuckDB.

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

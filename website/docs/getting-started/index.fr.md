# Téléchargements

Veuillez télécharger la dernière version stable de Takajō avec les binaires compilés ou compiler le code source depuis la page [Releases](https://github.com/Yamato-Security/takajo/releases).

> Note : nous fournissons des binaires de publication pour Windows 64 bits ainsi que pour macOS sur Intel et Arm, mais pas pour Linux, car il est actuellement difficile de fournir des binaires MUSL pour Linux.

## Prérequis

Les commandes `html-report` et `html-server` utilisent [DuckDB](https://duckdb.org/) comme moteur de base de données par défaut pour des requêtes analytiques rapides.
Vous devez installer DuckDB avant d'utiliser ces commandes.
Vous pouvez utiliser l'option `--sqlite` pour utiliser SQLite à la place si vous ne souhaitez pas installer DuckDB.

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

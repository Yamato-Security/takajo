# Завантаження

Будь ласка, завантажте останню стабільну версію Takajo зі скомпільованими бінарними файлами або скомпілюйте вихідний код зі сторінки [Releases](https://github.com/Yamato-Security/takajo/releases).

> Примітка: ми надаємо бінарні файли релізів для 64-розрядних Windows, а також macOS на базі Intel та Arm, але не для Linux, оскільки наразі складно надавати бінарні файли MUSL для Linux.

## Вимоги

Команди `html-report` та `html-server` використовують [DuckDB](https://duckdb.org/) як стандартний бекенд бази даних для швидких аналітичних запитів.
Перед використанням цих команд вам потрібно встановити DuckDB.
Ви можете скористатися прапорцем `--sqlite`, щоб замість цього використовувати SQLite, якщо ви не хочете встановлювати DuckDB.

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

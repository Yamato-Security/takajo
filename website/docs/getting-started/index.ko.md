# 다운로드

컴파일된 바이너리가 포함된 최신 안정 버전의 Takajō를 다운로드하거나 [Releases](https://github.com/Yamato-Security/takajo/releases) 페이지에서 소스 코드를 컴파일하십시오.

> 참고: 64비트 Windows와 Intel 및 Arm 기반 macOS용 릴리스 바이너리는 제공하지만, 현재로서는 Linux용 MUSL 바이너리를 제공하기 어렵기 때문에 Linux용은 제공하지 않습니다.

## 요구 사항

`html-report` 및 `html-server` 명령은 빠른 분석 쿼리를 위해 기본 데이터베이스 백엔드로 [DuckDB](https://duckdb.org/)를 사용합니다.
이러한 명령을 사용하기 전에 DuckDB를 설치해야 합니다.
DuckDB를 설치하고 싶지 않다면 `--sqlite` 플래그를 사용하여 대신 SQLite를 사용할 수 있습니다.

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

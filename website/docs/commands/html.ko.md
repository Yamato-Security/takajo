# HTML 명령어

## `html-report` 명령어

탐지된 규칙과 컴퓨터에 대한 HTML 요약 보고서를 생성합니다.
이 명령어는 먼저 요약 보고서를 생성하는 데 필요한 데이터에 대해 빠른 조회를 수행하기 위해 인덱싱된 DuckDB 데이터베이스 파일(기본값) 또는 SQLite 데이터베이스 파일을 생성합니다.

* 입력: JSONL
* 프로파일: 모든 verbose 프로파일
* 출력: 컴퓨터 이름을 기반으로 한 개별 HTML 요약 보고서와 `index.html` 메인 페이지

필수 옵션:

- `-o, --output`: html 보고서 디렉터리 이름
- `-r, --rulepath`: Hayabusa 규칙 디렉터리 경로
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 디렉터리

옵션:

- `-C, --clobber`: 저장 시 데이터베이스 파일을 덮어씁니다 (기본값: `false`)
- `-q, --quiet`: 시작 배너를 표시하지 않습니다 (기본값: `false`)
- `-s, --dboutput`: 결과를 데이터베이스 파일에 저장합니다 (기본값: `html-report.duckdb` 또는 `--sqlite` 사용 시 `html-report.sqlite`)
- `--skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)
- `--sqlite`: DuckDB 대신 SQLite 백엔드를 사용합니다 (기본값: `false`)

### `html-report` 명령어 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

또는

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

HTML 요약 보고서를 생성합니다:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report` 스크린샷

#### 규칙 요약

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### 컴퓨터 요약

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### 규칙 목록

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server` 명령어

HTML 요약 보고서를 보기 위한 동적 웹 서버를 생성합니다.
이 명령어는 먼저 요약 보고서를 생성하는 데 필요한 데이터에 대해 빠른 조회를 수행하기 위해 인덱싱된 DuckDB 데이터베이스 파일(기본값) 또는 SQLite 데이터베이스 파일을 생성합니다.
이는 `html-report` 명령어와 유사하지만 확장성이 더 뛰어나며 날짜와 규칙에 대한 필터링이 가능합니다.

* 입력: JSONL
* 프로파일: 모든 verbose 프로파일
* 출력: 기본적으로 `http://localhost:8823`에서 수신 대기합니다

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 디렉터리

옵션:

- `-C, --clobber`: 저장 시 데이터베이스 파일을 덮어씁니다 (기본값: `false`)
- `-p, --port`: 웹 서버 포트 번호 (기본값: `8823`)
- `-q, --quiet`: 시작 배너를 표시하지 않습니다 (기본값: `false`)
- `-r, --rulepath`: Hayabusa 규칙 디렉터리 경로 (선택 사항이지만 규칙 파일에 대한 올바른 링크를 생성하는 데 필요합니다)
- `-s, --dboutput`: 결과를 데이터베이스 파일에 저장합니다 (기본값: `html-report.duckdb` 또는 `--sqlite` 사용 시 `html-report.sqlite`)
- `--skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)
- `--sqlite`: DuckDB 대신 SQLite 백엔드를 사용합니다 (기본값: `false`)

### `html-report` 명령어 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

또는

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

웹 서버를 시작합니다:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server` 스크린샷

#### 규칙 목록

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### 컴퓨터 요약

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### 규칙 필터링

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### 규칙 필터링

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

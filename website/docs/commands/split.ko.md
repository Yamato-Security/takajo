# 분할 명령어

## `split-csv-timeline` 명령어

대용량 CSV 타임라인을 컴퓨터 이름을 기준으로 더 작은 타임라인으로 분할합니다.

* 입력: 멀티라인이 아닌 CSV
* 프로파일: 모두
* 출력: 여러 개의 CSV 파일

필수 옵션:

- `-t, --timeline <CSV-FILE>`: Hayabusa로 생성한 CSV 타임라인.

옵션:

- `-m, --makeMultiline`: 필드를 여러 줄로 출력합니다. (기본값: `false`)
- `-o, --output <DIR>`: CSV 파일을 저장할 디렉터리. (기본값: `output`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `split-csv-timeline` 명령어 예시

Hayabusa로 CSV 타임라인을 준비합니다:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

단일 CSV 타임라인을 기본 `output` 디렉터리에 여러 개의 CSV 타임라인으로 분할합니다:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

필드 정보를 개행 문자로 구분하여 여러 줄 항목으로 만들고 `case-1-csv` 디렉터리에 저장합니다:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline` 명령어

대용량 JSONL 타임라인을 컴퓨터 이름을 기준으로 더 작은 타임라인으로 분할합니다.

* 입력: JSONL
* 프로파일: 모두
* 출력: 여러 개의 JSONL 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 디렉터리.

옵션:

- `-o, --output <DIR>`: JSONL 파일을 저장할 디렉터리. (기본값: `output`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `split-json-timeline` 명령어 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

단일 JSONL 타임라인을 기본 `output` 디렉터리에 여러 개의 JSONL 타임라인으로 분할합니다:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

`case-1-jsonl` 디렉터리에 저장합니다:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

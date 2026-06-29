# 자동화 명령

## `automagic` 명령

가능한 한 많은 명령을 자동으로 실행하고 결과를 새 폴더에 출력합니다

> 참고: 모든 명령을 활용하려면 `verbose` 또는 `super-verbose` 프로파일을 사용해야 합니다.

* 입력: JSONL 파일 또는 JSONL 파일이 들어 있는 디렉터리
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 모든 결과가 서로 다른 파일에 담긴 새 폴더

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 디렉터리.

옵션:

- `-d, --displayTable`: 결과 테이블을 표시합니다 (기본값: `false`)
- `-l, --level`: 최소 경고 수준을 지정합니다 (기본값: `low`)
- `-o, --output`: 출력 디렉터리 (기본값: `case-1`)
- `-q, --quiet`: 시작 배너를 표시하지 않습니다 (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `automagic` 명령 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

가능한 한 많은 Takajo 명령을 실행하고 결과를 `case-1` 폴더 아래에 저장합니다:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

`hayabusa-results` 디렉터리에 대해 가능한 한 많은 Takajo 명령을 실행하고 결과를 `case-1` 폴더 아래에 저장합니다:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

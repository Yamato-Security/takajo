# List 명령어

## `list-domains` 명령어

`vt-domain-lookup`와 함께 사용할 고유 도메인 목록을 생성합니다.
현재는 Sysmon EID 22 로그에서 조회된 도메인만 확인하지만, 향후 내장 Windows DNS Client 및 Server 로그를 지원하도록 업데이트될 예정입니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 텍스트 파일

필수 옵션:

 - `-o, --output <TXT-FILE>`: 결과를 텍스트 파일에 저장합니다.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 디렉터리.

옵션:

 - `-s, --includeSubdomains`: 하위 도메인을 포함합니다 (기본값: `false`)
 - `-w, --includeWorkstations`: 로컬 워크스테이션 이름을 포함합니다 (기본값: `false`)
 - `-q, --quiet`: 로고를 표시하지 않습니다 (기본값: `false`)
 - `-s, --skipProgressBar`: 진행 표시줄을 표시하지 않습니다 (기본값: `false`)

### `list-domains` 명령어 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

결과를 텍스트 파일에 저장합니다:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

하위 도메인을 포함합니다:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes` 명령어

vt-hash-lookup와 함께 사용할 프로세스 해시 목록을 생성합니다 (입력: JSONL, 프로파일: standard)

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 텍스트 파일

필수 옵션:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일 디렉터리
 - `-o, --output <BASE-NAME>`: 텍스트 결과를 저장할 기본 이름을 지정합니다.

옵션:

 - `-l, --level`: 최소 레벨을 지정합니다. (기본값: `high`)
 - `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
 - `-s, --skipProgressBar`: 진행 표시줄을 표시하지 않습니다 (기본값: `false`)

### `list-hashes` 명령어 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

각 해시 유형별로 다른 텍스트 파일에 결과를 저장합니다:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

예를 들어, sysmon 로그에 `MD5`, `SHA1`, `IMPHASH` 해시가 저장되어 있다면 다음 파일들이 생성됩니다: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses` 명령어

`vt-ip-lookup`와 함께 사용할 고유한 대상 및/또는 출발지 IP 주소 목록을 생성합니다.
모든 결과에서 대상 IP 주소에 대한 `TgtIP` 필드와 출발지 IP 주소에 대한 `SrcIP` 필드를 추출하여 고유한 IP 주소만 텍스트 파일로 출력합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 텍스트 파일

필수 옵션:

 - `-o, --output <TXT-FILE>`: 결과를 텍스트 파일에 저장합니다.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 디렉터리.

옵션:

 - `-i, --inbound`: 인바운드 트래픽을 포함합니다. (기본값: `true`)
 - `-O, --outbound`: 아웃바운드 트래픽을 포함합니다. (기본값: `true`)
 - `-p, --privateIp`: 사설 IP 주소를 포함합니다 (기본값: `false`)
 - `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
 - `-s, --skipProgressBar`: "진행 표시줄을 표시하지 않습니다 (기본값: `false`)

### `list-ip-addresses` 명령어 예시

Hayabusa로 JSONL 타임라인을 준비합니다:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

결과를 텍스트 파일에 저장합니다:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

인바운드 트래픽을 제외합니다:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

사설 IP 주소를 포함합니다:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx` 명령어

Hayabusa에 탐지 규칙이 없었던 모든 `.evtx` 파일을 나열합니다.
이는 [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) 저장소의 샘플 evtx 파일처럼 모두 악성 활동의 증거를 포함하는 샘플 evtx 파일에 사용하기 위한 것입니다.

* 입력: CSV
* 프로파일: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > 먼저 `%EvtxFile%` 컬럼 정보를 저장하는 프로파일로 Hayabusa를 실행하여 결과를 CSV 타임라인으로 저장해야 합니다.
  > 각 프로파일에 따라 Hayabusa가 저장하는 컬럼은 [여기](https://github.com/Yamato-Security/hayabusa#profiles)에서 확인할 수 있습니다.
* 출력: 터미널 또는 텍스트 파일

필수 옵션:

- `-e, --evtx-dir <EVTX-DIR>`: Hayabusa로 스캔한 `.evtx` 파일이 있는 디렉터리.
- `-t, --timeline <CSV-FILE>`: Hayabusa CSV 타임라인.

옵션:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: evtx 컬럼에 대한 사용자 지정 컬럼 이름을 지정합니다. (기본값: Hayabusa의 기본값인 `EvtxFile`)
- `-o, --output <TXT-FILE>`: 결과를 텍스트 파일에 저장합니다. (기본값: 화면 출력)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `list-undetected-evtx` 명령어 예시

Hayabusa로 CSV 타임라인을 준비합니다:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

결과를 화면에 출력합니다:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

결과를 텍스트 파일에 저장합니다:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules` 명령어

아무것도 탐지하지 못한 모든 `.yml` 탐지 규칙을 나열합니다.
이는 규칙의 신뢰성을 판단하는 데 유용합니다.
즉, 어떤 규칙이 악성 활동을 찾는 것으로 알려져 있고, 어떤 규칙이 아직 테스트되지 않아 샘플 `.evtx` 파일이 필요한지 파악하는 데 도움이 됩니다.

* 입력: CSV
* 프로파일: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > 먼저 `%RuleFile%` 컬럼 정보를 저장하는 프로파일로 Hayabusa를 실행하여 결과를 CSV 타임라인으로 저장해야 합니다.
  > 각 프로파일에 따라 Hayabusa가 저장하는 컬럼은 [여기](https://github.com/Yamato-Security/hayabusa#profiles)에서 확인할 수 있습니다.
* 출력: 터미널 또는 텍스트 파일

필수 옵션:

- `-r, --rules-dir <DIR>`: Hayabusa와 함께 사용한 `.yml` 규칙 파일이 있는 디렉터리.
- `-t, --timeline <CSV-FILE>`: Hayabusa가 생성한 CSV 타임라인.

옵션:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: 규칙 파일 컬럼에 대한 사용자 지정 컬럼 이름을 지정합니다. (기본값: Hayabusa의 기본값인 `RuleFile`)
- `-o, --output <TXT-FILE>`: 결과를 텍스트 파일에 저장합니다. (기본값: 화면 출력)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `list-unused-rules` 명령어 예시

Hayabusa로 CSV 타임라인을 준비합니다:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

결과를 화면에 출력합니다:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

결과를 텍스트 파일에 저장합니다:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

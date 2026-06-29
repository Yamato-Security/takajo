# 스택 명령어

## `stack-cmdlines` 명령어

이 명령어는 `Sysmon 1` 및 `Security 4688` 이벤트에서 정보를 추출하여 실행된 명령줄을 스택으로 집계합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-y, --ignoreSysmon`: Sysmon 1 이벤트를 제외합니다 (기본값: `false`)
- `-e, --ignoreSecurity`: Security 4688 이벤트를 제외합니다 (기본값: `false`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-cmdlines` 명령어 예시

터미널로 출력:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers` 명령어

이 명령어는 `Computer` 필드에 따라 컴퓨터 호스트명을 스택으로 집계합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-c, --sourceComputers`: 대상 컴퓨터 대신 소스 컴퓨터를 스택으로 집계합니다 (기본값: false)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-computers` 명령어 예시

터미널로 출력:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns` 명령어

이 명령어는 Sysmon 22 이벤트에서 DNS 쿼리와 응답을 스택으로 집계합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-dns` 명령어 예시

터미널로 출력:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses` 명령어

이 명령어는 대상 IP 주소(`TgtIP` 필드) 또는 소스 IP 주소(`SrcIP` 필드)를 스택으로 집계합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-a, --targetIpAddresses`: 소스 IP 주소 대신 대상 IP 주소를 스택으로 집계합니다 (기본값: `false`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-ip-addresses` 명령어 예시

터미널로 출력:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons` 명령어

`Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`에 따라 로그온 목록을 생성합니다.
기본적으로 소스 IP 주소가 로컬 IP 주소인 경우 결과에서 필터링됩니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --localSrcIpAddresses`: 소스 IP 주소가 로컬인 경우의 결과를 포함합니다.
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-logons` 명령어 예시

기본 설정으로 실행:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

로컬 로그온 포함:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes` 명령어

이 명령어는 Sysmon 1 및 Security 4688 이벤트에서 실행된 프로세스를 스택으로 집계합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `low`)
- `-y, --ignoreSysmon`: Sysmon 1 이벤트를 제외합니다 (기본값: `false`)
- `-e, --ignoreSecurity`: Security 4688 이벤트를 제외합니다 (기본값: `false`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-processes` 명령어 예시

터미널로 출력:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services` 명령어

이 명령어는 System 7040 및 Security 4697 이벤트에서 서비스 이름과 경로를 스택으로 집계합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-y, --ignoreSystem`: System 7040 이벤트를 제외합니다 (기본값: `false`)
- `-e, --ignoreSecurity`: Security 4697 이벤트를 제외합니다 (기본값: `false`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-services` 명령어 예시

터미널로 출력:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks` 명령어

이 명령어는 Security 4698 이벤트에서 새 예약 작업을 스택으로 집계하고 XML 작업 내용을 파싱합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-tasks` 명령어 예시

터미널로 출력:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users` 명령어

이 명령어는 해당 필드를 가진 모든 이벤트에서 대상 사용자(`TgtUser` 필드(기본값)) 또는 소스 사용자(`SrcUser` 필드)를 스택으로 집계하고 경고 정보도 함께 표시합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 CSV 파일

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일이 들어 있는 디렉터리

옵션:

- `-s, --sourceUsers`: 대상 사용자 대신 소스 사용자를 스택으로 집계합니다 (기본값: false)
- `-c, --filterComputerAccounts`: 컴퓨터 계정을 필터링합니다 (기본값: true)
- `-f, --filterSystemAccounts`: 시스템 계정을 필터링합니다 (기본값: true)
- `-l, --level`: 최소 경고 레벨을 지정합니다 (기본값: `informational`)
- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일 (기본값: `stdout`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)
- `-s, --skipProgressBar`: 진행률 표시줄을 표시하지 않습니다 (기본값: `false`)

### `stack-users` 명령어 예시

터미널로 출력:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

CSV로 저장:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

# VirusTotal 명령어

## `vt-domain-lookup` 명령어

VirusTotal에서 도메인 목록을 조회합니다

* 입력: 텍스트 파일
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: CSV

필수 옵션:

- `-a, --apiKey <API-KEY>`: VirusTotal API 키입니다.
- `-d, --domainList <TXT-FILE>`: 도메인 목록이 담긴 텍스트 파일입니다.
- `-o, --output <CSV-FILE>`: 결과를 CSV 파일로 저장합니다.

옵션:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal의 모든 JSON 응답을 JSON 파일로 출력합니다.
- `-r, --rateLimit <NUMBER>`: 요청을 보내는 분당 비율입니다. (기본값: `4`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `vt-domain-lookup` 명령어 예시

먼저 `list-domains` 명령어로 도메인 목록을 생성합니다.
그런 다음 아래와 같이 해당 도메인들을 조회합니다:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup` 명령어

VirusTotal에서 해시 목록을 조회합니다.

* 입력: 텍스트 파일
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: CSV

필수 옵션:

- `-a, --apiKey <API-KEY>`: VirusTotal API 키입니다.
- `-H, --hashList <HASH-LIST>`: 해시가 담긴 텍스트 파일입니다.
- `-o, --output <CSV-FILE>`: 결과를 CSV 파일로 저장합니다.

옵션:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal의 모든 JSON 응답을 JSON 파일로 출력합니다.
- `-r, --rateLimit <NUMBER>`: 요청을 보내는 분당 비율입니다. (기본값: `4`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `vt-hash-lookup` 명령어 예시

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup` 명령어

VirusTotal에서 IP 주소 목록을 조회합니다.

* 입력: 텍스트 파일
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: CSV

필수 옵션:

- `-a, --apiKey <API-KEY>`: VirusTotal API 키입니다.
- `-i, --ipList <IP-ADDRESS-LIST>`: IP 주소가 담긴 텍스트 파일입니다.
- `-o, --output <CSV-FILE>`: 결과를 CSV 파일로 저장합니다.

옵션:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal의 모든 JSON 응답을 JSON 파일로 출력합니다.
- `-r, --rateLimit <NUMBER>`: 요청을 보내는 분당 비율입니다. (기본값: `4`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `vt-ip-lookup` 명령어 예시

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

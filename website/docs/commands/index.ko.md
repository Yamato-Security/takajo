# 명령어 목록

## 자동화 명령어
* `automagic`: 가능한 한 많은 명령어를 자동으로 실행하고 결과를 새 폴더에 출력합니다

## 추출 명령어
* `extract-scriptblocks`: PowerShell EID 4104 스크립트 블록 로그를 추출하고 재조합합니다

## HTML 명령어
* `html-report`: 정적 HTML 요약 보고서를 생성합니다
* `html-server`: HTML 요약 보고서를 보기 위한 동적 웹 서버를 생성합니다

## 목록 명령어
* `list-domains`: `vt-domain-lookup`과 함께 사용할 고유 도메인 목록을 생성합니다
* `list-hashes`: `vt-hash-lookup`과 함께 사용할 프로세스 해시 목록을 생성합니다
* `list-ip-addresses`: `vt-ip-lookup`과 함께 사용할 고유 대상 및/또는 소스 IP 주소 목록을 생성합니다
* `list-undetected-evtx`: 탐지되지 않은 evtx 파일 목록을 생성합니다
* `list-unused-rules`: 사용되지 않은 탐지 규칙 목록을 생성합니다

## 분할 명령어
* `split-csv-timeline`: 대용량 CSV 타임라인을 컴퓨터 이름을 기준으로 더 작은 타임라인으로 분할합니다
* `split-json-timeline`: 대용량 JSONL 타임라인을 컴퓨터 이름을 기준으로 더 작은 타임라인으로 분할합니다

## 스택 명령어
* `stack-cmdlines`: 실행된 명령줄을 스택합니다
* `stack-computers`: 컴퓨터를 스택합니다
* `stack-dns`: DNS 쿼리 및 응답을 스택합니다
* `stack-ip-addresses`: 대상 IP 주소(`TgtIP` 필드) 또는 소스 IP 주소(`SrcIP` 필드)를 스택합니다
* `stack-logons`: 대상 사용자, 대상 컴퓨터, 소스 IP 주소 및 소스 컴퓨터별로 로그온을 스택합니다
* `stack-processes`: 실행된 프로세스를 스택합니다
* `stack-services`: `System 7040` 및 `Security 4697` 이벤트에서 서비스 이름과 경로를 스택합니다
* `stack-tasks`: `Security 4698` 이벤트에서 새로 예약된 작업을 스택하고 XML 작업 내용을 파싱합니다
* `stack-users`: 대상 사용자(`TgtUser` 필드) 또는 소스 사용자(`SrcUser` 필드)를 스택합니다

## Sysmon 명령어
* `sysmon-process-tree`: 특정 프로세스의 프로세스 트리를 출력합니다

## 타임라인 명령어
* `timeline-logon`: 로그온 이벤트의 CSV 타임라인을 생성합니다
* `timeline-partition-diagnostic`: 파티션 진단 이벤트의 CSV 타임라인을 생성합니다
* `timeline-suspicious-processes`: 의심스러운 프로세스의 CSV 타임라인을 생성합니다
* `timeline-tasks`: 예약된 작업의 CSV 타임라인을 생성합니다

## TTP 명령어
* `ttp-summary`: 각 컴퓨터에서 발견된 전술 및 기법을 요약합니다
* `ttp-visualize`: TTP를 추출하고 MITRE ATT&CK Navigator에서 시각화할 JSON 파일을 생성합니다
* `ttp-visualize-sigma`: Sigma 규칙에서 TTP를 추출하고 MITRE ATT&CK Navigator에서 시각화할 JSON 파일을 생성합니다

## VirusTotal 명령어
* `vt-domain-lookup`: VirusTotal에서 도메인 목록을 조회하고 악성 도메인을 보고합니다
* `vt-hash-lookup`: VirusTotal에서 해시 목록을 조회하고 악성 해시를 보고합니다
* `vt-ip-lookup`: VirusTotal에서 IP 주소 목록을 조회하고 악성 IP 주소를 보고합니다

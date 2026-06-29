# Sysmon 명령어

## `sysmon-process-tree` 명령어

의심스럽거나 악의적인 프로세스와 같은 특정 프로세스의 프로세스 트리를 출력합니다.

* 입력: JSONL
* 프로파일: `all-field-info` 및 `all-field-info-verbose`를 제외한 모든 프로파일
* 출력: 터미널 또는 텍스트 파일

필수 옵션:

- `-p, --processGuid <Process GUID>`: sysmon 프로세스 GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일 디렉터리

옵션:

- `-o, --output <TXT-FILE>`: 결과를 저장할 텍스트 파일.
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `sysmon-process-tree` 명령어 예시

Hayabusa로 JSONL 타임라인 준비:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

결과를 텍스트 파일에 저장:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree` 스크린샷

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

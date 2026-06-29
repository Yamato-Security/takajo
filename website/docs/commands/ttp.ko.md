# TTP 명령어

## `ttp-summary` 명령어

이 명령어는 sigma 규칙의 `tags` 필드에 정의된 MITRE ATT&CK TTP에 따라 각 컴퓨터에서 발견된 전술과 기법을 요약합니다.

* 입력: JSONL
* 프로파일: `%MitreTactics%` 및 `%MitreTags%` 필드를 출력하는 프로파일. (예: `verbose`, `all-field-info-verbose`, `super-verbose`)
* 출력: 터미널 또는 CSV

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일 디렉터리

옵션:

- `-o, --output <CSV-FILE>`: 결과를 저장할 CSV 파일.
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `ttp-summary` 명령어 예시

Hayabusa로 JSONL 타임라인 준비하기:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTP 요약을 터미널에 출력하기:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

결과를 CSV 파일로 저장하기:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary` 스크린샷

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize` 명령어

이 명령어는 TTP를 추출하여 [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)에서 시각화할 JSON 파일을 생성합니다.

* 입력: JSONL
* 프로파일: `%MitreTactics%` 및 `%MitreTags%` 필드를 출력하는 프로파일. (예: `verbose`, `all-field-info-verbose`, `super-verbose`)
* 출력: JSON

필수 옵션:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL 타임라인 파일 또는 JSONL 파일 디렉터리

옵션:

- `-o, --output <JSON-FILE>`: 결과를 저장할 JSON 파일. (기본값: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `ttp-visualize` 명령어 예시

Hayabusa로 JSONL 타임라인 준비하기:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTP를 추출하여 `mitre-ttp-heatmap.json`에 저장하기:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

[https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/)를 열고 `Open Existing Layer`를 클릭한 후 저장된 JSON 파일을 업로드합니다.

### `ttp-visualize` 스크린샷

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma` 명령어

이 명령어는 Sigma에서 TTP를 추출하여 [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)에서 시각화할 JSON 파일을 생성합니다.

* 입력: Sigma 규칙 디렉터리
* 출력: JSON

필수 옵션:

- `-r, --ruleDir <SIGMA-DIR>`: Sigma 규칙 디렉터리

옵션:

- `-o, --output <JSON-FILE>`: 결과를 저장할 JSON 파일. (기본값: `mitre-attack-navigator.json`)
- `-q, --quiet`: 로고를 표시하지 않습니다. (기본값: `false`)

### `ttp-visualize-sigma` 명령어 예시

Sigma 저장소 복제하기:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Sigma에서 TTP를 추출하여 `mitre-attack-navigator.json`에 저장하기:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

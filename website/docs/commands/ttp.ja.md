# TTPコマンド

## `ttp-summary`コマンド

このコマンドは、Sigmaルールの「tags」フィールドで定義された MITRE ATT&CK TTP に従って、各コンピュータで見つかった戦術とテクニックの要約を出力します。

* 入力: JSONL
* プロファイル: `%MitreTactics%`と`%MitreTags%`フィールドを出力するプロファイル (例: `verbose`, `all-field-info-verbose`, `super-verbose`)
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `ttp-summary`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTPsの要約を表示する:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

結果をCSVに保存:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary`スクリーンショット

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize-sigma`コマンド

TTPsを抽出し、[MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)で視覚化するための JSON ファイルを作成します。

* 入力: JSONL
* プロファイル: `%MitreTactics%` と `%MitreTags%` フィールドを出力するプロファイル (例: `verbose`, `all-field-info-verbose`, `super-verbose`)
* 出力: JSON

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-o, --output <JSON-FILE>`: 結果を保存するJSONファイル (デフォルト: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `ttp-visualize`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTPsを抽出し、`mitre-ttp-heatmap.json`に保存する:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

[https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/)を開き、`Open Existing Layer`をクリック、JSONファイルをアップロードする。

### `ttp-visualize`スクリーンショット

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma`コマンド

TTPsをSigmaルールから抽出し、[MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)で視覚化するための JSON ファイルを作成します。

* 入力: Sigmaルールディレクトリ
* 出力: JSON

必須オプション:

- `-r, --ruleDir <SIGMA-DIR>`: Sigmaルールディレクトリ

任意オプション:

- `-o, --output <JSON-FILE>`: 結果を保存するJSONファイル (デフォルト: `sigma-rules-heatmap.json`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `ttp-visualize-sigma`コマンドの使用例

Sigmaリポジトリをクローンします:

```
git clone https://github.com/SigmaHQ/sigma.git
```

TTPsを抽出し `sigma-rules-heatmap.json`に保存します。:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

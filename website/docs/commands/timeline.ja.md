# Timelineコマンド

## `timeline-logon`コマンド

このコマンドは、次のログオンイベントから情報を抽出し、フィールドを正規化し、結果をCSVファイルに保存します:

- `4624` - ログオン成功
- `4625` - ログオン失敗
- `4634` - アカウントログオフ
- `4647` - ユーザーが開始したログオフ
- `4648` - 明示的なログオン
- `4672` - 特権ログオン

これにより、ラテラルムーブメント、パスワードスプレー、権限昇格などを検出しやすくなります。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: CSV

必須オプション:

- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-c, --calculateElapsedTime`: 成功ログオンの経過時間を計算する (デフォルト: `true`)
- `-l, --outputLogoffEvents`: ログオフイベントを別のエントリとして出力する (デフォルト: `false`)
- `-a, --outputAdminLogonEvents`: 管理者ログオン イベントを別のエントリとして出力する (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `timeline-logon`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ログオンタイムラインをCSVに保存する:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-logon`スクリーンショット

![timeline-logon](../assets/screenshots/timeline-logon.png)

## `timeline-partition-diagnostic`コマンド

partition diagnosticイベントのCSVタイムラインを作成します。Windows 10の`Microsoft-Windows-Partition%4Diagnostic.evtx`を解析し、現在および過去に接続されたデバイスのボリュームシリアル番号を出力します。
この処理は [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser)を参考にして作成されました。

* 入力: JSONL
* プロファイル: すべて
* 出力: CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `timeline-partition-diagnostic`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

接続されたデバイスのCSVタイムラインを作成する:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## `timeline-suspicious-processes`コマンド

不審なプロセスのCSVタイムラインを作成します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `high`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `timeline-suspicious-processes`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

アラートレベルが`high`以上のプロセスを検索し、結果を標準出力に表示:

```
takajo.exe timeline-suspicious-process -t ../hayabusa/timeline.jsonl
```

アラートレベルが`low`以上のプロセスを検索し、結果を標準出力に表示:

```
takajo.exe timeline-suspicious-process -t ../hayabusa/timeline.jsonl -l low
```

結果をCSVに保存:

```
takajo.exe timeline-suspicious-process -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### `timeline-suspicious-processes`スクリーンショット

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## `timeline-tasks`コマンド

Security 4698 イベントからスケジュールタスク作成を抽出し、 タスクXMLをパースします。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル

任意オプション:

- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `timeline-tasks`コマンドの使用例

ターミナルに出力する:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

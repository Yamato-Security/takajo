# Stackコマンド

## `stack-cmdlines`コマンド

Sysmon 1 と Security 4688 イベントから実行されたコマンドラインを抽出し、集計します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `low`)
- `-y, --ignoreSysmon`: Sysmon 1 イベントを除外 (デフォルト: `false`)
- `-e, --ignoreSecurity`:  Security 4688 イベントを除外 (デフォルト: `false`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `stack-cmdlines`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers`コマンド

Computerフィールドに従い、コンピュータ名を集計します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `infomational`)
- `-c, --sourceComputers`: ターゲットコンピュータ名の代わりにソースコンピュータ名を集計する (デフォルト: false)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)
- `-s, --skipProgressBar`: プログレスバーを出力しない (デフォルト: `false`)

### `stack-computers`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns`コマンド

Sysmon 22 イベントからDNSクエリとレスポンスを抽出し、集計します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `informational`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `stack-dns`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses`コマンド

ターゲットIP (`TgtIP` field) またはソースIP (`SrcIP` field)を集計する

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション::

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `infomational`)
- `-a, --targetIpAddresses`: ソースIPのかわりにターゲットIPを集計する (デフォルト: `false`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)
- `-s, --skipProgressBar`: プログレスバーを出力しない (デフォルト: `false`)

### `stack-ip-addresses`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons`コマンド

`Target User`、`Target Computer`、`Logon Type`、`Source IP Address`、`Source Computer`によってログインのリストを作成します。
デフォルトでは、ローカルIPアドレスのソースIPアドレスはフィルタされます。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナルまたはCSVファイル

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --localSrcIpAddresses`: ソースIPアドレスがローカルIPアドレスであっても結果に含む
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `stack-logons`コマンドの使用例

デフォルトの設定で実行する:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

ローカルログオンを含む:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes`コマンド

Sysmon 1 と Security 4688 イベントから実行されたプロセスを抽出し、集計します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `low`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `stack-processes`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services`コマンド

System 7040 と Security 4697 イベントからサービス名とパスを抽出し、集計します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `infomational`)
- `-y, --ignoreSystem`: System 7040 イベントを除外 (デフォルト: `false`)
- `-e, --ignoreSecurity`: Security 4697 イベントを除外 (デフォルト: `false`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `stack-services`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks`コマンド

Security 4698 イベントから作成されたスケジュールタスクを抽出し、集計します。またタスクXMLをパースします。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `infomational`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `stack-tasks`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users`コマンド

ターゲットユーザー (`TgtUser`フィールド(デフォルト)) またはソースユーザー (`SrcUser`フィールド) を含むイベントからユーザ名を集計し、加えて検知ルール名を出力する

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: ターミナル または CSV

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-s, --sourceUsers`: ターゲットユーザーのかわりにソースユーザーを集計する (デフォルト: false)
- `-c, --filterComputerAccounts`: コンピューターアカウントを除外する (デフォルト: true)
- `-f, --filterSystemAccounts`: システムアカウントを除外する (デフォルト: true)
- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `infomational`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)
- `-s, --skipProgressBar`: プログレスバーを出力しない (デフォルト: `false`)

### `stack-users`コマンドの使用例

ターミナルに出力する:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

CSVに保存する:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

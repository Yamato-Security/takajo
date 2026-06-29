# Listコマンド

## `list-domains`コマンド

`vt-domain-lookup` で使用する重複のないドメインのリストを作成します。
現在は、Sysmon EID 22ログでクエリが記録されたドメインのみをチェックしますが、ビルトインのWindows DNSクライアント・サーバーログも今後サポート予定です。

* 入力: JSONL
* プロファイル: `all-field-info` と`all-field-info-verbose` 以外すべて
* 出力: テキストファイル

必須オプション:

- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル
- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-s, --includeSubdomains`: サブドメインを含めるか (デフォルト: `false`)
- `-w, --includeWorkstations`: ローカルワークステーション名を含めるか (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `list-domains`コマンドの使用例

HayabusaでJSONLタイムラインを出力する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

結果をテキストファイルに保存する:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

サブドメインを含める場合:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes`コマンド

`vt-hash-lookup`で使用するプロセスハッシュ値のリストを作成します (入力: JSONL, プロファイル: standard)

* 入力: JSONL
* プロファイル: `all-field-info` と `all-field-info-verbose`以外すべて
* 出力: テキストファイル

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ
- `-o, --output <BASE-NAME>`: 結果を保存するベースファイル名

任意オプション:

- `-l, --level`: 最小のアラートレベルを指定 (デフォルト: `high`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `list-hashes`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ハッシュタイプ毎に異なるファイルに結果を保存する:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```
たとえば、`MD5`、`SHA1` 、`IMPHASH` がSysmonログに保存されている場合、 次のファルが作成されます:
`case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses`コマンド

`vt-ip-lookup`で使用する重複のない送信先/送信先IPアドレスのリストを作成します。すべての結果から送信先IPアドレスの`TgtIP`フィールドと送信元IPアドレスの `SrcIP`フィールドが抽出され、重複のないIPアドレスをテキストファイルに出力します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: テキストファイル

必須オプション:

- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル
- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-i, --inbound`: インバウンドトラフィックを含めるか (デフォルト: `true`)
- `-O, --outbound`: アウトバウンドトラフィックを含めるか (デフォルト: `true`)
- `-p, --privateIp`: プライベートIPアドレスを含めるか (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `list-ip-addresses`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

結果をテキストファイルに保存する:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

インバウンドトラフィックを除外する:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

プライベートIPアドレスを含める:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx`コマンド

Hayabusaで検知するルールがなかったすべての`.evtx`ファイルをリストアップします。
これは、[hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx)リポジトリ内のevtxファイルなど、悪意のあるアクティビティの証拠を含むすべてのevtxファイルをリストアップすることを目的としています

* 入力: CSV
* プロファイル: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > まず、`%EvtxFile%`を出力するプロファイルを使用し、Hayabusaを実行、結果をCSVタイムラインに保存する必要があります
  > [こちら](https://github.com/Yamato-Security/hayabusa#profiles)でHayabusaがプロファイルに従って、どのカラムを保存するかを確認できます。
* 出力: ターミナル または テキストファイル

必須オプション:

- `-e, --evtx-dir <EVTX-DIR>`: Hayabusaでスキャンした`.evtx` ファイルのディレクトリ
- `-t, --timeline <CSV-FILE>`: HayabusaのCSVタイムライン

任意オプション:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: evtxのカラム名を指定 (デフォルト: Hayabusaの規定値の`EvtxFile`)
- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル (デフォルト: 標準出力)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `list-undetected-evtx`コマンドの使用例

HayabusaでCSVタイムラインを出力する:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

結果を標準出力に表示する:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

結果をテキストファイルに保存する:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules`コマンド

何も検出されなかったすべての`.yml`ルールをリストアップします。
これは、ルールの信頼性を判断するのに役立ちます。
つまり、どのルールが悪意のあるアクティビティを検出するか、またどのルールがまだテストされておらずサンプル`.evtx`ファイルが必要かの判断に使えます。

* 入力: CSV
* プロファイル: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > まず、`%RuleFile%`を出力するプロファイルを使用し、Hayabusaを実行、結果をCSVタイムラインに保存する必要があります
  > [こちら](https://github.com/Yamato-Security/hayabusa#profiles)でHayabusaがプロファイルに従って、どのカラムを保存するかを確認できます。
* 出力: ターミナル または テキストファイル

必須オプション:

- `-r, --rules-dir <DIR>`: Hayabusaで使用した `.yml` ルールファイルのディレクトリ
- `-t, --timeline <CSV-FILE>`: HayabusaのCSVタイムライン

任意オプション:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: ルールファイルのカラム名を指定 (デフォルト: Hayabusaの規定値の`RuleFile`)
- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル (デフォルト: 標準出力)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `list-unused-rules`コマンドの使用例

HayabusaでCSVタイムラインを出力する:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

結果を標準出力に表示する:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

結果をテキストファイルに保存する:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

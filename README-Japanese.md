<div align="center">
 <p>
     <img alt="Takajo Logō" src="logo.png" width="50%">
 </p>
 [ <a href="README.md"><b>English</b></a> ] | [ 日本語 ]
</div>

---

<p align="center">
    <a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/v/release/Yamato-Security/takajo?color=blue&label=Stable%20Version&style=flat""/></a>
    <a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/downloads/Yamato-Security/takajo/total?style=flat&label=GitHub%F0%9F%A6%85Downloads&color=blue"/></a>
    <a href="https://github.com/Yamato-Security/takajo/stargazers"><img src="https://img.shields.io/github/stars/Yamato-Security/takajo?style=flat&label=GitHub%F0%9F%A6%85Stars"/></a>
    <a href="https://codeblue.jp/2022/en/talks/?content=talks_24"><img src="https://img.shields.io/badge/CODE%20BLUE%20Bluebox-2022-blue"></a>
    <a href="https://www.seccon.jp/2022/seccon_workshop/windows.html"><img src="https://img.shields.io/badge/SECCON-2023-blue"></a>
    <a href="https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/"><img src="https://img.shields.io/badge/SANS%20DFIR%20Summit-2023-blue"></a>
    <a href=""><img src="https://img.shields.io/badge/Maintenance%20Level-Actively%20Developed-brightgreen.svg" /></a>
    <a href="https://twitter.com/SecurityYamato"><img src="https://img.shields.io/twitter/follow/SecurityYamato?style=social"/></a>
</p>

## Takajoについて

Takajō (鷹匠)は 日本の[Yamato Security](https://yamatosecurity.connpass.com/)グループによって作られた [Hayabusa](https://github.com/Yamato-Security/hayabusa)から得られた結果を解析するツールです。Takajōは[Nim](https://nim-lang.org/)で作られました。
Takajōは、日本語で["鷹狩りのスキルに優れた人"](https://en.wikipedia.org/wiki/Falconry)を意味し、ハヤブサが得た結果をさらに活かすことから選ばれました。

# 関連プロジェクト

* [EnableWindowsLogSettings](https://github.com/Yamato-Security/EnableWindowsLogSettings) - Sigmaベースの脅威ハンティングと、Windowsイベントログのファストフォレンジックタイムライン生成ツール。
* [Hayabusa](https://github.com/Yamato-Security/hayabusa/blob/main/README-Japanese.md) - Windowsイベントログを正しく設定するためのドキュメンテーションとスクリプト。
* [Hayabusa Rules](https://github.com/Yamato-Security/hayabusa-rules/blob/main/README-Japanese.md) - Hayabusaのための検知ルール。
* [Hayabusa Sample EVTXs](https://github.com/Yamato-Security/hayabusa-sample-evtx) - Hayabusa/Sigma検出ルールをテストするためのサンプルevtxファイル。
* [WELA (Windows Event Log Analyzer)](https://github.com/Yamato-Security/WELA/blob/main/README-Japanese.md) - PowerShellで書かれたWindowsイベントログの解析ツール。

## 目次
- [関連プロジェクト](#関連プロジェクト)
  - [目次](#目次)
  - [機能](#機能)
- [ダウンロード](#ダウンロード)
  - [Gitクローン](#gitクローン)
  - [アドバンス: ソースコードからのコンパイル（任意）](#アドバンス-ソースコードからのコンパイル任意)
- [コマンド一覧](#コマンド一覧)
  - [Listコマンド](#listコマンド)
  - [Splitコマンド](#splitコマンド)
  - [Stackコマンド](#stackコマンド)
  - [Sysmonコマンド](#sysmonコマンド)
  - [Timelineコマンド](#timelineコマンド)
  - [VirusTotalコマンド](#virustotalコマンド)
- [コマンド使用方法](#コマンド使用方法)
  - [Listコマンド](#listコマンド-1)
    - [`list-domains`コマンド](#list-domainsコマンド)
      - [`list-domains`コマンドの使用例](#list-domainsコマンドの使用例)
    - [`list-ip-addresses`コマンド](#list-ip-addressesコマンド)
      - [`list-ip-addresses`コマンドの使用例](#list-ip-addressesコマンドの使用例)
    - [`list-undetected-evtx`コマンド](#list-undetected-evtxコマンド)
      - [`list-undetected-evtx`コマンドの使用例](#list-undetected-evtxコマンドの使用例)
    - [`list-unused-rules`コマンド](#list-unused-rulesコマンド)
      - [`list-unused-rules`コマンドの使用例](#list-unused-rulesコマンドの使用例)
  - [Splitコマンド](#splitコマンド-1)
    - [`split-csv-timeline`コマンド](#split-csv-timelineコマンド)
      - [`split-csv-timeline`コマンドの使用例](#split-csv-timelineコマンドの使用例)
    - [`split-json-timeline`コマンド](#split-json-timelineコマンド)
      - [`split-json-timeline`コマンドの使用例](#split-json-timelineコマンドの使用例)
  - [Stackコマンド](#stackコマンド-1)
    - [`stack-logons`コマンド](#stack-logonsコマンド)
      - [`stack-logons`コマンドの使用例](#stack-logonsコマンドの使用例)
  - [Sysmonコマンド](#sysmonコマンド-1)
    - [`sysmon-process-hashes`コマンド](#sysmon-process-hashesコマンド)
      - [`sysmon-process-hashes`コマンドの使用例](#sysmon-process-hashesコマンドの使用例)
    - [`sysmon-process-tree`コマンド](#sysmon-process-treeコマンド)
      - [`sysmon-process-tree`コマンドの使用例](#sysmon-process-treeコマンドの使用例)
  - [Timelineコマンド](#timelineコマンド-1)
    - [`timeline-logon`コマンド](#timeline-logonコマンド)
      - [`timeline-logon`コマンドの使用例](#timeline-logonコマンドの使用例)
    - [`timeline-suspicious-processes`コマンド](#timeline-suspicious-processesコマンド)
      - [`timeline-suspicious-processes`コマンドの使用例](#timeline-suspicious-processesコマンドの使用例)
  - [VirusTotalコマンド](#virustotalコマンド-1)
    - [`vt-domain-lookup`コマンド](#vt-domain-lookupコマンド)
      - [`vt-domain-lookup`コマンドの使用例](#vt-domain-lookupコマンドの使用例)
    - [`vt-hash-lookup`コマンド](#vt-hash-lookupコマンド)
      - [`vt-hash-lookup`コマンドの使用例](#vt-hash-lookupコマンドの使用例)
    - [`vt-ip-lookup`コマンド](#vt-ip-lookupコマンド)
      - [`vt-ip-lookup`コマンドの使用例](#vt-ip-lookupコマンドの使用例)
  - [貢献](#貢献)
  - [バグの報告](#バグの報告)
  - [ライセンス](#ライセンス)
  - [Twitter](#twitter)

## 機能
- Nimで開発され、プログラミングが簡単、メモリ安全、ネイティブCコードと同じくらい高速で、単一のスタンドアロンバイナリとして動作します。
- ログオンイベント、疑わしいプロセスなどさまざまなタイムラインを作成します。
- 不審なプロセスのプロセスツリーを出力します。
- さまざまなスタッキング分析ができます。
- CSVとJSONLのタイムラインを分割します。
- VirusTotalの検索で使用するIPアドレス、ドメイン、ハッシュなどをリストアップします。
- ドメイン、ハッシュ、IPアドレスをVirusTotalで検索します。
- 検知されていない`.evtx` ファイルをリストアップします。

# ダウンロード

[Releases](https://github.com/Yamato-Security/takajo/releases)ページからTakajōの安定したバージョンでコンパイルされたバイナリが含まれている最新版もしくはソースコードをダウンロードできます。

## Gitクローン

以下の`git clone`コマンドでレポジトリをダウンロードし、ソースコードからコンパイルして使用することも可能です：

>> 注意: mainブランチは開発中のバージョンです。まだ正式にリリースされていない新機能が使えるかもしれませんが、バグがある可能性もあるので、テスト版だと思って下さい。

`git clone https://github.com/Yamato-Security/takajo.git`

## アドバンス: ソースコードからのコンパイル（任意）

Nimがインストールされている場合、以下のコマンドでソースコードからコンパイルできます:

```
> nimble update
> nimble build -d:release -d:ssl
```

# コマンド一覧

## Listコマンド
* `list-domains`: `vt-domain-lookup`コマンドで使用する、重複のないドメインのリストを作成する
* `list-ip-addresses`: `vt-ip-lookup`コマンドで使用する、重複のない送信元/送信先のIPリストを作成する
* `list-undetected-evtx`: 検知されなかったevtxファイルのリストを作成する
* `list-unused-rules`: 検知されなかったルールのリストを作成する

## Splitコマンド
* `split-csv-timeline`: コンピューター名に基づき、大きなCSVタイムラインを小さなCSVタイムラインに分割する
* `split-json-timeline`: コンピューター名に基づき、大きなJSONLタイムラインを小さなJSONLタイムラインに分割する

## Stackコマンド
* `stack-logons`: ユーザー名、コンピューター名、送信元IPアドレス、送信元コンピューター名など、項目ごとの上位ログオンを出力する

## Sysmonコマンド
* `sysmon-process-hashes`: `vt-hash-lookup` で使用するプロセスのハッシュ値のリストを作成する
* `sysmon-process-tree`: プロセスツリーを出力する

## Timelineコマンド
* `timeline-logon`: ログオンイベントのCSVタイムラインを作成する
* `timeline-suspicious-processes`: 不審なプロセスのCSVタイムラインを作成する

## VirusTotalコマンド
* `vt-domain-lookup`: VirusTotalでドメインのリストを検索し、悪意のあるドメインをレポートする
* `vt-hash-lookup`: VirusTotalでハッシュのリストを検索し、悪意のあるハッシュ値をレポートする
* `vt-ip-lookup`: VirusTotalでIPアドレスのリストを検索し、悪意のあるIPアドレスをレポートする

# コマンド使用方法

## Listコマンド

### `list-domains`コマンド


`vt-domain-lookup` で使用する重複のないドメインのリストを作成します。
現在は、Sysmon EID 22ログでクエリが記録されたドメインのみをチェックしますが、ビルトインのWindows DNSクライアント・サーバーログも今後サポート予定です。

* 入力: `JSONL`
* プロファイル: `all-field-info` と`all-field-info-verbose` 以外すべて
* 出力: `テキストファイル`

必須オプション:

- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル
- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン

任意オプション:

- `-s, --includeSubdomains`: サブドメインを含めるか (デフォルト: `false`)
- `-w, --includeWorkstations`: ローカルワークステーション名を含めるか (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `list-domains`コマンドの使用例

HayabusaでJSONLタイムラインを出力する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

結果をテキストファイルに保存する:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

サブドメインを含める場合:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

### `list-ip-addresses`コマンド


`vt-ip-lookup`で使用する重複のない送信先/送信先IPアドレスのリストを作成します。すべての結果から送信先IPアドレスの`TgtIP`フィールドと送信元IPアドレスの `SrcIP`フィールドが抽出され、重複のないIPアドレスをテキストファイルに出力します。

* 入力: `JSONL`
* プロファイル: `all-field-info` と `all-field-info-verbose` 以外すべて
* 出力: `テキストファイル`

必須オプション:

- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル
- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン

任意オプション:

- `-i, --inbound`: インバウンドトラフィックを含めるか (デフォルト: `true`)
- `-O, --outbound`: アウトバウンドトラフィックを含めるか (デフォルト: `true`)
- `-p, --privateIp`: プライベートIPアドレスを含めるか (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `list-ip-addresses`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

結果をテキストファイルに保存する:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

インバウンドトラフィックを除外する:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

プライベートIPアドレスを含める:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

### `list-undetected-evtx`コマンド
Hayabusaで検知するルールがなかったすべての`.evtx`ファイルをリストアップします。これは、[hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx)リポジトリ内のevtxファイルなど、悪意のあるアクティビティの証拠を含むすべてのevtxファイルをリストアップすることを目的としています

* 入力: `CSV`
* プロファイル: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > まず、`%EvtxFile%`を出力するプロファイルを使用し、Hayabusaを実行、結果をCSVタイムラインに保存する必要があります
  > [こちら](https://github.com/Yamato-Security/hayabusa#profiles)でHayabusaがプロファイルに従って、どのカラムを保存するかを確認できます。
* 出力: `標準出力 または テキストファイル`

必須オプション:

- `-e, --evtx-dir <EVTX-DIR>`: Hayabusaでスキャンした`.evtx` ファイルのディレクトリ
- `-t, --timeline <CSV-FILE>`: HayabusaのCSVタイムライン

任意オプション:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: evtxのカラム名を指定 (デフォルト: Hayabusaの規定値の`EvtxFile`)
- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル (デフォルト: 標準出力)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `list-undetected-evtx`コマンドの使用例

HayabusaでCSVタイムラインを出力する:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv
```

結果を標準出力に表示する:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

結果をテキストファイルに保存する:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

### `list-unused-rules`コマンド

何も検出されなかったすべての`.yml`ルールをリストアップします。これは、ルールの信頼性を判断するのに役立ちます。つまり、どのルールが悪意のあるアクティビティを検出するか、またどのルールがまだテストされておらずサンプル`.evtx`ファイルが必要かの判断に使えます。

* 入力: `CSV`
* プロファイル: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > まず、`%RuleFile%`を出力するプロファイルを使用し、Hayabusaを実行、結果をCSVタイムラインに保存する必要があります
  > [こちら](https://github.com/Yamato-Security/hayabusa#profiles)でHayabusaがプロファイルに従って、どのカラムを保存するかを確認できます。
* 出力: `標準出力 または テキストファイル`

必須オプション:

- `-r, --rules-dir <DIR>`: Hayabusaで使用した `.yml` ルールファイルのディレクトリ
- `-t, --timeline <CSV-FILE>`: HayabusaのCSVタイムライン

任意オプション:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: ルールファイルのカラム名を指定 (デフォルト: Hayabusaの規定値の`RuleFile`)
- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル (デフォルト: 標準出力)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `list-unused-rules`コマンドの使用例

HayabusaでCSVタイムラインを出力する:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv
```

結果を標準出力に表示する:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

結果をテキストファイルに保存する:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

## Splitコマンド

### `split-csv-timeline`コマンド

コンピューター名に基づき、大きなCSVタイムラインを小さなCSVタイムラインに分割します。

* 入力: `複数行モード(-M)でないCSV`
* プロファイル: `すべて`
* 出力: `複数のCSV`

必須オプション:

- `-t, --timeline <CSV-FILE>`: HayabusaのCSVタイムライン

任意オプション:

- `-m, --makeMultiline`: フィールドを複数行で出力する (デフォルト: `false`)
- `-o, --output <DIR>`: CSVを保存するディレクトリ (デフォルト: `output`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `split-csv-timeline`コマンドの使用例

HayabusaでCSVタイムラインを出力する:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv
```

1つのCSVタイムラインを複数のCSVタイムラインに分割して `output` ディレクトリに出力:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

フィールドを改行文字で区切って複数行のエントリを作成し、`case-1-csv`ディレクトリに保存:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

### `split-json-timeline`コマンド

コンピューター名に基づき、大きなJSONLタイムラインを小さなJSONLタイムラインに分割します。

* 入力: `JSONL`
* プロファイル: `すべて`
* 出力: `複数のJSONL`

必須オプション:

- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン

任意オプション:

- `-o, --output <DIR>`: JSONLを保存するディレクトリ (デフォルト: `output`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `split-json-timeline`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

1つのJSONLタイムラインを複数のJSONLタイムラインに分割して `output` ディレクトリに出力:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

`case-1-jsonl` ディレクトリに保存:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

## Stackコマンド

### `stack-logons`コマンド

ログインしている上位アカウントのリストを作成します (入力: JSONL, プロファイル: standard)  
まだ実装されていません。

#### `stack-logons`コマンドの使用例

```
takajo.exe stack-remote-logons -t ../hayabusa/timeline.jsonl
```

## Sysmonコマンド

### `sysmon-process-hashes`コマンド

`vt-hash-lookup`で使用するプロセスハッシュ値のリストを作成します (入力: JSONL, プロファイル: standard)

* 入力: `JSONL`
* プロファイル: `all-field-info` と `all-field-info-verbose`以外すべて
* 出力: `テキストファイル`

必須オプション:

- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン
- `-o, --output <BASE-NAME>`: 結果を保存するベースファイル名

任意オプション:

- `-l, --level`: 最小のアラートレベルを指定 (デフォルト: `high`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `sysmon-process-hashes`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

ハッシュタイプ毎に異なるファイルに結果を保存する:

```
takajo.exe sysmon-process-hashes -t ../hayabusa/timeline.jsonl -o case-1
```
たとえば、`MD5`、`SHA1` 、`IMPHASH` がSysmonログに保存されている場合、 次のファルが作成されます:   
`case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`


### `sysmon-process-tree`コマンド

不審なプロセスや悪意のあるプロセスなど、特定のプロセスのプロセスツリーを出力します。

* 入力: `JSONL`
* プロファイル: `all-field-info` と `all-field-info-verbose` 以外すべて
* 出力: `テキストファイル`

必須オプション:

- `-p, --processGuid <Process GUID>`: SysmonのプロセスGUID
- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン

任意オプション:

- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `sysmon-process-tree`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

標準出力に結果を表示する:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00"
```

結果をテキストファイルに保存する:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

## Timelineコマンド

### `timeline-logon`コマンド

このコマンドは、次のログオンイベントから情報を抽出し、フィールドを正規化し、結果をCSVファイルに保存します:

- `4624` - ログオン成功
- `4625` - ログオン失敗
- `4634` - アカウントログオフ
- `4647` - ユーザーが開始したログオフ
- `4648` - 明示的なログオン
- `4672` - 特権ログオン

これにより、ラテラルムーブメント、パスワードスプレー、権限昇格などを検出しやすくなります。

* 入力: `JSONL`
* プロファイル: `all-field-info` と `all-field-info-verbose` 以外すべて
* 出力: `CSV`

必須オプション:

- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン

任意オプション:

- `-c, --calculateElapsedTime`: 成功ログオンの経過時間を計算する (デフォルト: `true`)
- `-l, --outputLogoffEvents`: ログオフイベントを別のエントリとして出力する (デフォルト: `false`)
- `-a, --outputAdminLogonEvents`: 管理者ログオン イベントを別のエントリとして出力する (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `timeline-logon`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
```

ログオンタイムラインをCSVに保存する:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-suspicious-processes`コマンド

不審なプロセスのCSVタイムラインを作成する

* 入力: `JSONL`
* プロファイル: `all-field-info` と `all-field-info-verbose` 以外すべて
* 出力: `CSV`

必須オプション:

- `-t, --timeline <JSONL-FILE>`: HayabusaのJSONLタイムライン

任意オプション:

- `-l, --level <LEVEL>`: 最小のアラートレベルを指定 (デフォルト: `high`)
- `-o, --output <CSV-FILE>`: 結果を保存するCSVファイル
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `timeline-suspicious-processes`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl
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

## VirusTotalコマンド

### `vt-domain-lookup`コマンド

VirusTotalでドメインのリストを検索します。

* 入力: `テキストファイル`
* 出力: `CSV`

必須オプション:

- `-a, --apiKey <API-KEY>`: VirusTotalのAPIキー
- `-d, --domainList <TXT-FILE>`: ドメイン一覧のテキストファイル
- `-o, --output <CSV-FILE`: 結果を保存するCSV

任意オプション:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotalからのすべてのJSONレスポンスを出力するJSONファイル
- `-r, --rateLimit <NUMBER>`: 1分間に送るリクエスト数レート制限 (デフォルト: `4`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `vt-domain-lookup`コマンドの使用例

はじめに、`list-domains`コマンドでドメイン一覧を作成し、その後
次のコマンドを使用してそれらのドメインを検索します:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

### `vt-hash-lookup`コマンド

VirusTotalでハッシュのリストを検索します。

* 入力: `テキストファイル`
* 出力: `CSV`

必須オプション:

- `-a, --apiKey <API-KEY>`: VirusTotalのAPIキー
- `-H, --hashList <HASH-LIST>`: ハッシュ値一覧のテキスト
- `-o, --output <CSV-FILE`: 結果を保存するCSV

任意オプション:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotalからのすべてのJSONレスポンスを出力するJSONファイル
- `-r, --rateLimit <NUMBER>`: 1分間に送るリクエスト数レート制限 (デフォルト: `4`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

#### `vt-hash-lookup`コマンドの使用例

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

### `vt-ip-lookup`コマンド

VirusTotalでIPアドレスのリストを検索します。

* 入力: `テキストファイル`
* 出力: `CSV`

必須オプション:

- `-a, --apiKey <API-KEY>`: VirusTotalのAPIキー
- `-i, --ipList <IP-ADDRESS-LIST>`: IPアドレスのテキストファイル
- `-o, --output <CSV-FILE`: 結果を保存するCSV

任意オプション:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotalからのすべてのJSONレスポンスを出力するJSONファイル
- `-r, --rateLimit <NUMBER>`: 1分間に送るリクエスト数レート制限 (デフォルト: `4`)
- `-q, --quiet`: ロゴを表示しない (デフォルト: `false`)

#### `vt-ip-lookup`コマンドの使用例

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

## 貢献

どのような形でも構いませんので、ご協力をお願いします。プルリクエスト、ルール作成、evtxログのサンプルなどがベストですが、機能リクエスト、バグの通知なども大歓迎です。

少なくとも、私たちのツールを気に入っていただけたなら、GitHubで星を付けて、あなたのサポートを表明してください。

## バグの報告

このプロジェクトは活発なメンテナンスを行っています。
見つけたバグを[こちら](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D)でご連絡ください。報告されたバグを喜んで修正します！

もし、Hayabusaで何かしらの問題(フォルスポジティブ、 バグ、その他)を見つけましたら、[こちら](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D) でご連絡ください。

もし、Hayabusaルールで何かしらの問題(フォルスポジティブ、 バグ、その他)を見つけましたら、[こちら](https://github.com/Yamato-Security/hayabusa-rules/issues/new) でご連絡ください。

もし、Sigmaルールで何かしらの問題(フォルスポジティブ、 バグ、その他)を見つけましたら、SigmaHQの[こちら](https://github.com/SigmaHQ/sigma/issues) でご連絡ください。

## ライセンス

Takajōは[GPLv3ライセンス](https://www.gnu.org/licenses/gpl-3.0.en.html)で公開されています。

## Twitter

[@SecurityYamato](https://twitter.com/SecurityYamato)でTakajō`、 Hayabusa、ルール更新、その他の大和セキュリティツール等々について情報を提供しています。

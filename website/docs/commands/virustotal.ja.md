# VirusTotalコマンド

## `vt-domain-lookup`コマンド

VirusTotalでドメインのリストを検索します。

* 入力: テキストファイル
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: CSV

必須オプション:

- `-a, --apiKey <API-KEY>`: VirusTotalのAPIキー
- `-d, --domainList <TXT-FILE>`: ドメイン一覧のテキストファイル
- `-o, --output <CSV-FILE>`: 結果を保存するCSV

任意オプション:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotalからのすべてのJSONレスポンスを出力するJSONファイル
- `-r, --rateLimit <NUMBER>`: 1分間に送るリクエスト数レート制限 (デフォルト: `4`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `vt-domain-lookup`コマンドの使用例

はじめに、`list-domains`コマンドでドメイン一覧を作成し、その後
次のコマンドを使用してそれらのドメインを検索します:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup`コマンド

VirusTotalでハッシュのリストを検索します。

* 入力: テキストファイル
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: CSV

必須オプション:

- `-a, --apiKey <API-KEY>`: VirusTotalのAPIキー
- `-H, --hashList <HASH-LIST>`: ハッシュ値一覧のテキスト
- `-o, --output <CSV-FILE>`: 結果を保存するCSV

任意オプション:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotalからのすべてのJSONレスポンスを出力するJSONファイル
- `-r, --rateLimit <NUMBER>`: 1分間に送るリクエスト数レート制限 (デフォルト: `4`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `vt-hash-lookup`コマンドの使用例

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup`コマンド

VirusTotalでIPアドレスのリストを検索します。

* 入力: テキストファイル
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: CSV

必須オプション:

- `-a, --apiKey <API-KEY>`: VirusTotalのAPIキー
- `-i, --ipList <IP-ADDRESS-LIST>`: IPアドレスのテキストファイル
- `-o, --output <CSV-FILE>`: 結果を保存するCSV

任意オプション:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotalからのすべてのJSONレスポンスを出力するJSONファイル
- `-r, --rateLimit <NUMBER>`: 1分間に送るリクエスト数レート制限 (デフォルト: `4`)
- `-q, --quiet`: ロゴを表示しない (デフォルト: `false`)

### `vt-ip-lookup`コマンドの使用例

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

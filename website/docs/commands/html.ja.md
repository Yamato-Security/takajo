# HTMLコマンド

## `html-report`コマンド

ルールと検出されたコンピュータのHTMLサマリレポートを作成します。
このコマンドは、サマリレポートの作成に必要なデータの高速検索を実行するために、まずインデックス化されたDuckDBデータベースファイル（デフォルト）またはSQLiteデータベースファイルを作成します。

* 入力: JSONL
* プロファイル: `verbose`/`super-verbose`プロファイル
* 出力: コンピュータ名とメインページの`index.html`に基づいた個別のHTMLサマリレポート

必須オプション:

- `-o, --output`: htmlレポートのディレクトリ名
- `-r, --rulepath`: Hayabusaルールディレクトリへのパス
- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインのファイル名またはディレクトリ名

任意オプション:

- `-C, --clobber`: 保存時にデータベースファイルを上書きする (デフォルト: `false`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)
- `-s, --dboutput`: 結果をデータベースファイルに保存する (デフォルト: `html-report.duckdb`、`--sqlite`指定時は`html-report.sqlite`)
- `--skipProgressBar`: プログレスバーを出力しない (デフォルト: `false`)
- `--sqlite`: DuckDBの代わりにSQLiteバックエンドを使用する (デフォルト: `false`)

### `html-report`コマンドの使用例

HayabusaでJSONLタイムラインを出力する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

または

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

HTMLサマリレポートを作成する:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report`スクリーンショット

#### ルールサマリ

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### コンピュータサマリ

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### ルール一覧

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server`コマンド

HTMLサマリレポートを確認するために、動的にウェブサーバを立ち上げます。
このコマンドは、サマリレポートの作成に必要なデータの高速検索を実行するために、まずインデックス化されたDuckDBデータベースファイル（デフォルト）またはSQLiteデータベースファイルを作成します。
`html-report`コマンドと似ていますが、よりスケーラブルで日付やルールのフィルタリングが可能です。

* 入力: JSONL
* プロファイル: `verbose`/`super-verbose`プロファイル
* 出力: デフォルトでは、`http://localhost:8823`で待ち受ける

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインのファイル名またはディレクトリ名

任意オプション:

- `-C, --clobber`: 保存時にデータベースファイルを上書きする (デフォルト: `false`)
- `-p, --port`: ウェブサーバのポート番号 (デフォルト: `8823`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)
- `-r, --rulepath`: Hayabusaルールディレクトリへのパス (※必須ではないが、ルールファイルへのリンクを作成するために必要。）)
- `-s, --dboutput`: 結果をデータベースファイルに保存する (デフォルト: `html-report.duckdb`、`--sqlite`指定時は`html-report.sqlite`)
- `--skipProgressBar`: プログレスバーを出力しない (デフォルト: `false`)
- `--sqlite`: DuckDBの代わりにSQLiteバックエンドを使用する (デフォルト: `false`)

### `html-server` command example

HayabusaでJSONLタイムラインを出力する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

または

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

ウェブサーバを起動する:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server`スクリーンショット

#### ルール一覧

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### コンピュータサマリ

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### 日付フィルタリング

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### ルールフィルタリング

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

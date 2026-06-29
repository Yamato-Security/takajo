# Automationコマンド
## `automagic`コマンド

多くのコマンドを自動的に実行し、結果を新しいフォルダーに出力する

> 注意: すべてのコマンドを使用するには、`verbose`または`super-verbose`プロファイルを使用する必要があります。

* 入力: JSONL
* プロファイル: `all-field-info` と`all-field-info-verbose` 以外すべて
* 出力: すべての結果ファイルが出力されたフォルダー

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-d, --displayTable`: テーブル結果をターミナルに出力する (デフォルト: `false`)
- `-l, --level`: 最小のアラートレベルを指定 (デフォルト: `informational`)
- `-o, --output`: 出力ディレクトリ (デフォルト: `case-1`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)
- `-s, --skipProgressBar`: プログレスバーを出力しない (デフォルト: `false`)

### `automagic`コマンドの使用例

HayabusaでJSONLタイムラインを出力する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

できるだけ多くのTakajoコマンドを実行し、結果を`case-1`フォルダーに保存:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

できるだけ多くのTakajoコマンドを`hayabusa-results`ディレクトリに対して実行し、結果を`case-1`フォルダに保存r:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

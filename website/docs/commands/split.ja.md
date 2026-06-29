# Splitコマンド

## `split-csv-timeline`コマンド

コンピューター名に基づき、大きなCSVタイムラインを小さなCSVタイムラインに分割します。

* 入力: 複数行モード(-M)でないCSV
* プロファイル: すべて
* 出力: 複数のCSV

必須オプション:

- `-t, --timeline <CSV-FILE>`: HayabusaのCSVタイムライン

任意オプション:

- `-m, --makeMultiline`: フィールドを複数行で出力する (デフォルト: `false`)
- `-o, --output <DIR>`: CSVを保存するディレクトリ (デフォルト: `output`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `split-csv-timeline`コマンドの使用例

HayabusaでCSVタイムラインを出力する:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

1つのCSVタイムラインを複数のCSVタイムラインに分割して `output` ディレクトリに出力:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

フィールドを改行文字で区切って複数行のエントリを作成し、`case-1-csv`ディレクトリに保存:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline`コマンド

コンピューター名に基づき、大きなJSONLタイムラインを小さなJSONLタイムラインに分割します。

* 入力: JSONL
* プロファイル: すべて
* 出力: 複数のJSONL

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-o, --output <DIR>`: JSONLを保存するディレクトリ (デフォルト: `output`)
- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `split-json-timeline`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

1つのJSONLタイムラインを複数のJSONLタイムラインに分割して `output` ディレクトリに出力:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

`case-1-jsonl` ディレクトリに保存:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

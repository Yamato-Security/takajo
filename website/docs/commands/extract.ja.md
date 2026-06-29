# Extractコマンド

## `extract-scriptblocks`コマンド

PowerShell EID 4104 スクリプトブロックログからPowerShellスクリプトを抽出して再構築します。

> 注意: PowerShellスクリプトは、コード構文が強調表示された「.ps1」ファイルとして開くのが最適ですが、悪意のあるコードが誤って実行されるのを防ぐために「.txt」拡張子を使用します。

* 入力: JSONL
* プロファイル: すべて
* 出力: ターミナルとPowerShellスクリプトのディレクトリ

必須オプション:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムライン

任意オプション:

 - `-l, --level`: 最小のアラートレベルを指定 (デフォルト: `low`)
 - `-o, --output`: PowerShellスクリプトを保存するディレクトリ  (デフォルト: `scriptblock-logs`)
 - `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `extract-scriptblocks`コマンドの使用例

HayabusaでJSONLタイムラインを出力する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

PowerShell EID 4104 スクリプトブロックログから抽出し、`scriptblock-logs`ディレクトリに保存します:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### `extract-scriptblocks`スクリーンショット

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

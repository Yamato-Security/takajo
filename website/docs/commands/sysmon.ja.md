# Sysmonコマンド

## `sysmon-process-tree`コマンド

不審なプロセスや悪意のあるプロセスなど、特定のプロセスのプロセスツリーを出力します。

* 入力: JSONL
* プロファイル: `all-field-info`と`all-field-info-verbose`以外すべて
* 出力: テキストファイル

必須オプション:

- `-o, --output <TXT-FILE>`: 結果を保存するテキストファイル
- `-p, --processGuid <Process GUID>`: SysmonのプロセスGUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: HayabusaのJSONLタイムラインまたはディレクトリ

任意オプション:

- `-q, --quiet`: ロゴを出力しない (デフォルト: `false`)

### `sysmon-process-tree`コマンドの使用例

HayabusaでJSONLタイムラインを作成する:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

結果をテキストファイルに保存する:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree`スクリーンショット

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

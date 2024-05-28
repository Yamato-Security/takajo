# 変更点

## x.x.x [xxxx/xx/xx]

**改善:**

- `stack-logons`コマンドに`-f, --failedLogons`オプションを追加して、`automagic`コマンドで失敗したログイン集計を出力するようにした。 (#152) (@fukusuket)
- MITRE ATT&CKをv15.0に更新した。 (#155) (@fukusuket)

**バグ修正:**

- https://github.com/treeform/puppy/issues/118 によるmacOSでのコンパイルエラーを修正した。 (#158) (@YamatoSecurity)

## 2.5.0 [2024/03/30] - BSides Tokyo Release

**新機能:**

- `automagic`コマンド: 可能な限り多くのコマンドを自動的に実行し、結果を新しいフォルダに出力する。(#132) (@fukusuket)
- `stack-computers`コマンド: `Computer`(デフォルト)または`SrcComp`フィールドのスタック分析をしながら、アラート情報も提供する。(#125) (@fukusuket)
- `stack-ip-addresses`コマンド: `SrcIP`(デフォルト)または`TgtIP`フィールドのスタック分析をしながら、アラート情報も提供する。(#129) (@fukusuket)
- `stack-users`コマンド: `TgtUser`(デフォルト)または`SrcUser`フィールドのスタック分析をしながら、アラート情報も提供する。(#130) (@fukusuket)
- スキャン時に複数の`.jsonl`ファイルが入っているディレクトリを指定できるようになった。 #133 (@hitenkoku)

**改善:**

- 重複するコードを削除するためのリファクタリング。 (#99) (@fukusuket)
- JSONのパースを`jsony`に変更することで、処理速度が2倍以上速くなった。 (#122) (@fukusuket)
- 読みやすくするため、大きな数字に小数点を追加した。 (#120) (@fukusuket)

## 2.4.0 [2024/02/22] - Ninja Day Release

**新機能:**

- `stack-cmdlines`コマンド: 実行されたコマンドラインのスタック分析。(#94) (@fukusuket)
- `stack-dns`コマンド: DNSリクエストのスタック分析。(#95) (@fukusuket)
- `stack-processes`コマンド: 実行されたプロセスのスタック分析。(#93) (@fukusuket)
- `stack-tasks`コマンド: スケジュールされたタスクのパースとスタック分析。(#97) (@fukusuket)
- `timeline-tasks`コマンド: 作成されたスケジュールタスクをパースし、CSVファイルに保存する。 (#110) (@fukusuket)
- `ttp-visualize-sigma`コマンド: MITRE ATT&CK Navigatorにアップロードし、SigmaルールのTTPをヒートマップで可視化するために、JSONファイルに作成する。(#92) (@fukusuket)

**改善:**

- `ttp-visualize`コマンド: ヒートマップにカラーグラデーションを追加した。(#90) (@fukusuket)

**バグ修正:**

- `split-csv-timeline`コマンドが、Haybuasa 2.13.0のCSV結果で失敗するので、修正した。(#103) (@fukusuket)

## 2.3.1 [2024/01/27] - Year Of The Dragon Release

**改善:**

- `ttp-visualize` コマンドで、MITRE ATT&CK Navigator上のテクニックをマウスオーバーしたときに、検知ルール名が表示されるようした。(#82) (@fukusuket)
- `ttp-summary`コマンドの結果にルールのタイトルを追加した。(#83) (@fukusuket)

**バグ修正:**

`timeline-suspicious-process`コマンドで、Security 4688またはSysmon 1のイベント数が0であり、他の形式のイベントがある場合、CSVファイルは保存されなかった。(#86) (@YamatoSecurity)

## 2.3.0 [2023/12/23] - SECCON Christmas Release

**新機能:**

- ATT&CK Navigatorで可視化するために、TTPを抽出してJSONファイルを作成する`ttp-visualize`コマンドを追加した。 (#76) (@fukusuket)
- コンピュータ毎に検知されたTTPsの要約を出力する`ttp-summary`コマンドを追加した。 (#78) (@fukusuket)


**バグ修正:**

- `timeline-partition-diagnostic`コマンドの文字化けを修正した。 (#74) (@fukusuket)

## 2.2.0 [2023/12/03] - Nasi Lemak Release

**新機能:**

- Windows10の`Microsoft-Windows-Partition%4Diagnostic.evtx`を解析し、接続されたすべてのデバイスおよびそれらのボリュームシリアル番号に関する情報を出力する`timeline-partition-diagnostic`コマンドを追加した。現在および過去に接続されたデバイスに関する情報を出力する。 (処理は https://github.com/theAtropos4n6/Partition-4DiagnosticParser を参考に作成された) (#70) (@fukusuket)

**改善:**

- `vt-lookup`コマンドのプログレスバーの表示を改善した。 (#68) (@fukusuket)

**バグ修正:**

- キーが存在しない場合の未処理の例外のバグを修正した。 (#65) (@fukusuket)
- JSON入力の場合、`extract-scriptblocks`コマンドで改行処理が正しく行われていなかった。 (#71) (@fukusuket)

## 2.1.0 [2023/10/31] - Halloween Release

**新機能:**

- PowerShell EID 4104のScriptBlockログを元に戻す`extract-scriptblocks`コマンドを追加した。 (#47) (@fukusuket)

**改善:**

- TakajoがNim 2.0.0でコンパイルできるようになった。(#31) (@fukusuket)
- 依存関係を減らすため、HTTPクライアントをPuppyに置き換えた。 (#33) (@fukusuket)
- パフォーマンス向上のため、VirusTotalクエリをマルチスレッドにした。 (#33) (@fukusuket)
- タイムラインを指定する際のファイル存在チェックを追加した。 (@fukusuket)
- タイムラインがJSONL形式でない場合の警告を追加した。(#43) (@fukusuket)
- `sysmon-process-tree`コマンドでルートプロセス情報も出力する。プロセスがタイムスタンプ順にソートされるようになった。(#54) (@fukusuket)

**バグ修正*:**

- Hayabusa 2.8.0以上の結果で`timeline-suspicious-processes`を実行した際のクラッシュを修正した。 (#35) (@fukusuket)
- 無効なAPIキーが指定された場合に、VirusTotalの検索でJSONパースエラーが発生する問題を修正した。(@fukusuket)
- `sysmon-process-tree`コマンドでプロセス情報が2回出力されることがあるバグを修正した。(#52) (@fukusuket)
- `timeline-suspicious-processes`が`ParentPGUID`フィールドを正しく出力していなかったので修正した。また、PIDの10進数変換を改善した。(#50) (@fukusuket)
- 指定された`PGUID`が無効であるか、JSONL タイムラインに存在しない場合にエラーが発生する問題を修正した。 (#53) (@fukusuket)

## 2.0.0 [2022/08/03] - [SANS DFIR Summit 2023 Release](https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/)

**新機能:**

- `list-domains`: `vt-domain-lookup`コマンドで使用する、重複のないドメインのリストを作成する。 (@YamatoSecurity)
- `list-hashes`: `vt-hash-lookup`で使用するプロセスのハッシュ値のリストを作成する。 (@YamatoSecurity)
- `list-ip-addresses`: `vt-ip-lookup`コマンドで使用する、重複のない送信元/送信先のIPリストを作成する。 (@YamatoSecurity)
- `split-csv-timeline`: コンピューター名に基づき、大きなCSVタイムラインを小さなCSVタイムラインに分割する。 (@YamatoSecurity)
- `split-json-timeline`: コンピューター名に基づき、大きなJSONLタイムラインを小さなJSONLタイムラインに分割する。 (@fukusuket)
- `stack-logons`: ユーザー名、コンピューター名、送信元IPアドレス、送信元コンピューター名など、項目ごとの上位ログオンを出力する。 (@YamatoSecurity)
- `sysmon-process-tree`: プロセスツリーを出力する。 (@hitenkoku)
- `timeline-logon`: ログオンイベントのCSVタイムラインを作成する。 (@YamatoSecurity)
- `timeline-suspicious-processes`: 不審なプロセスのCSVタイムラインを作成する。 (@YamatoSecurity)
- `vt-domain-lookup`: VirusTotalでドメインのリストを検索し、悪意のあるドメインをレポートする。 (@YamatoSecurity)
- `vt-hash-lookup`: VirusTotalでハッシュのリストを検索し、悪意のあるハッシュ値をレポートする。 (@YamatoSecurity)
- `vt-ip-lookup`: VirusTotalでIPアドレスのリストを検索し、悪意のあるIPアドレスをレポートする。 (@YamatoSecurity)

## v1.0.0 [2022/10/28] - [Code Blue 2022 Bluebox Release](https://codeblue.jp/2022/en/talks/?content=talks_24)

**新機能:**

- `list-undetected-evtx-files`: 検知しなかったルールファイルの一覧を表示する機能を追加した。 (#4) (@hitenkoku)
- `list-unused-rules`: 検知しなかったevtxファイルの一覧を表示する機能を追加した。 (#4) (@hitenkoku)
- ロゴを追加。`-q, --quiet`で表示しないようにできる。 (#12) (@YamatoSecurity @hitenkoku)
- `-o, --output`オプションの追加。結果を別ファイルにtxt形式で出力する機能を追加した。 (#11) (@hitenkoku)
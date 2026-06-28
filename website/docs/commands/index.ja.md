# コマンド一覧

## Automationコマンド
* `automagic`: 多くのコマンドを自動的に実行し、結果を新しいフォルダーに出力する

## Extractコマンド
* `extract-scriptblocks`: PowerShell EID 4104 スクリプトブロックログからPowerShellスクリプトを抽出して再構築する

## HTMLコマンド
* `html-report`: ルールと検出されたコンピュータのHTMLサマリレポートを作成する
* `html-server`: HTMLサマリレポートを確認するために、動的にウェブサーバを立ち上げる

## Listコマンド
* `list-domains`: `vt-domain-lookup`コマンドで使用する、重複のないドメインのリストを作成する
* `list-hashes`: `vt-hash-lookup` で使用するプロセスのハッシュ値のリストを作成する
* `list-ip-addresses`: `vt-ip-lookup`コマンドで使用する、重複のない送信元/送信先のIPリストを作成する
* `list-undetected-evtx`: 検知されなかったevtxファイルのリストを作成する
* `list-unused-rules`: 検知されなかったルールのリストを作成する

## Splitコマンド
* `split-csv-timeline`: コンピューター名に基づき、大きなCSVタイムラインを小さなCSVタイムラインに分割する
* `split-json-timeline`: コンピューター名に基づき、大きなJSONLタイムラインを小さなJSONLタイムラインに分割する

## Stackコマンド
* `stack-cmdlines`: 実行されたコマンドラインを集計する
* `stack-dns`: DNSクエリとレスポンスを集計する
* `stack-ip-addresses`: ターゲットIP(`TgtIP`フィールド) またはソースIP (`SrcIP`フィールド)を集計する
* `stack-logons`: ユーザー名、コンピューター名、送信元IPアドレス、送信元コンピューター名など、項目ごとの上位ログオンを出力する
* `stack-processes`: 実行されたプロセスを集計する
* `stack-services`: 作成されたサービス名とプロセスを集計する
* `stack-tasks`: 作成されたスケジュールタスクを集計する
* `stack-users`: ターゲットユーザー(`TgtUser`フィールド) またはソースユーザー (`SrcUser`フィールド)を集計する

## Sysmonコマンド
* `sysmon-process-tree`: プロセスツリーを出力する

## Timelineコマンド
* `timeline-logon`: ログオンイベントのCSVタイムラインを作成する
* `timeline-suspicious-processes`: 不審なプロセスのCSVタイムラインを作成する
* `timeline-partition-diagnostic`: partition diagnosticイベントのCSVタイムラインを作成する
* `timeline-tasks`: スケジュールタスクのCSVタイムラインを作成する

## TTP Commands
* `ttp-summary`: コンピュータ毎に検知されたTTPsの要約を出力する
* `ttp-visualize`: TTPs を抽出し、MITRE ATT&CK Navigator で視覚化するためのJSONファイルを作成する
* `ttp-visualize-sigma`: TTPs をSigmaルールから抽出し、MITRE ATT&CK Navigator で視覚化するためのJSONファイルを作成する

## VirusTotalコマンド
* `vt-domain-lookup`: VirusTotalでドメインのリストを検索し、悪意のあるドメインをレポートする
* `vt-hash-lookup`: VirusTotalでハッシュのリストを検索し、悪意のあるハッシュ値をレポートする
* `vt-ip-lookup`: VirusTotalでIPアドレスのリストを検索し、悪意のあるIPアドレスをレポートする

<div align="center">
 <p>
     <img alt="Takajo Logō" src="logo.png" width="50%">
 </p>
 [ <a href="README.md"><b>English</b></a> ] | [ 日本語 ]
</div>

---

[tag-1]: https://img.shields.io/github/downloads/Yamato-Secuirty/takajo/total?label=GitHub%F0%9F%8E%AFDownloads&style=plastic
[tag-2]: https://img.shields.io/github/stars/Yamato-Security/takajo?style=plastic&label=GitHub%F0%9F%8E%AFStars
[tag-3]: https://img.shields.io/github/v/release/Yamato-Security/takajo?display_name=tag&label=latest-version&style=plastic
[tag-4]: https://img.shields.io/badge/Maintenance%20Level-Actively%20Developed-brightgreen.svg
[tag-5]: https://img.shields.io/badge/Twitter-00acee?logo=twitter&logoColor=white

![tag-1] ![tag-2] <a href="https://github.com/Yamato-Security/hayabusa/releases">![tag-3]</a> ![tag-4]</a> ![tag-5]  <a href="https://twitter.com/SecurityYamato"></a>

## Takajoについて

Takajō (鷹匠)は 日本の[Yamato Security](https://yamatosecurity.connpass.com/)グループによって作られた [Hayabusa](https://github.com/Yamato-Security/hayabusa)から得られた結果を解析するツールです。Takajōは[Nim](https://nim-lang.org/)で作られました。  
Takajōは、日本語で["鷹狩りのスキルに優れた人"](https://en.wikipedia.org/wiki/Falconry)を意味し、ハヤブサが得た`結果をさらに活かすことから選ばれました。

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
  - [作成予定機能](#作成予定機能)
  - [Gitクローン](#gitクローン)
  - [アドバンス: ソースコードからのコンパイル(任意)](#アドバンス-ソースコードからのコンパイル任意)
    - [使用方法](#使用方法)
  - [貢献](#貢献)
  - [バグの報告](#バグの報告)
  - [ライセンス](#ライセンス)
  - [Twitter](#twitter)

## 機能

- メモリセーフかつ、プログラムしやすいNimで作成することで、C言語と同じくらい早く、バイナリのクロスコンパイルが可能
- `undetected-evtx`: Hayabusaのcsvの結果を比較して検知していない`.evtx`ファイルを一覧化
- `unused-rules`: Hayabusaのcsvの結果(例: output.csv)を比較して検知していない`yml`ルールを一覧化

## 作成予定機能

- 行動分析機能
- 不審なプロセスツリーの表示機能

## Gitクローン

以下のgit cloneコマンドでレポジトリをダウンロードし、ソースコードからコンパイルして使用することも可能です：

>> 注意： mainブランチは開発中のバージョンです。まだ正式にリリースされていない新機能が使えるかもしれないが、バグがある可能性もあるので、テスト版だと思って下さい。

`git clone https://github.com/Yamato-Security/takajo.git`

## アドバンス: ソースコードからのコンパイル(任意)

Nimがインストールされている場合、以下のコマンドでソースコードからコンパイルすることができます。

```bash
> nimble update
> nimble build -d:release
```

コンパイルされたバイナリはtakajoフォルダ配下で作成されます。

### 使用方法

1. `help`: 各コマンドのヘルプメニューを表示する。
2. `undetected-evtxes`: Hayabusaのルールで検知しなかったevtxファイルを一覧化する。  
Hayabusa実行時に`%EvtxFile%`の情報が含まれたプロファイルを使ってcsvを出力して下さい。プロファイルごとにHayabusaのcsvに出力される情報は異なります。詳細は[こちら](https://github.com/Yamato-Security/hayabusa#profiles)を確認して下さい。

必須オプション:

- `-t, --timeline ../hayabusa/timeline.csv`: Hayabusaで作成されたCSVタイムライン。
- `-e --evtx-dir ../hayabusa-sample-evtx`: Hayabusaでスキャンした`.evtx`ファイルが存在するディレクトリ。

任意オプション:

- `-c, --column-name EvtxColumn`: カスタムなカラム名を指定する。デフォルトではHayabusaのデフォルトの`EvtxFile`が使用される。
- `-o, --output result.txt`: 結果をテキストファイルに保存する。デフォルトは画面出力になる。
- `-q, --quiet`: ロゴを表示しない。

例:

```bash
takajo.exe undetected-evtx -t ../hayabusa/timeline.csv -e ../hayabusa-sample-evtx
```

1. `unused-rules`: Hayabusaのスキャンで1件も検知しなかった`.yml`ファイルを一覧化する。  
Hayabusa実行時に`%RuleFile%`の情報が含まれたプロファイルを使ってcsvを出力して下さい。プロファイルごとにHayabusaのcsvに出力される情報は異なります。プロファイルごとにHayabusaのcsvに出力される情報は異なります。詳細は[こちら](https://github.com/Yamato-Security/hayabusa#profiles)を確認して下さい。

必須オプション:

- -t, --timeline timeline.csv: Hayabusaで作成されたCSVタイムライン。
- -r --rules-dir ../hayabusa/rules: Hayabusaでスキャンした`.yml`ファイルが存在するディレクトリ。

任意オプション:

- `-c, --column-name CustomRuleFileColumn`: カスタムなカラム名を指定する。デフォルトではHayabusaのデフォルトの`RuleFile`が使用される。
- `-o, --output result.txt`: 結果をテキストファイルに保存する。デフォルトは画面出力になる。
- `-q, --quiet`: ロゴを表示しない。

例:

```bash
takajo.exe unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

## 貢献

どのような形でも構いませんので、ご協力をお願いします。プルリクエスト、ルール作成、evtxログのサンプルなどがベストですが、機能リクエスト、バグの通知なども大歓迎です。

少なくとも、私たちのツールを気に入っていただけたなら、Githubで星を付けて、あなたのサポートを表明してください。

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

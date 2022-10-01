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
Takajōは、日本語で["鷹狩りのスキルに優れた人"](https://en.wikipedia.org/wiki/Falconry)を意味し、ハヤブサが得た獲物を有効活用することから選ばれました。  

## もくじ

- [Takajoについて](#takajoについて)
- [もくじ](#もくじ)
- [機能](#機能)
- [Gitクローン](#gitクローン)
- [アドバンス: ソースコードからのコンパイル(任意)](#アドバンス-ソースコードからのコンパイル任意)
  - [使用方法](#使用方法)
- [貢献](#貢献)
- [バグの報告](#バグの報告)
- [ライセンス](#ライセンス)
- [Twitter](#twitter)

## 機能

- 検査対象としたフォルダとHayabusaのcsvの結果を比較して検知していないルールファイル名を一覧化
- 検査対象としたフォルダとHayabusaのcsvの結果(例: output.csv)を比較して検知していないWindowsイベントログを一覧化

## Gitクローン

以下のgit cloneコマンドでレポジトリをダウンロードし、ソースコードからコンパイルして使用することも可能です：

注意： mainブランチは開発中のバージョンです。まだ正式にリリースされていない新機能が使えるかもしれないが、バグがある可能性もあるので、テスト版だと思って下さい。

```bash
git clone https://github.com/Yamato-Security/takajo.git
```

## アドバンス: ソースコードからのコンパイル(任意)

Nimがインストールされている場合、以下のコマンドでソースコードからコンパイルすることができます。

```bash
> nimble update
> nimble build
```

コンパイルされたバイナリはtakajoフォルダ配下で作成されます。

### 使用方法

- 検査対象としたフォルダとHayabusaのcsvの結果(例: output.csv)を比較して検知していないWindowsイベントログを一覧化するコマンド。`-t` オプションはoutput.csv内の比較したい列の名前を入力してください。  

```bash
takajo.exe evtx output.csv -c .\\hayabusa-sample-evtx -t EvtxFile
```

- 検査対象としたフォルダとHayabusaのcsvの結果(例: output.csv)を比較して検知していないルールファイル名を一覧化するコマンド。

```bash
takajo.exe yml output.csv -c .\\hayabusa\\rules -t RuleFile
```

## 貢献

どのような形でも構いませんので、ご協力をお願いします。プルリクエスト、ルール作成、evtxログのサンプルなどがベストですが、機能リクエスト、バグの通知なども大歓迎です。

少なくとも、私たちのツールを気に入っていただけたなら、Githubで星を付けて、あなたのサポートを表明してください。

## バグの報告

このプロジェクトは活発なメンテナンスを行っています。
見つけたバグを[こちら](https://github.com/Yamato-Security/takajo/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D)でご連絡ください。報告されたバグを喜んで修正します！

もし、Hayabusaルールで何かしらの問題(フォルスポジティブ、 バグ、その他)を見つけましたら、[こちら](https://github.com/Yamato-Security/hayabusa-rules/issues/new) でご連絡ください。

もし、Sigmaルールで何かしらの問題(フォルスポジティブ、 バグ、その他)を見つけましたら、SigmaHQの[こちら](https://github.com/SigmaHQ/sigma/issues) でご連絡ください。

## ライセンス

Takajōは[GPLv3ライセンス](https://www.gnu.org/licenses/gpl-3.0.en.html)で公開されています。

## Twitter

[@SecurityYamato](https://twitter.com/SecurityYamato)でHayabusa、ルール更新、その他の大和セキュリティツール等々について情報を提供しています。
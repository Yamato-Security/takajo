# アドバンス: ソースコードからのコンパイル（任意）

まず、[choosenim](https://github.com/nim-lang/choosenim)でNimをインストールして下さい。
また、コンパイル時にDuckDBのCライブラリが必要なため、DuckDBもインストールしてください（[必要条件](index.md#必要条件)を参照）。
その後、以下のコマンドでソースコードからコンパイルできます:

```
> nimble update
> nimble build -d:release --threads:on
```

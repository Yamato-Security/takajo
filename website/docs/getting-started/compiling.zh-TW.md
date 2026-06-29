# 進階：從原始碼編譯（選用）

首先，請使用 [choosenim](https://github.com/nim-lang/choosenim) 安裝 Nim。
您也需要安裝 DuckDB（請參閱[系統需求](index.md#requirements)），因為編譯時需要 DuckDB C 函式庫。
接著您可以使用以下指令從原始碼進行編譯：

```
> nimble update
> nimble build -d:release --threads:on
```

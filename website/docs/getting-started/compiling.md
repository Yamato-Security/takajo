# Advanced: Compiling From Source (Optional)

First, install Nim with [choosenim](https://github.com/nim-lang/choosenim).
You also need to install DuckDB (see [Requirements](index.md#requirements)) since the DuckDB C library is required at compile time.
Then you can compile from source with the following command:

```
> nimble update
> nimble build -d:release --threads:on
```

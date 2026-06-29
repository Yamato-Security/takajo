# Gelişmiş: Kaynaktan Derleme (İsteğe Bağlı)

Önce, [choosenim](https://github.com/nim-lang/choosenim) ile Nim'i kurun.
Derleme sırasında DuckDB C kütüphanesi gerekli olduğundan, ayrıca DuckDB'yi de kurmanız gerekir (bkz. [Gereksinimler](index.md#requirements)).
Ardından aşağıdaki komutla kaynaktan derleyebilirsiniz:

```
> nimble update
> nimble build -d:release --threads:on
```

# Lanjutan: Mengompilasi Dari Sumber (Opsional)

Pertama, instal Nim dengan [choosenim](https://github.com/nim-lang/choosenim).
Anda juga perlu menginstal DuckDB (lihat [Requirements](index.md#requirements)) karena pustaka C DuckDB diperlukan pada saat kompilasi.
Kemudian Anda dapat mengompilasi dari sumber dengan perintah berikut:

```
> nimble update
> nimble build -d:release --threads:on
```

# Fortgeschritten: Kompilieren aus dem Quellcode (Optional)

Installieren Sie zunächst Nim mit [choosenim](https://github.com/nim-lang/choosenim).
Außerdem müssen Sie DuckDB installieren (siehe [Anforderungen](index.md#requirements)), da die DuckDB-C-Bibliothek zur Kompilierzeit benötigt wird.
Anschließend können Sie mit dem folgenden Befehl aus dem Quellcode kompilieren:

```
> nimble update
> nimble build -d:release --threads:on
```

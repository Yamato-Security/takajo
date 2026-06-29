# Avançado: Compilando a Partir do Código-Fonte (Opcional)

Primeiro, instale o Nim com o [choosenim](https://github.com/nim-lang/choosenim).
Você também precisa instalar o DuckDB (consulte [Requisitos](index.md#requirements)), pois a biblioteca C do DuckDB é necessária no momento da compilação.
Em seguida, você pode compilar a partir do código-fonte com o seguinte comando:

```
> nimble update
> nimble build -d:release --threads:on
```

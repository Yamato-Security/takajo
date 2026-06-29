# Avanzado: Compilar desde el código fuente (opcional)

Primero, instale Nim con [choosenim](https://github.com/nim-lang/choosenim).
También necesita instalar DuckDB (consulte [Requisitos](index.md#requirements)) ya que la biblioteca C de DuckDB es necesaria en tiempo de compilación.
Luego puede compilar desde el código fuente con el siguiente comando:

```
> nimble update
> nimble build -d:release --threads:on
```

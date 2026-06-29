# Avancé : Compilation depuis les sources (facultatif)

Tout d'abord, installez Nim avec [choosenim](https://github.com/nim-lang/choosenim).
Vous devez également installer DuckDB (voir [Requirements](index.md#requirements)) car la bibliothèque C de DuckDB est requise au moment de la compilation.
Vous pouvez ensuite compiler depuis les sources avec la commande suivante :

```
> nimble update
> nimble build -d:release --threads:on
```

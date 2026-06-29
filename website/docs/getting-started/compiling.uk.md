# Додатково: компіляція з вихідного коду (опціонально)

Спершу встановіть Nim за допомогою [choosenim](https://github.com/nim-lang/choosenim).
Вам також потрібно встановити DuckDB (див. [Вимоги](index.md#requirements)), оскільки бібліотека DuckDB C потрібна під час компіляції.
Потім ви можете скомпілювати з вихідного коду за допомогою наступної команди:

```
> nimble update
> nimble build -d:release --threads:on
```

# متقدم: التجميع من المصدر (اختياري)

أولاً، قم بتثبيت Nim باستخدام [choosenim](https://github.com/nim-lang/choosenim).
تحتاج أيضاً إلى تثبيت DuckDB (راجع [المتطلبات](index.md#requirements)) لأن مكتبة DuckDB بلغة C مطلوبة في وقت التجميع.
بعد ذلك يمكنك التجميع من المصدر باستخدام الأمر التالي:

```
> nimble update
> nimble build -d:release --threads:on
```

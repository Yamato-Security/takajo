# उन्नत: स्रोत से कंपाइल करना (वैकल्पिक)

सबसे पहले, [choosenim](https://github.com/nim-lang/choosenim) के साथ Nim इंस्टॉल करें।
आपको DuckDB भी इंस्टॉल करना होगा (देखें [Requirements](index.md#requirements)) क्योंकि कंपाइल समय पर DuckDB C लाइब्रेरी की आवश्यकता होती है।
इसके बाद आप निम्नलिखित कमांड के साथ स्रोत से कंपाइल कर सकते हैं:

```
> nimble update
> nimble build -d:release --threads:on
```

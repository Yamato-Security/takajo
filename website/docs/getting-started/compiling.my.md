# အဆင့်မြင့်: Source မှ Compile လုပ်ခြင်း (ရွေးချယ်နိုင်)

ပထမဦးစွာ Nim ကို [choosenim](https://github.com/nim-lang/choosenim) ဖြင့် install လုပ်ပါ။
DuckDB C library သည် compile လုပ်ချိန်တွင် လိုအပ်သောကြောင့် DuckDB ကိုလည်း install လုပ်ရန်လိုအပ်ပါသည် ([Requirements](index.md#requirements) ကိုကြည့်ပါ)။
ထို့နောက် အောက်ပါ command ဖြင့် source မှ compile လုပ်နိုင်ပါသည်:

```
> nimble update
> nimble build -d:release --threads:on
```

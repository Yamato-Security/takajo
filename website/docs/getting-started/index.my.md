# ဒေါင်းလုဒ်များ

ကျေးဇူးပြု၍ Takajo ၏ နောက်ဆုံးထွက် တည်ငြိမ်သော ဗားရှင်းကို compiled binaries ဖြင့် ဒေါင်းလုဒ်လုပ်ပါ သို့မဟုတ် [Releases](https://github.com/Yamato-Security/takajo/releases) စာမျက်နှာမှ source code ကို compile လုပ်ပါ။

> မှတ်ချက်: ကျွန်ုပ်တို့သည် 64-bit Windows နှင့် Intel နှင့် Arm-based macOS အတွက် release binaries များ ပံ့ပိုးပေးသော်လည်း Linux အတွက် MUSL binaries များ ပံ့ပိုးပေးရန် လောလောဆယ် ခက်ခဲသောကြောင့် Linux အတွက် မပံ့ပိုးပေးပါ။

## လိုအပ်ချက်များ

`html-report` နှင့် `html-server` commands များသည် မြန်ဆန်သော ခွဲခြမ်းစိတ်ဖြာသည့် queries များအတွက် မူရင်း database backend အဖြစ် [DuckDB](https://duckdb.org/) ကို အသုံးပြုသည်။
ဤ commands များကို မအသုံးပြုမီ DuckDB ကို install လုပ်ထားရန် လိုအပ်သည်။
အကယ်၍ DuckDB ကို install မလုပ်လိုပါက ၎င်းအစား SQLite ကို အသုံးပြုရန် `--sqlite` flag ကို သုံးနိုင်သည်။

### macOS (Homebrew)

```
brew install duckdb
```

### Windows (winget)

```
winget install DuckDB.cli
```

### Linux

```
wget -q https://github.com/duckdb/duckdb/releases/download/v1.4.4/libduckdb-linux-amd64.zip
unzip -o libduckdb-linux-amd64.zip -d duckdb_lib
sudo cp duckdb_lib/duckdb.h /usr/local/include/
sudo cp duckdb_lib/libduckdb.so /usr/local/lib/
sudo ldconfig
```

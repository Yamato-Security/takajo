# Automation Commands

## `automagic` command

ဖြစ်နိုင်သမျှ command များကို အလိုအလျောက် လုပ်ဆောင်ပြီး ရလဒ်များကို folder အသစ်တစ်ခုသို့ ထုတ်ပေးသည်

> Note: command အားလုံးကို အသုံးပြုနိုင်ရန် `verbose` သို့မဟုတ် `super-verbose` profile ကို သုံးသင့်သည်။

* Input: JSONL file သို့မဟုတ် JSONL file များ၏ directory
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: ရလဒ်အားလုံးကို ဖိုင်အမျိုးမျိုးတွင် ပါဝင်သော folder အသစ်တစ်ခု

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် directory။

Options များ:

- `-d, --displayTable`: ရလဒ်ဇယားကို ပြသသည် (default: `false`)
- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်သည် (default: `low`)
- `-o, --output`: output directory (default: `case-1`)
- `-q, --quiet`: launch banner ကို မပြသပါ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသပါ (default: `false`)

### `automagic` command examples

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

ဖြစ်နိုင်သမျှ Takajo command များကို လုပ်ဆောင်ပြီး ရလဒ်များကို `case-1` folder အောက်တွင် သိမ်းဆည်းပါ:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

`hayabusa-results` directory ပေါ်တွင် ဖြစ်နိုင်သမျှ Takajo command များကို လုပ်ဆောင်ပြီး ရလဒ်များကို `case-1` folder အောက်တွင် သိမ်းဆည်းပါ:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

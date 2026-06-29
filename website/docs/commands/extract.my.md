# ထုတ်ယူခြင်း Commands

## `extract-scriptblocks` command

PowerShell EID 4104 script block logs များကို ထုတ်ယူပြီး ပြန်လည်တွဲဆက်ပေးသည်။

> မှတ်ချက်: PowerShell scripts များကို code syntax highlighting ဖြင့် `.ps1` ဖိုင်များအဖြစ် ဖွင့်ခြင်းသည် အကောင်းဆုံးဖြစ်သော်လည်း မလိုလားအပ်သော malicious code မတော်တဆ run သွားခြင်းကို ကာကွယ်ရန်အတွက် `.txt` extension ကို အသုံးပြုထားသည်။

* Input: JSONL
* Profile: Any
* Output: Terminal နှင့် PowerShell Scripts directory

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline ဖိုင် သို့မဟုတ် directory

Options:

 - `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `low`)
 - `-o, --output`: output directory (default: `scriptblock-logs`)
 - `-q, --quiet`: launch banner ကို မပြရန် (default: `false`)
 - `-s, --skipProgressBar`: progress bar ကို မပြရန် (default: `false`)

### `extract-scriptblocks` command ဥပမာ

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

PowerShell EID 4104 script block logs များကို `scriptblock-logs` directory သို့ ထုတ်ယူပါ:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### `extract-scriptblocks` screenshot

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

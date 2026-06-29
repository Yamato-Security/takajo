# Split Commands

## `split-csv-timeline` command

ကွန်ပျူတာအမည်ကို အခြေခံပြီး CSV timeline အကြီးကို သေးငယ်သော CSV timeline များအဖြစ် ခွဲထုတ်ပါ။

* Input: Non-multiline CSV
* Profile: Any
* Output: Multiple CSV files

လိုအပ်သော options များ:

- `-t, --timeline <CSV-FILE>`: Hayabusa မှ ဖန်တီးထားသော CSV timeline ။

Options များ:

- `-m, --makeMultiline`: fields များကို စာကြောင်းများစွာဖြင့် ထုတ်ပါ။ (default: `false`)
- `-o, --output <DIR>`: CSV ဖိုင်များ သိမ်းဆည်းရန် directory ။ (default: `output`)
- `-q, --quiet`: လိုဂိုကို မပြပါနှင့်။ (default: `false`)

### `split-csv-timeline` command examples

Hayabusa ဖြင့် CSV timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

CSV timeline တစ်ခုတည်းကို default `output` directory ထဲတွင် CSV timeline များစွာအဖြစ် ခွဲထုတ်ပါ:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

field အချက်အလက်များကို newline အက္ခရာများဖြင့် ပိုင်းခြားကာ စာကြောင်းများစွာပါသော entry များ ပြုလုပ်ပြီး `case-1-csv` directory တွင် သိမ်းဆည်းပါ:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline` command

ကွန်ပျူတာအမည်ကို အခြေခံပြီး JSONL timeline အကြီးကို သေးငယ်သော JSONL timeline များအဖြစ် ခွဲထုတ်ပါ။

* Input: JSONL
* Profile: Any
* Output: Multiple JSONL files

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline ဖိုင် သို့မဟုတ် directory ။

Options များ:

- `-o, --output <DIR>`: JSONL ဖိုင်များ သိမ်းဆည်းရန် directory ။ (default: `output`)
- `-q, --quiet`: လိုဂိုကို မပြပါနှင့်။ (default: `false`)

### `split-json-timeline` command examples

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

JSONL timeline တစ်ခုတည်းကို default `output` directory ထဲတွင် JSONL timeline များစွာအဖြစ် ခွဲထုတ်ပါ:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

`case-1-jsonl` directory တွင် သိမ်းဆည်းပါ:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

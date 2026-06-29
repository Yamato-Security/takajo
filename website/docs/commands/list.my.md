# List Commands

## `list-domains` command

`vt-domain-lookup` နှင့်အတူ အသုံးပြုရန် ထူးခြားသော ဒိုမိန်းများ၏ စာရင်းကို ဖန်တီးပေးသည်။
လက်ရှိတွင် ၎င်းသည် Sysmon EID 22 logs ထဲရှိ မေးမြန်းထားသော ဒိုမိန်းများကိုသာ စစ်ဆေးမည်ဖြစ်သော်လည်း built-in Windows DNS Client နှင့် Server logs ကို ပံ့ပိုးရန် အပ်ဒိတ်လုပ်သွားမည်ဖြစ်သည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: Text file

လိုအပ်သော options များ:

 - `-o, --output <TXT-FILE>`: ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းသည်။
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် directory။

Options များ:

 - `-s, --includeSubdomains`: subdomains များ ထည့်သွင်းသည် (default: `false`)
 - `-w, --includeWorkstations`: ဒေသတွင်း workstation အမည်များ ထည့်သွင်းသည် (default: `false`)
 - `-q, --quiet`: logo ကို မပြသပါ (default: `false`)
 - `-s, --skipProgressBar`: progress bar ကို မပြသပါ (default: `false`)

### `list-domains` command examples

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းပါ:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

subdomains များ ထည့်သွင်းပါ:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes` command

vt-hash-lookup နှင့်အတူ အသုံးပြုရန် process hashes များ၏ စာရင်းကို ဖန်တီးပါ (input: JSONL, profile: standard)

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: Text file

လိုအပ်သော options များ:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL files များ၏ directory
 - `-o, --output <BASE-NAME>`: text ရလဒ်များ သိမ်းဆည်းရန် base name ကို သတ်မှတ်ပါ။

Options များ:

 - `-l, --level`: အနိမ့်ဆုံး level ကို သတ်မှတ်ပါ။ (default: `high`)
 - `-q, --quiet`: logo ကို မပြသပါ။ (default: `false`)
 - `-s, --skipProgressBar`: progress bar ကို မပြသပါ (default: `false`)

### `list-hashes` command examples

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

hash အမျိုးအစားတစ်ခုစီအတွက် မတူညီသော text file တစ်ခုစီသို့ ရလဒ်များကို သိမ်းဆည်းပါ:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

ဥပမာအားဖြင့်၊ `MD5`, `SHA1` နှင့် `IMPHASH` hashes များကို sysmon logs ထဲတွင် သိမ်းဆည်းထားပါက အောက်ပါ files များကို ဖန်တီးမည်ဖြစ်သည်: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses` command

`vt-ip-lookup` နှင့်အတူ အသုံးပြုရန် ထူးခြားသော target နှင့်/သို့မဟုတ် source IP addresses များ၏ စာရင်းကို ဖန်တီးပေးသည်။
၎င်းသည် ရလဒ်အားလုံးထဲတွင် target IP addresses များအတွက် `TgtIP` fields များနှင့် source IP addresses များအတွက် `SrcIP` fields များကို ထုတ်ယူပြီး ထူးခြားသော IP addresses များကိုသာ text file တစ်ခုသို့ output ထုတ်ပေးမည်ဖြစ်သည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: Text file

လိုအပ်သော options များ:

 - `-o, --output <TXT-FILE>`: ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းသည်။
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် directory။

Options များ:

 - `-i, --inbound`: inbound traffic ထည့်သွင်းသည်။ (default: `true`)
 - `-O, --outbound`: outbound traffic ထည့်သွင်းသည်။ (default: `true`)
 - `-p, --privateIp`: private IP addresses များ ထည့်သွင်းသည် (default: `false`)
 - `-q, --quiet`: logo ကို မပြသပါ။ (default: `false`)
 - `-s, --skipProgressBar`: "progress bar ကို မပြသပါ (default: `false`)

### `list-ip-addresses` command examples

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းပါ:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

inbound traffic ကို ဖယ်ထုတ်ပါ:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

private IP addresses များ ထည့်သွင်းပါ:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx` command

Hayabusa တွင် detection rule မရှိခဲ့သော `.evtx` files အားလုံးကို စာရင်းပြုစုပေးသည်။
ဤအရာသည် [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) repository ထဲရှိ sample evtx files များကဲ့သို့ အန္တရာယ်ရှိသော လုပ်ဆောင်ချက်၏ သက်သေအထောက်အထားအားလုံး ပါဝင်သည့် sample evtx files များတွင် အသုံးပြုရန် ရည်ရွယ်ထားသည်။

* Input: CSV
* Profile: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > သင်သည် ဦးစွာ `%EvtxFile%` column အချက်အလက်ကို သိမ်းဆည်းသည့် profile တစ်ခုဖြင့် Hayabusa ကို run ပြီး ရလဒ်များကို CSV timeline တစ်ခုသို့ သိမ်းဆည်းရန် လိုအပ်သည်။
  > မတူညီသော profiles များအလိုက် Hayabusa မည်သည့် columns များကို သိမ်းဆည်းသည်ကို [ဤနေရာတွင်](https://github.com/Yamato-Security/hayabusa#profiles) ကြည့်ရှုနိုင်သည်။
* Output: Terminal သို့မဟုတ် text file

လိုအပ်သော options များ:

- `-e, --evtx-dir <EVTX-DIR>`: သင် Hayabusa ဖြင့် scan လုပ်ခဲ့သော `.evtx` files များ၏ directory။
- `-t, --timeline <CSV-FILE>`: Hayabusa CSV timeline။

Options များ:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: evtx column အတွက် စိတ်ကြိုက် column name တစ်ခုကို သတ်မှတ်ပါ။ (default: Hayabusa ၏ default ဖြစ်သော `EvtxFile`)
- `-o, --output <TXT-FILE>`: ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းပါ။ (default: မျက်နှာပြင်သို့ output ထုတ်သည်)
- `-q, --quiet`: logo ကို မပြသပါ။ (default: `false`)

### `list-undetected-evtx` command examples

Hayabusa ဖြင့် CSV timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

ရလဒ်များကို မျက်နှာပြင်သို့ output ထုတ်ပါ:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းပါ:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules` command

မည်သည့်အရာကိုမျှ မ detect ခဲ့သော `.yml` detection rules အားလုံးကို စာရင်းပြုစုပေးသည်။
ဤအရာသည် rules များ၏ ယုံကြည်စိတ်ချရမှုကို ဆုံးဖြတ်ရာတွင် အထောက်အကူဖြစ်စေသည်။
ဆိုလိုသည်မှာ မည်သည့် rules များသည် အန္တရာယ်ရှိသော လုပ်ဆောင်ချက်ကို ရှာဖွေတွေ့ရှိကြောင်း သိရှိထားပြီး မည်သည့်အရာများသည် စမ်းသပ်ခြင်းမပြုရသေးဘဲ sample `.evtx` files များ လိုအပ်နေသည်ကို ဆိုလိုသည်။

* Input: CSV
* Profile: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > သင်သည် ဦးစွာ `%RuleFile%` column အချက်အလက်ကို သိမ်းဆည်းသည့် profile တစ်ခုဖြင့် Hayabusa ကို run ပြီး ရလဒ်များကို CSV timeline တစ်ခုသို့ သိမ်းဆည်းရန် လိုအပ်သည်။
  > မတူညီသော profiles များအလိုက် Hayabusa မည်သည့် columns များကို သိမ်းဆည်းသည်ကို [ဤနေရာတွင်](https://github.com/Yamato-Security/hayabusa#profiles) ကြည့်ရှုနိုင်သည်။
* Output: Termianl သို့မဟုတ် text file

လိုအပ်သော options များ:

- `-r, --rules-dir <DIR>`: သင် Hayabusa ဖြင့် အသုံးပြုခဲ့သော `.yml` rules files များ၏ directory။
- `-t, --timeline <CSV-FILE>`: Hayabusa မှ ဖန်တီးထားသော CSV timeline။

Options များ:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: rule file column အတွက် စိတ်ကြိုက် column name တစ်ခုကို သတ်မှတ်ပါ။ (default: Hayabusa ၏ default ဖြစ်သော `RuleFile`)
- `-o, --output <TXT-FILE>`: ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းပါ။ (default: မျက်နှာပြင်သို့ output ထုတ်သည်)
- `-q, --quiet`: logo ကို မပြသပါ။ (default: `false`)

### `list-unused-rules` command examples

Hayabusa ဖြင့် CSV timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

ရလဒ်များကို မျက်နှာပြင်သို့ output ထုတ်ပါ:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

ရလဒ်များကို text file တစ်ခုသို့ သိမ်းဆည်းပါ:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

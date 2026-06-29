# Stack Commands

## `stack-cmdlines` command

ဤ command သည် `Sysmon 1` နှင့် `Security 4688` events များမှ အချက်အလက်များကို ထုတ်ယူခြင်းဖြင့် အကောင်အထည်ဖော် run ခဲ့သော command line များကို စုပုံ (stack) ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-y, --ignoreSysmon`: Sysmon 1 events များကို ဖယ်ထုတ်ရန် (default: `false`)
- `-e, --ignoreSecurity`: Security 4688 events များကို ဖယ်ထုတ်ရန် (default: `false`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-cmdlines` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers` command

ဤ command သည် `Computer` field အလိုက် computer hostname များကို စုပုံ (stack) ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-c, --sourceComputers`: target computer များအစား source computer များကို စုပုံရန် (default: false)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-computers` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns` command

ဤ command သည် Sysmon 22 events များမှ DNS query များနှင့် response များကို စုပုံ (stack) ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-dns` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses` command

ဤ command သည် target IP address များ (`TgtIP` field) သို့မဟုတ် source IP address များ (`SrcIP` field) ကို စုပုံ (stack) ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-a, --targetIpAddresses`: source IP address များအစား target IP address များကို စုပုံရန် (default: `false`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-ip-addresses` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons` command

`Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer` အလိုက် logon စာရင်းတစ်ခုကို ဖန်တီးပေးပါသည်။
default အားဖြင့် source IP address သည် local IP address ဖြစ်နေသည့်အခါ ရလဒ်များကို စစ်ထုတ်ဖယ်ရှားပါသည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --localSrcIpAddresses`: source IP address သည် local ဖြစ်သည့်အခါ ရလဒ်များကို ထည့်သွင်းရန်။
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-logons` command examples

default settings ဖြင့် run ရန်:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

local logon များ ထည့်သွင်းရန်:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes` command

ဤ command သည် Sysmon 1 နှင့် Security 4688 events များမှ အကောင်အထည်ဖော် run ခဲ့သော process များကို စုပုံ (stack) ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `low`)
- `-y, --ignoreSysmon`: Sysmon 1 events များကို ဖယ်ထုတ်ရန် (default: `false`)
- `-e, --ignoreSecurity`: Security 4688 events များကို ဖယ်ထုတ်ရန် (default: `false`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-processes` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services` command

ဤ command သည် System 7040 နှင့် Security 4697 events များမှ service name များနှင့် path များကို စုပုံ (stack) ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-y, --ignoreSystem`: System 7040 events များကို ဖယ်ထုတ်ရန် (default: `false`)
- `-e, --ignoreSecurity`: Security 4697 events များကို ဖယ်ထုတ်ရန် (default: `false`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-services` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks` command

ဤ command သည် Security 4698 events များမှ scheduled task အသစ်များကို စုပုံ (stack) ပေးပြီး XML task content ကို parse လုပ်ထုတ်ပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-tasks` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users` command

ဤ command သည် ထို field များ ပါဝင်သော မည်သည့် event တွင်မဆို target user များ (`TgtUser` field (default)) သို့မဟုတ် source user များ (`SrcUser` field) ကို စုပုံ (stack) ပေးမည့်အပြင် alert အချက်အလက်ကိုပါ ပြသပေးပါမည်။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် CSV file

လိုအပ်သော options များ:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline file သို့မဟုတ် JSONL file များ၏ directory

Options:

- `-s, --sourceUsers`: target user များအစား source user များကို စုပုံရန် (default: false)
- `-c, --filterComputerAccounts`: computer account များကို စစ်ထုတ်ဖယ်ရှားရန် (default: true)
- `-f, --filterSystemAccounts`: system account များကို စစ်ထုတ်ဖယ်ရှားရန် (default: true)
- `-l, --level`: အနိမ့်ဆုံး alert level ကို သတ်မှတ်ရန် (default: `informational`)
- `-o, --output <CSV-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် CSV file (default: `stdout`)
- `-q, --quiet`: logo ကို မပြသရန်။ (default: `false`)
- `-s, --skipProgressBar`: progress bar ကို မပြသရန် (default: `false`)

### `stack-users` command examples

Terminal သို့ output ထုတ်ရန်:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

CSV သို့ သိမ်းရန်:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

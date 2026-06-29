# VirusTotal Commands

## `vt-domain-lookup` command

VirusTotal တွင် ဒိုမိန်းစာရင်းကို ရှာဖွေပါ

* Input: Text file
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: CSV

လိုအပ်သော options များ -

- `-a, --apiKey <API-KEY>`: သင်၏ VirusTotal API key။
- `-d, --domainList <TXT-FILE>`: ဒိုမိန်းများ၏ စာသားဖိုင်စာရင်း။
- `-o, --output <CSV-FILE>`: ရလဒ်များကို CSV ဖိုင်တစ်ခုသို့ သိမ်းဆည်းပါ။

Options များ -

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal မှ JSON တုံ့ပြန်မှုအားလုံးကို JSON ဖိုင်တစ်ခုသို့ ထုတ်ပါ။
- `-r, --rateLimit <NUMBER>`: တောင်းဆိုမှုများ ပေးပို့ရန် တစ်မိနစ်လျှင် rate။ (default: `4`)
- `-q, --quiet`: လိုဂိုကို မပြသပါ။ (default: `false`)

### `vt-domain-lookup` command examples

ပထမဦးစွာ `list-domains` command ဖြင့် ဒိုမိန်းစာရင်းတစ်ခုကို ဖန်တီးပါ။
ထို့နောက် အောက်ပါအတိုင်း ထိုဒိုမိန်းများကို ရှာဖွေပါ -

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup` command

VirusTotal တွင် hash စာရင်းကို ရှာဖွေပါ။

* Input: Text file
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: CSV

လိုအပ်သော options များ -

- `-a, --apiKey <API-KEY>`: သင်၏ VirusTotal API key။
- `-H, --hashList <HASH-LIST>`: hash များ၏ စာသားဖိုင်တစ်ခု။
- `-o, --output <CSV-FILE>`: ရလဒ်များကို CSV ဖိုင်တစ်ခုသို့ သိမ်းဆည်းပါ။

Options များ -

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal မှ JSON တုံ့ပြန်မှုအားလုံးကို JSON ဖိုင်တစ်ခုသို့ ထုတ်ပါ။
- `-r, --rateLimit <NUMBER>`: တောင်းဆိုမှုများ ပေးပို့ရန် တစ်မိနစ်လျှင် rate။ (default: `4`)
- `-q, --quiet`: လိုဂိုကို မပြသပါ။ (default: `false`)

### `vt-hash-lookup` command examples

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup` command

VirusTotal တွင် IP လိပ်စာစာရင်းကို ရှာဖွေပါ။

* Input: Text file
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့်အရာမဆို
* Output: CSV

လိုအပ်သော options များ -

- `-a, --apiKey <API-KEY>`: သင်၏ VirusTotal API key။
- `-i, --ipList <IP-ADDRESS-LIST>`: IP လိပ်စာများ၏ စာသားဖိုင်တစ်ခု။
- `-o, --output <CSV-FILE>`: ရလဒ်များကို CSV ဖိုင်တစ်ခုသို့ သိမ်းဆည်းပါ။

Options များ -

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal မှ JSON တုံ့ပြန်မှုအားလုံးကို JSON ဖိုင်တစ်ခုသို့ ထုတ်ပါ။
- `-r, --rateLimit <NUMBER>`: တောင်းဆိုမှုများ ပေးပို့ရန် တစ်မိနစ်လျှင် rate။ (default: `4`)
- `-q, --quiet`: လိုဂိုကို မပြသပါ။ (default: `false`)

### `vt-ip-lookup` command examples

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

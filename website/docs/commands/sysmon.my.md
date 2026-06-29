# Sysmon Commands

## `sysmon-process-tree` command

သံသယဖြစ်ဖွယ် သို့မဟုတ် အန္တရာယ်ရှိသော process ကဲ့သို့ သတ်မှတ်ထားသော process တစ်ခု၏ process tree ကို ထုတ်ပေးပါ။

* Input: JSONL
* Profile: `all-field-info` နှင့် `all-field-info-verbose` မှလွဲ၍ မည်သည့် profile မဆို
* Output: Terminal သို့မဟုတ် text ဖိုင်

လိုအပ်သော options များ:

- `-p, --processGuid <Process GUID>`: sysmon process GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL timeline ဖိုင် သို့မဟုတ် JSONL ဖိုင်များ၏ directory

Options များ:

- `-o, --output <TXT-FILE>`: ရလဒ်များကို သိမ်းဆည်းရန် text ဖိုင်တစ်ခု။
- `-q, --quiet`: logo ကို မပြသပါနှင့်။ (default: `false`)

### `sysmon-process-tree` command examples

Hayabusa ဖြင့် JSONL timeline ကို ပြင်ဆင်ပါ:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ရလဒ်များကို text ဖိုင်တစ်ခုသို့ သိမ်းဆည်းပါ:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree` screenshot

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

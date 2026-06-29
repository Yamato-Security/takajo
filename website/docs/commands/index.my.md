# Command List

## Automation Commands
* `automagic`: ဖြစ်နိုင်သမျှ command များကို အလိုအလျောက် လုပ်ဆောင်ပြီး ရလဒ်များကို folder အသစ်တစ်ခုသို့ ထုတ်ပေးသည်

## Extract Commands
* `extract-scriptblocks`: PowerShell EID 4104 script block log များကို ထုတ်ယူပြီး ပြန်လည်စုစည်းသည်

## HTML Commands
* `html-report`: static HTML အကျဉ်းချုပ် အစီရင်ခံစာများ ဖန်တီးသည်
* `html-server`: HTML အကျဉ်းချုပ် အစီရင်ခံစာများကို ကြည့်ရှုရန် dynamic web server တစ်ခု ဖန်တီးသည်

## List Commands
* `list-domains`: `vt-domain-lookup` နှင့် အသုံးပြုရန် တစ်မူထူးခြားသော domain များ၏ စာရင်းတစ်ခု ဖန်တီးသည်
* `list-hashes`: `vt-hash-lookup` နှင့် အသုံးပြုရန် process hash များ၏ စာရင်းတစ်ခု ဖန်တီးသည်
* `list-ip-addresses`: `vt-ip-lookup` နှင့် အသုံးပြုရန် တစ်မူထူးခြားသော target နှင့်/သို့မဟုတ် source IP address များ၏ စာရင်းတစ်ခု ဖန်တီးသည်
* `list-undetected-evtx`: မတွေ့ရှိရသေးသော evtx file များ၏ စာရင်းတစ်ခု ဖန်တီးသည်
* `list-unused-rules`: အသုံးမပြုရသေးသော detection rule များ၏ စာရင်းတစ်ခု ဖန်တီးသည်

## Split Commands
* `split-csv-timeline`: ကြီးမားသော CSV timeline တစ်ခုကို computer name အပေါ်အခြေခံ၍ ပိုသေးငယ်သော အပိုင်းများအဖြစ် ခွဲထုတ်သည်
* `split-json-timeline`: ကြီးမားသော JSONL timeline တစ်ခုကို computer name အပေါ်အခြေခံ၍ ပိုသေးငယ်သော အပိုင်းများအဖြစ် ခွဲထုတ်သည်

## Stack Commands
* `stack-cmdlines`: လုပ်ဆောင်ခဲ့သော command line များကို စုပုံပြသည်
* `stack-computers`: computer များကို စုပုံပြသည်
* `stack-dns`: DNS query နှင့် response များကို စုပုံပြသည်
* `stack-ip-addresses`: target IP address များ (`TgtIP` field) သို့မဟုတ် source IP address များ (`SrcIP` field) ကို စုပုံပြသည်
* `stack-logons`: logon များကို target user, target computer, source IP address နှင့် source computer အလိုက် စုပုံပြသည်
* `stack-processes`: လုပ်ဆောင်ခဲ့သော process များကို စုပုံပြသည်
* `stack-services`: `System 7040` နှင့် `Security 4697` event များမှ service name နှင့် path များကို စုပုံပြသည်
* `stack-tasks`: `Security 4698` event များမှ scheduled task အသစ်များကို စုပုံပြပြီး XML task အကြောင်းအရာကို ပိုင်းခြားထုတ်ယူသည်
* `stack-users`: target user များ (`TgtUser` field) သို့မဟုတ် source user များ (`SrcUser` field) ကို စုပုံပြသည်

## Sysmon Commands
* `sysmon-process-tree`: သတ်မှတ်ထားသော process တစ်ခု၏ process tree ကို ထုတ်ပေးသည်

## Timeline Commands
* `timeline-logon`: logon event များ၏ CSV timeline တစ်ခု ဖန်တီးသည်
* `timeline-partition-diagnostic`: partition diagnostic event များ၏ CSV timeline တစ်ခု ဖန်တီးသည်
* `timeline-suspicious-processes`: သံသယဖြစ်ဖွယ် process များ၏ CSV timeline တစ်ခု ဖန်တီးသည်
* `timeline-tasks`: scheduled task များ၏ CSV timeline တစ်ခု ဖန်တီးသည်

## TTP Commands
* `ttp-summary`: computer တစ်ခုစီတွင် တွေ့ရှိသော tactics နှင့် techniques များကို အကျဉ်းချုပ်ပြသည်
* `ttp-visualize`: TTP များကို ထုတ်ယူပြီး MITRE ATT&CK Navigator တွင် မြင်သာစေရန် JSON file တစ်ခု ဖန်တီးသည်
* `ttp-visualize-sigma`: Sigma rule များမှ TTP များကို ထုတ်ယူပြီး MITRE ATT&CK Navigator တွင် မြင်သာစေရန် JSON file တစ်ခု ဖန်တီးသည်

## VirusTotal Commands
* `vt-domain-lookup`: domain များ၏ စာရင်းတစ်ခုကို VirusTotal တွင် ရှာဖွေပြီး အန္တရာယ်ရှိသည်များကို အစီရင်ခံသည်
* `vt-hash-lookup`: hash များ၏ စာရင်းတစ်ခုကို VirusTotal တွင် ရှာဖွေပြီး အန္တရာယ်ရှိသည်များကို အစီရင်ခံသည်
* `vt-ip-lookup`: IP address များ၏ စာရင်းတစ်ခုကို VirusTotal တွင် ရှာဖွေပြီး အန္တရာယ်ရှိသည်များကို အစီရင်ခံသည်

# स्टैक कमांड

## `stack-cmdlines` कमांड

यह कमांड `Sysmon 1` और `Security 4688` इवेंट्स से जानकारी निकालकर निष्पादित कमांड लाइनों को स्टैक करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-y, --ignoreSysmon`: Sysmon 1 इवेंट्स को बाहर रखें (डिफ़ॉल्ट: `false`)
- `-e, --ignoreSecurity`: Security 4688 इवेंट्स को बाहर रखें (डिफ़ॉल्ट: `false`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-cmdlines` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers` कमांड

यह कमांड `Computer` फ़ील्ड के अनुसार कंप्यूटर होस्टनामों को स्टैक करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-c, --sourceComputers`: टारगेट कंप्यूटरों के बजाय सोर्स कंप्यूटरों को स्टैक करें (डिफ़ॉल्ट: false)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-computers` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns` कमांड

यह कमांड Sysmon 22 इवेंट्स से DNS क्वेरीज़ और प्रतिक्रियाओं को स्टैक करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-dns` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses` कमांड

यह कमांड टारगेट IP पतों (`TgtIP` फ़ील्ड) या सोर्स IP पतों (`SrcIP` फ़ील्ड) को स्टैक करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-a, --targetIpAddresses`: सोर्स IP पतों के बजाय टारगेट IP पतों को स्टैक करें (डिफ़ॉल्ट: `false`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-ip-addresses` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons` कमांड

`Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer` के अनुसार लॉगऑन की एक सूची बनाती है।
डिफ़ॉल्ट रूप से जब सोर्स IP पता एक स्थानीय IP पता होता है तब परिणाम फ़िल्टर कर दिए जाते हैं।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --localSrcIpAddresses`: जब सोर्स IP पता स्थानीय हो तब परिणामों को शामिल करें।
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-logons` कमांड के उदाहरण

डिफ़ॉल्ट सेटिंग्स के साथ चलाएं:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

स्थानीय लॉगऑन शामिल करें:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes` कमांड

यह कमांड Sysmon 1 और Security 4688 इवेंट्स से निष्पादित प्रक्रियाओं को स्टैक करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `low`)
- `-y, --ignoreSysmon`: Sysmon 1 इवेंट्स को बाहर रखें (डिफ़ॉल्ट: `false`)
- `-e, --ignoreSecurity`: Security 4688 इवेंट्स को बाहर रखें (डिफ़ॉल्ट: `false`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-processes` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services` कमांड

यह कमांड System 7040 और Security 4697 इवेंट्स से सेवा नामों और पथों को स्टैक करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-y, --ignoreSystem`: System 7040 इवेंट्स को बाहर रखें (डिफ़ॉल्ट: `false`)
- `-e, --ignoreSecurity`: Security 4697 इवेंट्स को बाहर रखें (डिफ़ॉल्ट: `false`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-services` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks` कमांड

यह कमांड Security 4698 इवेंट्स से नए शेड्यूल किए गए कार्यों को स्टैक करेगी और XML कार्य सामग्री को पार्स करेगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-tasks` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users` कमांड

यह कमांड किसी भी ऐसे इवेंट में टारगेट यूज़र्स (`TgtUser` फ़ील्ड (डिफ़ॉल्ट)) या सोर्स यूज़र्स (`SrcUser` फ़ील्ड) को स्टैक करेगी जिसमें वे फ़ील्ड्स हों, साथ ही अलर्ट जानकारी भी दिखाएगी।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` को छोड़कर कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-s, --sourceUsers`: टारगेट यूज़र्स के बजाय सोर्स यूज़र्स को स्टैक करें (डिफ़ॉल्ट: false)
- `-c, --filterComputerAccounts`: कंप्यूटर खातों को फ़िल्टर करें (डिफ़ॉल्ट: true)
- `-f, --filterSystemAccounts`: सिस्टम खातों को फ़िल्टर करें (डिफ़ॉल्ट: true)
- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `informational`)
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `stack-users` कमांड के उदाहरण

टर्मिनल पर आउटपुट:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

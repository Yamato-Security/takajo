# टाइमलाइन कमांड

## `timeline-logon` कमांड

यह कमांड निम्नलिखित लॉगऑन इवेंट्स से जानकारी निकालता है, फ़ील्ड्स को सामान्यीकृत करता है और परिणामों को एक CSV फ़ाइल में सहेजता है:

- `4624` - सफल लॉगऑन
- `4625` - असफल लॉगऑन
- `4634` - खाता लॉगऑफ़
- `4647` - उपयोगकर्ता द्वारा शुरू किया गया लॉगऑफ़
- `4648` - स्पष्ट लॉगऑन
- `4672` - व्यवस्थापक लॉगऑन

इससे लेटरल मूवमेंट, पासवर्ड गेसिंग/स्प्रेइंग, प्रिविलेज एस्केलेशन आदि का पता लगाना आसान हो जाता है...

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: CSV

आवश्यक विकल्प:

- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल।
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-c, --calculateElapsedTime`: सफल लॉगऑन के लिए बीता हुआ समय परिकलित करें। (डिफ़ॉल्ट: `true`)
- `-l, --outputLogoffEvents`: लॉगऑफ़ इवेंट्स को अलग प्रविष्टियों के रूप में आउटपुट करें। (डिफ़ॉल्ट: `false`)
- `-a, --outputAdminLogonEvents`: व्यवस्थापक लॉगऑन इवेंट्स को अलग प्रविष्टियों के रूप में आउटपुट करें। (डिफ़ॉल्ट: `false`)
- `-q, --quiet`: लोगो न दिखाएं। (डिफ़ॉल्ट: `false`)

### `timeline-logon` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

लॉगऑन टाइमलाइन को एक CSV फ़ाइल में सहेजें:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-logon` स्क्रीनशॉट

![timeline-logon](../assets/screenshots/timeline-logon.png)

## `timeline-partition-diagnostic` कमांड

Windows 10 `Microsoft-Windows-Partition%4Diagnostic.evtx` फ़ाइलों को पार्स करके पार्टीशन डायग्नोस्टिक इवेंट्स की एक CSV टाइमलाइन बनाता है और सभी कनेक्टेड डिवाइसेज़ और उनके वॉल्यूम सीरियल नंबर के बारे में जानकारी रिपोर्ट करता है, जो वर्तमान में डिवाइस पर मौजूद हैं और पहले मौजूद थे दोनों।
यह प्रक्रिया [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser) टूल पर आधारित है।

* इनपुट: JSONL
* प्रोफ़ाइल: कोई भी
* आउटपुट: टर्मिनल या CSV

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल।
- `-q, --quiet`: लोगो न दिखाएं। (डिफ़ॉल्ट: `false`)

### `timeline-partition-diagnostic` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

कनेक्टेड डिवाइसेज़ की एक CSV टाइमलाइन बनाएं:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## `timeline-suspicious-processes` कमांड

संदिग्ध प्रक्रियाओं की एक CSV टाइमलाइन बनाएं।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: टर्मिनल या CSV

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी
- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल (डिफ़ॉल्ट: `stdout`)

विकल्प:

- `-l, --level <LEVEL>`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `high`)
- `-q, --quiet`: लोगो न दिखाएं। (डिफ़ॉल्ट: `false`)

### `timeline-suspicious-processes` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ऐसी प्रक्रियाओं को खोजें जिनका अलर्ट स्तर `high` या उससे ऊपर था और परिणामों को स्क्रीन पर आउटपुट करें:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

ऐसी प्रक्रियाओं को खोजें जिनका अलर्ट स्तर `low` या उससे ऊपर था और परिणामों को स्क्रीन पर आउटपुट करें:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

परिणामों को एक CSV फ़ाइल में सहेजें:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### `timeline-suspicious-processes` स्क्रीनशॉट

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## `timeline-tasks` कमांड

यह कमांड Security 4698 इवेंट्स से नए शेड्यूल किए गए कार्यों को स्टैक करेगा और XML कार्य सामग्री को पार्स करेगा।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: टर्मिनल या CSV फ़ाइल

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल।
- `-q, --quiet`: लोगो न दिखाएं। (डिफ़ॉल्ट: `false`)

### `timeline-tasks` कमांड उदाहरण

टर्मिनल पर आउटपुट करें:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

CSV में सहेजें:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

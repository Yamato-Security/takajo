# Split कमांड

## `split-csv-timeline` कमांड

एक बड़ी CSV टाइमलाइन को कंप्यूटर नाम के आधार पर छोटी टाइमलाइनों में विभाजित करें।

* इनपुट: Non-multiline CSV
* प्रोफ़ाइल: कोई भी
* आउटपुट: एकाधिक CSV फ़ाइलें

आवश्यक विकल्प:

- `-t, --timeline <CSV-FILE>`: Hayabusa द्वारा बनाई गई CSV टाइमलाइन।

विकल्प:

- `-m, --makeMultiline`: फ़ील्ड को एकाधिक पंक्तियों में आउटपुट करें। (डिफ़ॉल्ट: `false`)
- `-o, --output <DIR>`: CSV फ़ाइलों को सहेजने के लिए डायरेक्टरी। (डिफ़ॉल्ट: `output`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `split-csv-timeline` कमांड के उदाहरण

Hayabusa के साथ CSV टाइमलाइन तैयार करें:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

एकल CSV टाइमलाइन को डिफ़ॉल्ट `output` डायरेक्टरी में एकाधिक CSV टाइमलाइनों में विभाजित करें:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

फ़ील्ड जानकारी को न्यूलाइन वर्णों से अलग करके बहु-पंक्ति प्रविष्टियाँ बनाएं और `case-1-csv` डायरेक्टरी में सहेजें:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline` कमांड

एक बड़ी JSONL टाइमलाइन को कंप्यूटर नाम के आधार पर छोटी टाइमलाइनों में विभाजित करें।

* इनपुट: JSONL
* प्रोफ़ाइल: कोई भी
* आउटपुट: एकाधिक JSONL फ़ाइलें

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी।

विकल्प:

- `-o, --output <DIR>`: JSONL फ़ाइलों को सहेजने के लिए डायरेक्टरी। (डिफ़ॉल्ट: `output`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `split-json-timeline` कमांड के उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

एकल JSONL टाइमलाइन को डिफ़ॉल्ट `output` डायरेक्टरी में एकाधिक JSONL टाइमलाइनों में विभाजित करें:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

`case-1-jsonl` डायरेक्टरी में सहेजें:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

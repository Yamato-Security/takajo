# HTML कमांड

## `html-report` कमांड

डिटेक्शन वाले नियमों और कंप्यूटरों के लिए HTML सारांश रिपोर्ट बनाएं।
यह कमांड सबसे पहले एक इंडेक्स्ड DuckDB डेटाबेस फ़ाइल (डिफ़ॉल्ट) या SQLite डेटाबेस फ़ाइल बनाता है ताकि सारांश रिपोर्ट बनाने के लिए आवश्यक डेटा पर तेज़ी से लुकअप किया जा सके।

* इनपुट: JSONL
* प्रोफ़ाइल: कोई भी verbose प्रोफ़ाइल
* आउटपुट: कंप्यूटर नाम के आधार पर अलग-अलग HTML सारांश रिपोर्ट के साथ-साथ एक `index.html` मुख्य पृष्ठ

आवश्यक विकल्प:

- `-o, --output`: html रिपोर्ट डायरेक्टरी का नाम
- `-r, --rulepath`: Hayabusa नियम डायरेक्टरी का पथ
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी

विकल्प:

- `-C, --clobber`: सहेजते समय डेटाबेस फ़ाइल को अधिलेखित करें (डिफ़ॉल्ट: `false`)
- `-q, --quiet`: लॉन्च बैनर प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
- `-s, --dboutput`: परिणामों को एक डेटाबेस फ़ाइल में सहेजें (डिफ़ॉल्ट: `html-report.duckdb` या `--sqlite` के साथ `html-report.sqlite`)
- `--skipProgressBar`: प्रोग्रेस बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
- `--sqlite`: DuckDB के बजाय SQLite बैकएंड का उपयोग करें (डिफ़ॉल्ट: `false`)

### `html-report` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

या

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

HTML सारांश रिपोर्ट बनाएं:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report` स्क्रीनशॉट

#### नियम सारांश

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### कंप्यूटर सारांश

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### नियम सूची

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server` कमांड

HTML सारांश रिपोर्ट देखने के लिए एक डायनामिक वेब सर्वर बनाएं।
यह कमांड सबसे पहले एक इंडेक्स्ड DuckDB डेटाबेस फ़ाइल (डिफ़ॉल्ट) या SQLite डेटाबेस फ़ाइल बनाता है ताकि सारांश रिपोर्ट बनाने के लिए आवश्यक डेटा पर तेज़ी से लुकअप किया जा सके।
यह `html-report` कमांड के समान है लेकिन अधिक स्केलेबल है और तिथियों एवं नियमों पर फ़िल्टरिंग की अनुमति देता है।

* इनपुट: JSONL
* प्रोफ़ाइल: कोई भी verbose प्रोफ़ाइल
* आउटपुट: डिफ़ॉल्ट रूप से, `http://localhost:8823` पर सुनेगा

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी

विकल्प:

- `-C, --clobber`: सहेजते समय डेटाबेस फ़ाइल को अधिलेखित करें (डिफ़ॉल्ट: `false`)
- `-p, --port`: वेब सर्वर पोर्ट नंबर (डिफ़ॉल्ट: `8823`)
- `-q, --quiet`: लॉन्च बैनर प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
- `-r, --rulepath`: Hayabusa नियम डायरेक्टरी का पथ (यह वैकल्पिक है लेकिन नियम फ़ाइलों के लिए सही लिंक बनाने हेतु आवश्यक है)
- `-s, --dboutput`: परिणामों को एक डेटाबेस फ़ाइल में सहेजें (डिफ़ॉल्ट: `html-report.duckdb` या `--sqlite` के साथ `html-report.sqlite`)
- `--skipProgressBar`: प्रोग्रेस बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
- `--sqlite`: DuckDB के बजाय SQLite बैकएंड का उपयोग करें (डिफ़ॉल्ट: `false`)

### `html-report` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

या

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

वेब सर्वर शुरू करें:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server` स्क्रीनशॉट

#### नियम सूची

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### कंप्यूटर सारांश

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### नियम फ़िल्टरिंग

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### नियम फ़िल्टरिंग

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

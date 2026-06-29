# TTP कमांड्स

## `ttp-summary` कमांड

यह कमांड sigma नियमों के `tags` फ़ील्ड में परिभाषित MITRE ATT&CK TTPs के अनुसार प्रत्येक कंप्यूटर में पाई गई रणनीतियों और तकनीकों का सारांश प्रस्तुत करती है।

* इनपुट: JSONL
* प्रोफ़ाइल: एक प्रोफ़ाइल जो `%MitreTactics%` और `%MitreTags%` फ़ील्ड आउटपुट करती है। (उदा: `verbose`, `all-field-info-verbose`, `super-verbose`)
* आउटपुट: टर्मिनल या CSV

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-o, --output <CSV-FILE>`: परिणामों को सहेजने के लिए CSV फ़ाइल।
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `ttp-summary` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTP सारांश को टर्मिनल में प्रिंट करें:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

परिणामों को एक CSV फ़ाइल में सहेजें:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary` स्क्रीनशॉट

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize` कमांड

यह कमांड TTPs निकालती है और [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) में विज़ुअलाइज़ करने के लिए एक JSON फ़ाइल बनाती है।

* इनपुट: JSONL
* प्रोफ़ाइल: एक प्रोफ़ाइल जो `%MitreTactics%` और `%MitreTags%` फ़ील्ड आउटपुट करती है। (उदा: `verbose`, `all-field-info-verbose`, `super-verbose`)
* आउटपुट: JSON

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-o, --output <JSON-FILE>`: परिणामों को सहेजने के लिए JSON फ़ाइल। (डिफ़ॉल्ट: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `ttp-visualize` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTPs निकालें और `mitre-ttp-heatmap.json` में सहेजें:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

[https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/) खोलें, `Open Existing Layer` पर क्लिक करें और सहेजी गई JSON फ़ाइल अपलोड करें।

### `ttp-visualize` स्क्रीनशॉट

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma` कमांड

यह कमांड Sigma से TTPs निकालती है और [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) में विज़ुअलाइज़ करने के लिए एक JSON फ़ाइल बनाती है।

* इनपुट: Sigma नियम डायरेक्टरी
* आउटपुट: JSON

आवश्यक विकल्प:

- `-r, --ruleDir <SIGMA-DIR>`: Sigma नियम डायरेक्टरी

विकल्प:

- `-o, --output <JSON-FILE>`: परिणामों को सहेजने के लिए JSON फ़ाइल। (डिफ़ॉल्ट: `mitre-attack-navigator.json`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `ttp-visualize-sigma` कमांड उदाहरण

Sigma रिपॉजिटरी क्लोन करें:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Sigma से TTPs निकालें और `mitre-attack-navigator.json` में सहेजें:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

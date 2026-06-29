# स्वचालन कमांड

## `automagic` कमांड

यथासंभव अधिक से अधिक कमांड स्वचालित रूप से निष्पादित करता है और परिणामों को एक नए फ़ोल्डर में आउटपुट करता है

> नोट: सभी कमांड का उपयोग करने के लिए आपको `verbose` या `super-verbose` प्रोफ़ाइल का उपयोग करना चाहिए।

* इनपुट: JSONL फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: एक नया फ़ोल्डर जिसमें सभी परिणाम विभिन्न फ़ाइलों में होते हैं

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी।

विकल्प:

- `-d, --displayTable`: परिणाम तालिका प्रदर्शित करें (डिफ़ॉल्ट: `false`)
- `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `low`)
- `-o, --output`: आउटपुट डायरेक्टरी (डिफ़ॉल्ट: `case-1`)
- `-q, --quiet`: लॉन्च बैनर प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
- `-s, --skipProgressBar`: प्रगति पट्टी प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `automagic` कमांड के उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

यथासंभव अधिक से अधिक Takajo कमांड चलाएँ और परिणामों को `case-1` फ़ोल्डर के अंतर्गत सहेजें:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

`hayabusa-results` डायरेक्टरी पर यथासंभव अधिक से अधिक Takajo कमांड चलाएँ और परिणामों को `case-1` फ़ोल्डर के अंतर्गत सहेजें:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

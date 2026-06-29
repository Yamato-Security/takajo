# List कमांड्स

## `list-domains` कमांड

`vt-domain-lookup` के साथ उपयोग के लिए अद्वितीय डोमेन की एक सूची बनाता है।
वर्तमान में यह केवल Sysmon EID 22 लॉग्स में क्वेरी किए गए डोमेन की जाँच करेगा, लेकिन इसे अंतर्निहित Windows DNS Client और Server लॉग्स का समर्थन करने के लिए अपडेट किया जाएगा।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: टेक्स्ट फ़ाइल

आवश्यक विकल्प:

 - `-o, --output <TXT-FILE>`: परिणामों को एक टेक्स्ट फ़ाइल में सहेजें।
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी।

विकल्प:

 - `-s, --includeSubdomains`: सबडोमेन शामिल करें (डिफ़ॉल्ट: `false`)
 - `-w, --includeWorkstations`: स्थानीय वर्कस्टेशन नाम शामिल करें (डिफ़ॉल्ट: `false`)
 - `-q, --quiet`: लोगो प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
 - `-s, --skipProgressBar`: प्रगति पट्टी प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `list-domains` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

परिणामों को एक टेक्स्ट फ़ाइल में सहेजें:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

सबडोमेन शामिल करें:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes` कमांड

vt-hash-lookup के साथ उपयोग के लिए प्रोसेस हैश की एक सूची बनाएं (इनपुट: JSONL, प्रोफ़ाइल: standard)

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: टेक्स्ट फ़ाइल

आवश्यक विकल्प:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी
 - `-o, --output <BASE-NAME>`: टेक्स्ट परिणामों को सहेजने के लिए बेस नाम निर्दिष्ट करें।

विकल्प:

 - `-l, --level`: न्यूनतम स्तर निर्दिष्ट करें। (डिफ़ॉल्ट: `high`)
 - `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
 - `-s, --skipProgressBar`: प्रगति पट्टी प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `list-hashes` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

प्रत्येक हैश प्रकार के लिए परिणामों को एक अलग टेक्स्ट फ़ाइल में सहेजें:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

उदाहरण के लिए, यदि sysmon लॉग्स में `MD5`, `SHA1` और `IMPHASH` हैश संग्रहीत हैं, तो निम्नलिखित फ़ाइलें बनाई जाएंगी: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses` कमांड

`vt-ip-lookup` के साथ उपयोग के लिए अद्वितीय लक्ष्य और/या स्रोत IP पतों की एक सूची बनाता है।
यह सभी परिणामों में लक्ष्य IP पतों के लिए `TgtIP` फ़ील्ड और स्रोत IP पतों के लिए `SrcIP` फ़ील्ड निकालेगा और केवल अद्वितीय IP पतों को एक टेक्स्ट फ़ाइल में आउटपुट करेगा।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: टेक्स्ट फ़ाइल

आवश्यक विकल्प:

 - `-o, --output <TXT-FILE>`: परिणामों को एक टेक्स्ट फ़ाइल में सहेजें।
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी।

विकल्प:

 - `-i, --inbound`: इनबाउंड ट्रैफ़िक शामिल करें। (डिफ़ॉल्ट: `true`)
 - `-O, --outbound`: आउटबाउंड ट्रैफ़िक शामिल करें। (डिफ़ॉल्ट: `true`)
 - `-p, --privateIp`: निजी IP पते शामिल करें (डिफ़ॉल्ट: `false`)
 - `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)
 - `-s, --skipProgressBar`: "प्रगति पट्टी प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `list-ip-addresses` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

परिणामों को एक टेक्स्ट फ़ाइल में सहेजें:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

इनबाउंड ट्रैफ़िक को बाहर रखें:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

निजी IP पते शामिल करें:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx` कमांड

उन सभी `.evtx` फ़ाइलों की सूची बनाएं जिनके लिए Hayabusa के पास कोई डिटेक्शन नियम नहीं था।
यह सैंपल evtx फ़ाइलों पर उपयोग के लिए है जिनमें सभी में दुर्भावनापूर्ण गतिविधि के प्रमाण होते हैं, जैसे कि [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) रिपॉज़िटरी में सैंपल evtx फ़ाइलें।

* इनपुट: CSV
* प्रोफ़ाइल: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > आपको पहले एक ऐसी प्रोफ़ाइल के साथ Hayabusa चलाना होगा जो `%EvtxFile%` कॉलम जानकारी सहेजती है और परिणामों को एक CSV टाइमलाइन में सहेजना होगा।
  > आप यहाँ [here](https://github.com/Yamato-Security/hayabusa#profiles) देख सकते हैं कि Hayabusa विभिन्न प्रोफ़ाइलों के अनुसार कौन से कॉलम सहेजता है।
* आउटपुट: टर्मिनल या टेक्स्ट फ़ाइल

आवश्यक विकल्प:

- `-e, --evtx-dir <EVTX-DIR>`: उन `.evtx` फ़ाइलों की डायरेक्टरी जिन्हें आपने Hayabusa के साथ स्कैन किया था।
- `-t, --timeline <CSV-FILE>`: Hayabusa CSV टाइमलाइन।

विकल्प:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: evtx कॉलम के लिए एक कस्टम कॉलम नाम निर्दिष्ट करें। (डिफ़ॉल्ट: Hayabusa का डिफ़ॉल्ट `EvtxFile`)
- `-o, --output <TXT-FILE>`: परिणामों को एक टेक्स्ट फ़ाइल में सहेजें। (डिफ़ॉल्ट: स्क्रीन पर आउटपुट)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `list-undetected-evtx` कमांड उदाहरण

Hayabusa के साथ CSV टाइमलाइन तैयार करें:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

परिणामों को स्क्रीन पर आउटपुट करें:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

परिणामों को एक टेक्स्ट फ़ाइल में सहेजें:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules` कमांड

उन सभी `.yml` डिटेक्शन नियमों की सूची बनाएं जिन्होंने कुछ भी डिटेक्ट नहीं किया।
यह नियमों की विश्वसनीयता निर्धारित करने में मदद के लिए उपयोगी है।
अर्थात्, कौन से नियम दुर्भावनापूर्ण गतिविधि खोजने के लिए ज्ञात हैं और कौन से अभी भी अप्रमाणित हैं और जिन्हें सैंपल `.evtx` फ़ाइलों की आवश्यकता है।

* इनपुट: CSV
* प्रोफ़ाइल: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > आपको पहले एक ऐसी प्रोफ़ाइल के साथ Hayabusa चलाना होगा जो `%RuleFile%` कॉलम जानकारी सहेजती है और परिणामों को एक CSV टाइमलाइन में सहेजना होगा।
  > आप यहाँ [here](https://github.com/Yamato-Security/hayabusa#profiles) देख सकते हैं कि Hayabusa विभिन्न प्रोफ़ाइलों के अनुसार कौन से कॉलम सहेजता है।
* आउटपुट: टर्मिनल या टेक्स्ट फ़ाइल

आवश्यक विकल्प:

- `-r, --rules-dir <DIR>`: उन `.yml` नियम फ़ाइलों की डायरेक्टरी जिनका आपने Hayabusa के साथ उपयोग किया था।
- `-t, --timeline <CSV-FILE>`: Hayabusa द्वारा बनाई गई CSV टाइमलाइन।

विकल्प:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: नियम फ़ाइल कॉलम के लिए एक कस्टम कॉलम नाम निर्दिष्ट करें। (डिफ़ॉल्ट: Hayabusa का डिफ़ॉल्ट `RuleFile`)
- `-o, --output <TXT-FILE>`: परिणामों को एक टेक्स्ट फ़ाइल में सहेजें। (डिफ़ॉल्ट: स्क्रीन पर आउटपुट)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `list-unused-rules` कमांड उदाहरण

Hayabusa के साथ CSV टाइमलाइन तैयार करें:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

परिणामों को स्क्रीन पर आउटपुट करें:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

परिणामों को एक टेक्स्ट फ़ाइल में सहेजें:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

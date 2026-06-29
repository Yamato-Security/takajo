# Sysmon कमांड

## `sysmon-process-tree` कमांड

किसी विशिष्ट प्रोसेस, जैसे कि किसी संदिग्ध या दुर्भावनापूर्ण प्रोसेस, का प्रोसेस ट्री आउटपुट करें।

* इनपुट: JSONL
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: टर्मिनल या टेक्स्ट फ़ाइल

आवश्यक विकल्प:

- `-p, --processGuid <Process GUID>`: sysmon प्रोसेस GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या JSONL फ़ाइलों की डायरेक्टरी

विकल्प:

- `-o, --output <TXT-FILE>`: परिणामों को सहेजने के लिए एक टेक्स्ट फ़ाइल।
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `sysmon-process-tree` कमांड के उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

परिणामों को एक टेक्स्ट फ़ाइल में सहेजें:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree` स्क्रीनशॉट

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

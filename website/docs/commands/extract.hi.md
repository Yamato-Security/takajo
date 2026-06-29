# कमांड निकालें

## `extract-scriptblocks` कमांड

PowerShell EID 4104 स्क्रिप्ट ब्लॉक लॉग को निकालता और पुनः जोड़ता है।

> नोट: PowerShell स्क्रिप्ट को कोड सिंटैक्स हाइलाइटिंग के साथ `.ps1` फ़ाइलों के रूप में खोलना सबसे अच्छा है, लेकिन हम दुर्भावनापूर्ण कोड के किसी भी आकस्मिक चलने को रोकने के लिए `.txt` एक्सटेंशन का उपयोग करते हैं।

* इनपुट: JSONL
* प्रोफ़ाइल: कोई भी
* आउटपुट: टर्मिनल और PowerShell स्क्रिप्ट की डायरेक्टरी

आवश्यक विकल्प:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL टाइमलाइन फ़ाइल या डायरेक्टरी

विकल्प:

 - `-l, --level`: न्यूनतम अलर्ट स्तर निर्दिष्ट करें (डिफ़ॉल्ट: `low`)
 - `-o, --output`: आउटपुट डायरेक्टरी (डिफ़ॉल्ट: `scriptblock-logs`)
 - `-q, --quiet`: लॉन्च बैनर प्रदर्शित न करें (डिफ़ॉल्ट: `false`)
 - `-s, --skipProgressBar`: प्रगति बार प्रदर्शित न करें (डिफ़ॉल्ट: `false`)

### `extract-scriptblocks` कमांड उदाहरण

Hayabusa के साथ JSONL टाइमलाइन तैयार करें:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

PowerShell EID 4104 स्क्रिप्ट ब्लॉक लॉग को `scriptblock-logs` डायरेक्टरी में निकालें:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### `extract-scriptblocks` स्क्रीनशॉट

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

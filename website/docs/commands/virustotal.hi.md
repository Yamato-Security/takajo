# VirusTotal कमांड

## `vt-domain-lookup` कमांड

VirusTotal पर डोमेन की एक सूची देखें

* इनपुट: टेक्स्ट फ़ाइल
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: CSV

आवश्यक विकल्प:

- `-a, --apiKey <API-KEY>`: आपकी VirusTotal API कुंजी।
- `-d, --domainList <TXT-FILE>`: डोमेन की एक टेक्स्ट फ़ाइल सूची।
- `-o, --output <CSV-FILE>`: परिणामों को एक CSV फ़ाइल में सहेजें।

विकल्प:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal से सभी JSON प्रतिक्रियाओं को एक JSON फ़ाइल में आउटपुट करें।
- `-r, --rateLimit <NUMBER>`: अनुरोध भेजने की प्रति मिनट दर। (डिफ़ॉल्ट: `4`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `vt-domain-lookup` कमांड के उदाहरण

सबसे पहले `list-domains` कमांड के साथ डोमेन की एक सूची बनाएं।
फिर निम्नलिखित के साथ उन डोमेन को देखें:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup` कमांड

VirusTotal पर हैश की एक सूची देखें।

* इनपुट: टेक्स्ट फ़ाइल
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: CSV

आवश्यक विकल्प:

- `-a, --apiKey <API-KEY>`: आपकी VirusTotal API कुंजी।
- `-H, --hashList <HASH-LIST>`: हैश की एक टेक्स्ट फ़ाइल।
- `-o, --output <CSV-FILE>`: परिणामों को एक CSV फ़ाइल में सहेजें।

विकल्प:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal से सभी JSON प्रतिक्रियाओं को एक JSON फ़ाइल में आउटपुट करें।
- `-r, --rateLimit <NUMBER>`: अनुरोध भेजने की प्रति मिनट दर। (डिफ़ॉल्ट: `4`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `vt-hash-lookup` कमांड के उदाहरण

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup` कमांड

VirusTotal पर IP पतों की एक सूची देखें।

* इनपुट: टेक्स्ट फ़ाइल
* प्रोफ़ाइल: `all-field-info` और `all-field-info-verbose` के अलावा कोई भी
* आउटपुट: CSV

आवश्यक विकल्प:

- `-a, --apiKey <API-KEY>`: आपकी VirusTotal API कुंजी।
- `-i, --ipList <IP-ADDRESS-LIST>`: IP पतों की एक टेक्स्ट फ़ाइल।
- `-o, --output <CSV-FILE>`: परिणामों को एक CSV फ़ाइल में सहेजें।

विकल्प:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal से सभी JSON प्रतिक्रियाओं को एक JSON फ़ाइल में आउटपुट करें।
- `-r, --rateLimit <NUMBER>`: अनुरोध भेजने की प्रति मिनट दर। (डिफ़ॉल्ट: `4`)
- `-q, --quiet`: लोगो प्रदर्शित न करें। (डिफ़ॉल्ट: `false`)

### `vt-ip-lookup` कमांड के उदाहरण

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

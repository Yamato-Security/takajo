# डाउनलोड

कृपया Takajō का नवीनतम स्थिर संस्करण संकलित बाइनरी के साथ डाउनलोड करें या [Releases](https://github.com/Yamato-Security/takajo/releases) पृष्ठ से स्रोत कोड संकलित करें।

> Note: हम 64-बिट Windows और Intel तथा Arm-आधारित macOS के लिए रिलीज़ बाइनरी प्रदान करते हैं लेकिन Linux के लिए नहीं, क्योंकि इस समय Linux के लिए MUSL बाइनरी प्रदान करना कठिन है।

## आवश्यकताएँ

`html-report` और `html-server` कमांड तेज़ विश्लेषणात्मक क्वेरीज़ के लिए डिफ़ॉल्ट डेटाबेस बैकएंड के रूप में [DuckDB](https://duckdb.org/) का उपयोग करते हैं।
इन कमांड का उपयोग करने से पहले आपको DuckDB इंस्टॉल करना होगा।
यदि आप DuckDB इंस्टॉल नहीं करना चाहते हैं, तो आप इसके बजाय SQLite का उपयोग करने के लिए `--sqlite` फ़्लैग का उपयोग कर सकते हैं।

### macOS (Homebrew)

```
brew install duckdb
```

### Windows (winget)

```
winget install DuckDB.cli
```

### Linux

```
wget -q https://github.com/duckdb/duckdb/releases/download/v1.4.4/libduckdb-linux-amd64.zip
unzip -o libduckdb-linux-amd64.zip -d duckdb_lib
sudo cp duckdb_lib/duckdb.h /usr/local/include/
sudo cp duckdb_lib/libduckdb.so /usr/local/lib/
sudo ldconfig
```

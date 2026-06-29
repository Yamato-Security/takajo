# أوامر VirusTotal

## أمر `vt-domain-lookup`

البحث عن قائمة من النطاقات على VirusTotal

* الإدخال: ملف نصي
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* الإخراج: CSV

الخيارات المطلوبة:

- `-a, --apiKey <API-KEY>`: مفتاح API الخاص بك على VirusTotal.
- `-d, --domainList <TXT-FILE>`: ملف نصي يحتوي على قائمة من النطاقات.
- `-o, --output <CSV-FILE>`: حفظ النتائج في ملف CSV.

الخيارات:

- `-j, --jsonOutput <JSON-FILE>`: إخراج جميع استجابات JSON من VirusTotal إلى ملف JSON.
- `-r, --rateLimit <NUMBER>`: المعدل في الدقيقة لإرسال الطلبات. (الافتراضي: `4`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `vt-domain-lookup`

أولاً، أنشئ قائمة من النطاقات باستخدام أمر `list-domains`.
ثم ابحث عن تلك النطاقات بالطريقة التالية:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## أمر `vt-hash-lookup`

البحث عن قائمة من التجزئات (hashes) على VirusTotal.

* الإدخال: ملف نصي
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* الإخراج: CSV

الخيارات المطلوبة:

- `-a, --apiKey <API-KEY>`: مفتاح API الخاص بك على VirusTotal.
- `-H, --hashList <HASH-LIST>`: ملف نصي يحتوي على التجزئات (hashes).
- `-o, --output <CSV-FILE>`: حفظ النتائج في ملف CSV.

الخيارات:

- `-j, --jsonOutput <JSON-FILE>`: إخراج جميع استجابات JSON من VirusTotal إلى ملف JSON.
- `-r, --rateLimit <NUMBER>`: المعدل في الدقيقة لإرسال الطلبات. (الافتراضي: `4`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## أمر `vt-ip-lookup`

البحث عن قائمة من عناوين IP على VirusTotal.

* الإدخال: ملف نصي
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* الإخراج: CSV

الخيارات المطلوبة:

- `-a, --apiKey <API-KEY>`: مفتاح API الخاص بك على VirusTotal.
- `-i, --ipList <IP-ADDRESS-LIST>`: ملف نصي يحتوي على عناوين IP.
- `-o, --output <CSV-FILE>`: حفظ النتائج في ملف CSV.

الخيارات:

- `-j, --jsonOutput <JSON-FILE>`: إخراج جميع استجابات JSON من VirusTotal إلى ملف JSON.
- `-r, --rateLimit <NUMBER>`: المعدل في الدقيقة لإرسال الطلبات. (الافتراضي: `4`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

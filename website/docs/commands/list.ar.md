# أوامر القوائم

## أمر `list-domains`

ينشئ قائمة بالنطاقات الفريدة لاستخدامها مع `vt-domain-lookup`.
حاليًا سيتحقق فقط من النطاقات المستعلَم عنها في سجلات Sysmon EID 22 ولكن سيتم تحديثه لدعم سجلات Windows DNS Client و Server المدمجة.

* المدخل: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرج: ملف نصي

الخيارات المطلوبة:

 - `-o, --output <TXT-FILE>`: حفظ النتائج في ملف نصي.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو دليل الجدول الزمني JSONL الخاص بـ Hayabusa.

الخيارات:

 - `-s, --includeSubdomains`: تضمين النطاقات الفرعية (الافتراضي: `false`)
 - `-w, --includeWorkstations`: تضمين أسماء محطات العمل المحلية (الافتراضي: `false`)
 - `-q, --quiet`: عدم عرض الشعار (الافتراضي: `false`)
 - `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `list-domains`

تجهيز الجدول الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

حفظ النتائج في ملف نصي:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

تضمين النطاقات الفرعية:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## أمر `list-hashes`

ينشئ قائمة بقيم تجزئة العمليات لاستخدامها مع vt-hash-lookup (المدخل: JSONL، الملف الشخصي: standard)

* المدخل: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرج: ملف نصي

الخيارات المطلوبة:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL
 - `-o, --output <BASE-NAME>`: تحديد الاسم الأساسي لحفظ النتائج النصية فيه.

الخيارات:

 - `-l, --level`: تحديد المستوى الأدنى. (الافتراضي: `high`)
 - `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
 - `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `list-hashes`

تجهيز الجدول الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

حفظ النتائج في ملف نصي مختلف لكل نوع تجزئة:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

على سبيل المثال، إذا كانت قيم التجزئة `MD5` و `SHA1` و `IMPHASH` مخزَّنة في سجلات sysmon، فسيتم إنشاء الملفات التالية: `case-1-MD5-hashes.txt`، `case-1-SHA1-hashes.txt`، `case-1-ImportHashes.txt`

## أمر `list-ip-addresses`

ينشئ قائمة بعناوين IP الهدف و/أو المصدر الفريدة لاستخدامها مع `vt-ip-lookup`.
سيستخرج حقول `TgtIP` لعناوين IP الهدف وحقول `SrcIP` لعناوين IP المصدر في جميع النتائج ويُخرج فقط عناوين IP الفريدة إلى ملف نصي.

* المدخل: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرج: ملف نصي

الخيارات المطلوبة:

 - `-o, --output <TXT-FILE>`: حفظ النتائج في ملف نصي.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو دليل الجدول الزمني JSONL الخاص بـ Hayabusa.

الخيارات:

 - `-i, --inbound`: تضمين حركة المرور الواردة. (الافتراضي: `true`)
 - `-O, --outbound`: تضمين حركة المرور الصادرة. (الافتراضي: `true`)
 - `-p, --privateIp`: تضمين عناوين IP الخاصة (الافتراضي: `false`)
 - `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
 - `-s, --skipProgressBar`: "عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `list-ip-addresses`

تجهيز الجدول الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

حفظ النتائج في ملف نصي:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

استبعاد حركة المرور الواردة:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

تضمين عناوين IP الخاصة:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## أمر `list-undetected-evtx`

يسرد جميع ملفات `.evtx` التي لم يكن لدى Hayabusa قاعدة كشف لها.
يُقصد بذلك استخدامه على ملفات evtx النموذجية التي تحتوي جميعها على أدلة نشاط ضار مثل ملفات evtx النموذجية في مستودع [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx).

* المدخل: CSV
* الملف الشخصي: `verbose`، `all-field-info-verbose`، `super-verbose`، `timesketch-verbose`
  > تحتاج أولًا إلى تشغيل Hayabusa بملف شخصي يحفظ معلومات العمود `%EvtxFile%` وحفظ النتائج في جدول زمني CSV.
  > يمكنك معرفة الأعمدة التي يحفظها Hayabusa وفقًا للملفات الشخصية المختلفة [هنا](https://github.com/Yamato-Security/hayabusa#profiles).
* المخرج: الطرفية أو ملف نصي

الخيارات المطلوبة:

- `-e, --evtx-dir <EVTX-DIR>`: دليل ملفات `.evtx` التي فحصتها باستخدام Hayabusa.
- `-t, --timeline <CSV-FILE>`: الجدول الزمني CSV الخاص بـ Hayabusa.

الخيارات:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: تحديد اسم عمود مخصص لعمود evtx. (الافتراضي: القيمة الافتراضية لـ Hayabusa وهي `EvtxFile`)
- `-o, --output <TXT-FILE>`: حفظ النتائج في ملف نصي. (الافتراضي: الإخراج إلى الشاشة)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `list-undetected-evtx`

تجهيز الجدول الزمني CSV باستخدام Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

إخراج النتائج إلى الشاشة:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

حفظ النتائج في ملف نصي:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## أمر `list-unused-rules`

يسرد جميع قواعد الكشف `.yml` التي لم تكتشف أي شيء.
هذا مفيد للمساعدة في تحديد موثوقية القواعد.
أي معرفة القواعد المعروفة بأنها تعثر على نشاط ضار وأيها لا يزال غير مختبَر ويحتاج إلى ملفات `.evtx` نموذجية.

* المدخل: CSV
* الملف الشخصي: `verbose`، `all-field-info-verbose`، `super-verbose`، `timesketch-verbose`
  > تحتاج أولًا إلى تشغيل Hayabusa بملف شخصي يحفظ معلومات العمود `%RuleFile%` وحفظ النتائج في جدول زمني CSV.
  > يمكنك معرفة الأعمدة التي يحفظها Hayabusa وفقًا للملفات الشخصية المختلفة [هنا](https://github.com/Yamato-Security/hayabusa#profiles).
* المخرج: الطرفية أو ملف نصي

الخيارات المطلوبة:

- `-r, --rules-dir <DIR>`: دليل ملفات قواعد `.yml` التي استخدمتها مع Hayabusa.
- `-t, --timeline <CSV-FILE>`: الجدول الزمني CSV الذي أنشأه Hayabusa.

الخيارات:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: تحديد اسم عمود مخصص لعمود ملف القاعدة. (الافتراضي: القيمة الافتراضية لـ Hayabusa وهي `RuleFile`)
- `-o, --output <TXT-FILE>`: حفظ النتائج في ملف نصي. (الافتراضي: الإخراج إلى الشاشة)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `list-unused-rules`

تجهيز الجدول الزمني CSV باستخدام Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

إخراج النتائج إلى الشاشة:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

حفظ النتائج في ملف نصي:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

# أوامر الخط الزمني

## أمر `timeline-logon`

يستخرج هذا الأمر المعلومات من أحداث تسجيل الدخول التالية، ويوحّد الحقول ويحفظ النتائج في ملف CSV:

- `4624` - تسجيل دخول ناجح
- `4625` - تسجيل دخول فاشل
- `4634` - تسجيل خروج من الحساب
- `4647` - تسجيل خروج بمبادرة من المستخدم
- `4648` - تسجيل دخول صريح
- `4672` - تسجيل دخول المسؤول

يسهّل هذا اكتشاف الحركة الجانبية، وتخمين/رش كلمات المرور، وتصعيد الامتيازات، وما إلى ذلك...

* المدخلات: JSONL
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرجات: CSV

الخيارات المطلوبة:

- `-o, --output <CSV-FILE>`: ملف CSV لحفظ النتائج فيه.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الخط الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL

الخيارات:

- `-c, --calculateElapsedTime`: حساب الوقت المنقضي لعمليات تسجيل الدخول الناجحة. (الافتراضي: `true`)
- `-l, --outputLogoffEvents`: إخراج أحداث تسجيل الخروج كإدخالات منفصلة. (الافتراضي: `false`)
- `-a, --outputAdminLogonEvents`: إخراج أحداث تسجيل دخول المسؤول كإدخالات منفصلة. (الافتراضي: `false`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `timeline-logon`

تجهيز خط زمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

حفظ الخط الزمني لتسجيل الدخول في ملف CSV:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### لقطة شاشة `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## أمر `timeline-partition-diagnostic`

ينشئ خطًا زمنيًا بصيغة CSV لأحداث تشخيص الأقسام عن طريق تحليل ملفات `Microsoft-Windows-Partition%4Diagnostic.evtx` الخاصة بنظام Windows 10، ويبلّغ عن معلومات حول جميع الأجهزة المتصلة وأرقامها التسلسلية للوحدات التخزينية (Volume Serial Numbers)، سواء الموجودة حاليًا على الجهاز أو التي كانت موجودة سابقًا.
تستند هذه العملية إلى الأداة [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* المدخلات: JSONL
* الملف التعريفي: أي
* المخرجات: الطرفية أو CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الخط الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL

الخيارات:

- `-o, --output <CSV-FILE>`: ملف CSV لحفظ النتائج فيه.
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `timeline-partition-diagnostic`

تجهيز خط زمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

إنشاء خط زمني بصيغة CSV للأجهزة المتصلة:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## أمر `timeline-suspicious-processes`

إنشاء خط زمني بصيغة CSV للعمليات المشبوهة.

* المدخلات: JSONL
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرجات: الطرفية أو CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الخط الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL
- `-o, --output <CSV-FILE>`: ملف CSV لحفظ النتائج فيه (الافتراضي: `stdout`)

الخيارات:

- `-l, --level <LEVEL>`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `high`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `timeline-suspicious-processes`

تجهيز خط زمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

البحث عن العمليات التي كان مستوى تنبيهها `high` أو أعلى وإخراج النتائج إلى الشاشة:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

البحث عن العمليات التي كان مستوى تنبيهها `low` أو أعلى وإخراج النتائج إلى الشاشة:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

حفظ النتائج في ملف CSV:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### لقطة شاشة `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## أمر `timeline-tasks`

سيقوم هذا الأمر بتجميع المهام المجدولة الجديدة من أحداث Security 4698 وتحليل محتوى المهمة بصيغة XML.

* المدخلات: JSONL
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرجات: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الخط الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL

الخيارات:

- `-o, --output <CSV-FILE>`: ملف CSV لحفظ النتائج فيه.
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `timeline-tasks`

الإخراج إلى الطرفية:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

الحفظ بصيغة CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

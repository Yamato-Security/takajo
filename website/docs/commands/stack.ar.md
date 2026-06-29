# أوامر التكديس (Stack)

## أمر `stack-cmdlines`

سيقوم هذا الأمر بتكديس سطور الأوامر المنفّذة عن طريق استخراج المعلومات من أحداث `Sysmon 1` و`Security 4688`.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-y, --ignoreSysmon`: استبعاد أحداث Sysmon 1 (الافتراضي: `false`)
- `-e, --ignoreSecurity`: استبعاد أحداث Security 4688 (الافتراضي: `false`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-cmdlines`

الإخراج إلى الطرفية:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## أمر `stack-computers`

سيقوم هذا الأمر بتكديس أسماء مضيفي أجهزة الحاسوب وفقًا لحقل `Computer`.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-c, --sourceComputers`: تكديس أجهزة الحاسوب المصدر بدلاً من أجهزة الحاسوب الهدف (الافتراضي: false)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-computers`

الإخراج إلى الطرفية:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## أمر `stack-dns`

سيقوم هذا الأمر بتكديس استعلامات DNS واستجاباتها من أحداث Sysmon 22.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-dns`

الإخراج إلى الطرفية:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## أمر `stack-ip-addresses`

سيقوم هذا الأمر بتكديس عناوين IP الهدف (حقل `TgtIP`) أو عناوين IP المصدر (حقل `SrcIP`).

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-a, --targetIpAddresses`: تكديس عناوين IP الهدف بدلاً من عناوين IP المصدر (الافتراضي: `false`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-ip-addresses`

الإخراج إلى الطرفية:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## أمر `stack-logons`

ينشئ قائمة بعمليات تسجيل الدخول وفقًا لـ `Target User` و`Target Computer` و`Logon Type` و`Source IP Address` و`Source Computer`.
تتم تصفية النتائج بشكل افتراضي عندما يكون عنوان IP المصدر عنوان IP محلي.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --localSrcIpAddresses`: تضمين النتائج عندما يكون عنوان IP المصدر محليًا.
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-logons`

التشغيل بالإعدادات الافتراضية:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

تضمين عمليات تسجيل الدخول المحلية:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## أمر `stack-processes`

سيقوم هذا الأمر بتكديس العمليات المنفّذة من أحداث Sysmon 1 وSecurity 4688.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `low`)
- `-y, --ignoreSysmon`: استبعاد أحداث Sysmon 1 (الافتراضي: `false`)
- `-e, --ignoreSecurity`: استبعاد أحداث Security 4688 (الافتراضي: `false`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-processes`

الإخراج إلى الطرفية:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## أمر `stack-services`

سيقوم هذا الأمر بتكديس أسماء الخدمات ومساراتها من أحداث System 7040 وSecurity 4697.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-y, --ignoreSystem`: استبعاد أحداث System 7040 (الافتراضي: `false`)
- `-e, --ignoreSecurity`: استبعاد أحداث Security 4697 (الافتراضي: `false`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-services`

الإخراج إلى الطرفية:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## أمر `stack-tasks`

سيقوم هذا الأمر بتكديس المهام المجدولة الجديدة من أحداث Security 4698 وتحليل محتوى مهمة XML.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-tasks`

الإخراج إلى الطرفية:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## أمر `stack-users`

سيقوم هذا الأمر بتكديس المستخدمين الهدف (حقل `TgtUser` (الافتراضي)) أو المستخدمين المصدر (حقل `SrcUser`) في أي حدث يحتوي على تلك الحقول بالإضافة إلى عرض معلومات التنبيه.

* الإدخال: JSONL
* الملف الشخصي: أي ملف باستثناء `all-field-info` و`all-field-info-verbose`
* الإخراج: الطرفية أو ملف CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل يحتوي على ملفات JSONL

الخيارات:

- `-s, --sourceUsers`: تكديس المستخدمين المصدر بدلاً من المستخدمين الهدف (الافتراضي: false)
- `-c, --filterComputerAccounts`: تصفية حسابات أجهزة الحاسوب (الافتراضي: true)
- `-f, --filterSystemAccounts`: تصفية حسابات النظام (الافتراضي: true)
- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `informational`)
- `-o, --output <CSV-FILE>`: ملف CSV الذي سيتم حفظ النتائج فيه (الافتراضي: `stdout`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `stack-users`

الإخراج إلى الطرفية:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

الحفظ في ملف CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

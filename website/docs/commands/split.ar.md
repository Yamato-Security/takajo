# أوامر التقسيم

## أمر `split-csv-timeline`

تقسيم جدول زمني كبير بصيغة CSV إلى جداول أصغر بناءً على اسم الحاسوب.

* المدخلات: CSV غير متعدد الأسطر
* الملف الشخصي: أي
* المخرجات: ملفات CSV متعددة

الخيارات المطلوبة:

- `-t, --timeline <CSV-FILE>`: جدول زمني بصيغة CSV تم إنشاؤه بواسطة Hayabusa.

الخيارات:

- `-m, --makeMultiline`: إخراج الحقول في أسطر متعددة. (الافتراضي: `false`)
- `-o, --output <DIR>`: المجلد الذي تُحفظ فيه ملفات CSV. (الافتراضي: `output`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `split-csv-timeline`

تجهيز الجدول الزمني بصيغة CSV باستخدام Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

تقسيم الجدول الزمني الواحد بصيغة CSV إلى جداول زمنية متعددة بصيغة CSV في المجلد الافتراضي `output`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

فصل معلومات الحقول باستخدام أحرف الأسطر الجديدة لإنشاء إدخالات متعددة الأسطر وحفظها في المجلد `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## أمر `split-json-timeline`

تقسيم جدول زمني كبير بصيغة JSONL إلى جداول أصغر بناءً على اسم الحاسوب.

* المدخلات: JSONL
* الملف الشخصي: أي
* المخرجات: ملفات JSONL متعددة

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو مجلد الجدول الزمني بصيغة JSONL الخاص بـ Hayabusa.

الخيارات:

- `-o, --output <DIR>`: المجلد الذي تُحفظ فيه ملفات JSONL. (الافتراضي: `output`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `split-json-timeline`

تجهيز الجدول الزمني بصيغة JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

تقسيم الجدول الزمني الواحد بصيغة JSONL إلى جداول زمنية متعددة بصيغة JSONL في المجلد الافتراضي `output`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

الحفظ في المجلد `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

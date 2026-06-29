# أوامر الأتمتة

## أمر `automagic`

ينفّذ تلقائيًا أكبر عدد ممكن من الأوامر ويُخرج النتائج إلى مجلد جديد

> ملاحظة: يجب عليك استخدام الملف التعريفي `verbose` أو `super-verbose` للاستفادة من جميع الأوامر.

* المدخلات: ملف JSONL أو دليل يحتوي على ملفات JSONL
* الملف التعريفي: أي ملف باستثناء `all-field-info` و `all-field-info-verbose`
* المخرجات: مجلد جديد يحتوي على جميع النتائج في ملفات مختلفة

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو دليل الخط الزمني بصيغة JSONL الخاص بـ Hayabusa.

الخيارات:

- `-d, --displayTable`: عرض جدول النتائج (الافتراضي: `false`)
- `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `low`)
- `-o, --output`: دليل المخرجات (الافتراضي: `case-1`)
- `-q, --quiet`: عدم عرض شعار البدء (الافتراضي: `false`)
- `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### أمثلة على أمر `automagic`

جهّز الخط الزمني بصيغة JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

شغّل أكبر عدد ممكن من أوامر Takajo واحفظ النتائج ضمن المجلد `case-1`:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

شغّل أكبر عدد ممكن من أوامر Takajo على الدليل `hayabusa-results` واحفظ النتائج ضمن المجلد `case-1`:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

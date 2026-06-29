# أوامر HTML

## أمر `html-report`

إنشاء تقارير ملخصة بصيغة HTML للقواعد وأجهزة الحاسوب التي تحتوي على اكتشافات.
يقوم هذا الأمر أولاً بإنشاء ملف قاعدة بيانات DuckDB مفهرس (افتراضي) أو ملف قاعدة بيانات SQLite بهدف إجراء عمليات بحث سريعة على البيانات اللازمة لإنشاء التقارير الملخصة.

* المدخل: JSONL
* الملف الشخصي: أي ملف شخصي مفصّل
* المخرج: تقارير HTML ملخصة فردية بناءً على اسم الحاسوب بالإضافة إلى صفحة رئيسية `index.html`

الخيارات المطلوبة:

- `-o, --output`: اسم دليل تقرير html
- `-r, --rulepath`: المسار إلى دليل قواعد Hayabusa
- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو دليل الخط الزمني JSONL الخاص بـ Hayabusa

الخيارات:

- `-C, --clobber`: الكتابة فوق ملف قاعدة البيانات عند الحفظ (افتراضي: `false`)
- `-q, --quiet`: عدم عرض شعار الإطلاق (افتراضي: `false`)
- `-s, --dboutput`: حفظ النتائج في ملف قاعدة بيانات (افتراضي: `html-report.duckdb` أو `html-report.sqlite` مع `--sqlite`)
- `--skipProgressBar`: عدم عرض شريط التقدم (افتراضي: `false`)
- `--sqlite`: استخدام الواجهة الخلفية SQLite بدلاً من DuckDB (افتراضي: `false`)

### مثال على أمر `html-report`

تحضير الخط الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

أو

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

إنشاء تقارير HTML الملخصة:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### لقطات شاشة `html-report`

#### ملخص القاعدة

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### ملخص الحاسوب

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### قائمة القواعد

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## أمر `html-server`

إنشاء خادم ويب ديناميكي لعرض تقارير HTML الملخصة.
يقوم هذا الأمر أولاً بإنشاء ملف قاعدة بيانات DuckDB مفهرس (افتراضي) أو ملف قاعدة بيانات SQLite بهدف إجراء عمليات بحث سريعة على البيانات اللازمة لإنشاء التقارير الملخصة.
وهو مشابه لأمر `html-report` لكنه أكثر قابلية للتوسع ويتيح التصفية حسب التواريخ والقواعد.

* المدخل: JSONL
* الملف الشخصي: أي ملف شخصي مفصّل
* المخرج: بشكل افتراضي، سيستمع على `http://localhost:8823`

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو دليل الخط الزمني JSONL الخاص بـ Hayabusa

الخيارات:

- `-C, --clobber`: الكتابة فوق ملف قاعدة البيانات عند الحفظ (افتراضي: `false`)
- `-p, --port`: رقم منفذ خادم الويب (افتراضي: `8823`)
- `-q, --quiet`: عدم عرض شعار الإطلاق (افتراضي: `false`)
- `-r, --rulepath`: المسار إلى دليل قواعد Hayabusa (هذا اختياري لكنه ضروري لإنشاء روابط صحيحة إلى ملفات القواعد)
- `-s, --dboutput`: حفظ النتائج في ملف قاعدة بيانات (افتراضي: `html-report.duckdb` أو `html-report.sqlite` مع `--sqlite`)
- `--skipProgressBar`: عدم عرض شريط التقدم (افتراضي: `false`)
- `--sqlite`: استخدام الواجهة الخلفية SQLite بدلاً من DuckDB (افتراضي: `false`)

### مثال على أمر `html-report`

تحضير الخط الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

أو

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

تشغيل خادم الويب:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### لقطات شاشة `html-server`

#### قائمة القواعد

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### ملخص الحاسوب

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### تصفية القواعد

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### تصفية القواعد

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

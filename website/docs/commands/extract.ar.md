# أوامر الاستخراج

## أمر `extract-scriptblocks`

يستخرج ويعيد تجميع سجلات كتل البرامج النصية PowerShell EID 4104.

> ملاحظة: من الأفضل فتح برامج PowerShell النصية كملفات `.ps1` مع تمييز بناء جملة الشيفرة، لكننا نستخدم الامتداد `.txt` لمنع أي تشغيل عرضي لشيفرة ضارة.

* المدخلات: JSONL
* الملف الشخصي: أي
* المخرجات: الطرفية ودليل برامج PowerShell النصية

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف أو دليل الجدول الزمني JSONL الخاص بـ Hayabusa

الخيارات:

 - `-l, --level`: تحديد الحد الأدنى لمستوى التنبيه (الافتراضي: `low`)
 - `-o, --output`: دليل المخرجات (الافتراضي: `scriptblock-logs`)
 - `-q, --quiet`: عدم عرض شعار الإطلاق (الافتراضي: `false`)
 - `-s, --skipProgressBar`: عدم عرض شريط التقدم (الافتراضي: `false`)

### مثال على أمر `extract-scriptblocks`

جهّز الجدول الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

استخرج سجلات كتل البرامج النصية PowerShell EID 4104 إلى الدليل `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### لقطة شاشة `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

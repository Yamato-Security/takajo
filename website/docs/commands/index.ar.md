# قائمة الأوامر

## أوامر الأتمتة
* `automagic`: ينفذ تلقائيًا أكبر عدد ممكن من الأوامر ويخرج النتائج إلى مجلد جديد

## أوامر الاستخراج
* `extract-scriptblocks`: استخراج وإعادة تجميع سجلات كتل البرامج النصية PowerShell EID 4104

## أوامر HTML
* `html-report`: إنشاء تقارير ملخص HTML ثابتة
* `html-server`: إنشاء خادم ويب ديناميكي لعرض تقارير ملخص HTML

## أوامر القوائم
* `list-domains`: إنشاء قائمة بالنطاقات الفريدة لاستخدامها مع `vt-domain-lookup`
* `list-hashes`: إنشاء قائمة بقيم تجزئة العمليات لاستخدامها مع `vt-hash-lookup`
* `list-ip-addresses`: إنشاء قائمة بعناوين IP الهدف و/أو المصدر الفريدة لاستخدامها مع `vt-ip-lookup`
* `list-undetected-evtx`: إنشاء قائمة بملفات evtx غير المكتشفة
* `list-unused-rules`: إنشاء قائمة بقواعد الكشف غير المستخدمة

## أوامر التقسيم
* `split-csv-timeline`: تقسيم مخطط زمني CSV كبير إلى مخططات أصغر بناءً على اسم الحاسوب
* `split-json-timeline`: تقسيم مخطط زمني JSONL كبير إلى مخططات أصغر بناءً على اسم الحاسوب

## أوامر التكديس
* `stack-cmdlines`: تكديس سطور الأوامر المنفذة
* `stack-computers`: تكديس الحواسيب
* `stack-dns`: تكديس استعلامات DNS واستجاباتها
* `stack-ip-addresses`: تكديس عناوين IP الهدف (حقل `TgtIP`) أو عناوين IP المصدر (حقل `SrcIP`)
* `stack-logons`: تكديس عمليات تسجيل الدخول حسب المستخدم الهدف والحاسوب الهدف وعنوان IP المصدر والحاسوب المصدر
* `stack-processes`: تكديس العمليات المنفذة
* `stack-services`: تكديس أسماء الخدمات ومساراتها من أحداث `System 7040` و`Security 4697`
* `stack-tasks`: تكديس المهام المجدولة الجديدة من أحداث `Security 4698` وتحليل محتوى المهمة XML
* `stack-users`: تكديس المستخدمين الهدف (حقل `TgtUser`) أو المستخدمين المصدر (حقل `SrcUser`)

## أوامر Sysmon
* `sysmon-process-tree`: إخراج شجرة العمليات لعملية معينة

## أوامر المخطط الزمني
* `timeline-logon`: إنشاء مخطط زمني CSV لأحداث تسجيل الدخول
* `timeline-partition-diagnostic`: إنشاء مخطط زمني CSV لأحداث تشخيص الأقسام
* `timeline-suspicious-processes`: إنشاء مخطط زمني CSV للعمليات المشبوهة
* `timeline-tasks`: إنشاء مخطط زمني CSV للمهام المجدولة

## أوامر TTP
* `ttp-summary`: تلخيص التكتيكات والتقنيات الموجودة في كل حاسوب
* `ttp-visualize`: استخراج TTPs وإنشاء ملف JSON لعرضه بصريًا في MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: استخراج TTPs من قواعد Sigma وإنشاء ملف JSON لعرضه بصريًا في MITRE ATT&CK Navigator

## أوامر VirusTotal
* `vt-domain-lookup`: البحث عن قائمة من النطاقات على VirusTotal والإبلاغ عن الضارة منها
* `vt-hash-lookup`: البحث عن قائمة من قيم التجزئة على VirusTotal والإبلاغ عن الضارة منها
* `vt-ip-lookup`: البحث عن قائمة من عناوين IP على VirusTotal والإبلاغ عن الضارة منها

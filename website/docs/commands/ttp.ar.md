# أوامر TTP

## أمر `ttp-summary`

يلخص هذا الأمر التكتيكات والتقنيات الموجودة في كل حاسوب وفقًا لـ MITRE ATT&CK TTPs المحددة في حقل `tags` في قواعد sigma.

* الإدخال: JSONL
* الملف الشخصي: ملف شخصي يُخرج حقلي `%MitreTactics%` و`%MitreTags%`. (مثال: `verbose`, `all-field-info-verbose`, `super-verbose`)
* الإخراج: الطرفية أو CSV

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL

الخيارات:

- `-o, --output <CSV-FILE>`: ملف CSV لحفظ النتائج فيه.
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `ttp-summary`

تحضير الجدول الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

طباعة ملخص TTP إلى الطرفية:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

حفظ النتائج في ملف CSV:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### لقطة شاشة `ttp-summary`

![ttp-summary](../assets/screenshots/ttp-summary.png)

## أمر `ttp-visualize`

يستخرج هذا الأمر TTPs وينشئ ملف JSON لعرضه في [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* الإدخال: JSONL
* الملف الشخصي: ملف شخصي يُخرج حقلي `%MitreTactics%` و`%MitreTags%`. (مثال: `verbose`, `all-field-info-verbose`, `super-verbose`)
* الإخراج: JSON

الخيارات المطلوبة:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ملف الجدول الزمني JSONL الخاص بـ Hayabusa أو دليل ملفات JSONL

الخيارات:

- `-o, --output <JSON-FILE>`: ملف JSON لحفظ النتائج فيه. (الافتراضي: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `ttp-visualize`

تحضير الجدول الزمني JSONL باستخدام Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

استخراج TTPs وحفظها في `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

افتح [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/)، وانقر على `Open Existing Layer` وقم بتحميل ملف JSON المحفوظ.

### لقطة شاشة `ttp-visualize`

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## أمر `ttp-visualize-sigma`

يستخرج هذا الأمر TTPs من Sigma وينشئ ملف JSON لعرضه في [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* الإدخال: دليل قواعد Sigma
* الإخراج: JSON

الخيارات المطلوبة:

- `-r, --ruleDir <SIGMA-DIR>`: دليل قواعد Sigma

الخيارات:

- `-o, --output <JSON-FILE>`: ملف JSON لحفظ النتائج فيه. (الافتراضي: `mitre-attack-navigator.json`)
- `-q, --quiet`: عدم عرض الشعار. (الافتراضي: `false`)

### أمثلة على أمر `ttp-visualize-sigma`

استنساخ مستودع Sigma:

```
git clone https://github.com/SigmaHQ/sigma.git
```

استخراج TTPs من Sigma وحفظها في `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

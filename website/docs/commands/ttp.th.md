# คำสั่ง TTP

## คำสั่ง `ttp-summary`

คำสั่งนี้สรุปกลยุทธ์ (tactics) และเทคนิค (techniques) ที่พบในแต่ละคอมพิวเตอร์ตาม MITRE ATT&CK TTPs ที่กำหนดไว้ในฟิลด์ `tags` ของกฎ sigma

* อินพุต: JSONL
* โปรไฟล์: โปรไฟล์ที่แสดงผลฟิลด์ `%MitreTactics%` และ `%MitreTags%` (ตัวอย่าง: `verbose`, `all-field-info-verbose`, `super-verbose`)
* เอาต์พุต: เทอร์มินัลหรือ CSV

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ตัวเลือก:

- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะใช้บันทึกผลลัพธ์
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `ttp-summary`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

แสดงสรุป TTP ไปยังเทอร์มินัล:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

บันทึกผลลัพธ์ไปยังไฟล์ CSV:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### ภาพหน้าจอ `ttp-summary`

![ttp-summary](../assets/screenshots/ttp-summary.png)

## คำสั่ง `ttp-visualize`

คำสั่งนี้แยก TTPs ออกมาและสร้างไฟล์ JSON เพื่อแสดงผลใน [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)

* อินพุต: JSONL
* โปรไฟล์: โปรไฟล์ที่แสดงผลฟิลด์ `%MitreTactics%` และ `%MitreTags%` (ตัวอย่าง: `verbose`, `all-field-info-verbose`, `super-verbose`)
* เอาต์พุต: JSON

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ตัวเลือก:

- `-o, --output <JSON-FILE>`: ไฟล์ JSON ที่จะใช้บันทึกผลลัพธ์ (ค่าเริ่มต้น: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `ttp-visualize`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

แยก TTPs ออกมาและบันทึกไปยัง `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

เปิด [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), คลิก `Open Existing Layer` และอัปโหลดไฟล์ JSON ที่บันทึกไว้

### ภาพหน้าจอ `ttp-visualize`

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## คำสั่ง `ttp-visualize-sigma`

คำสั่งนี้แยก TTPs ออกมาจาก Sigma และสร้างไฟล์ JSON เพื่อแสดงผลใน [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)

* อินพุต: ไดเรกทอรีกฎ Sigma
* เอาต์พุต: JSON

ตัวเลือกที่จำเป็น:

- `-r, --ruleDir <SIGMA-DIR>`: ไดเรกทอรีกฎ Sigma

ตัวเลือก:

- `-o, --output <JSON-FILE>`: ไฟล์ JSON ที่จะใช้บันทึกผลลัพธ์ (ค่าเริ่มต้น: `mitre-attack-navigator.json`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `ttp-visualize-sigma`

โคลนที่เก็บข้อมูล Sigma:

```
git clone https://github.com/SigmaHQ/sigma.git
```

แยก TTPs ออกมาจาก Sigma และบันทึกไปยัง `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

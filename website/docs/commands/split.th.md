# คำสั่ง Split

## คำสั่ง `split-csv-timeline`

แบ่ง CSV timeline ขนาดใหญ่ออกเป็นไฟล์ที่เล็กลงโดยอิงตามชื่อคอมพิวเตอร์

* อินพุต: CSV ที่ไม่ใช่แบบหลายบรรทัด
* โปรไฟล์: ใดก็ได้
* เอาต์พุต: ไฟล์ CSV หลายไฟล์

ตัวเลือกที่จำเป็น:

- `-t, --timeline <CSV-FILE>`: CSV timeline ที่สร้างโดย Hayabusa

ตัวเลือก:

- `-m, --makeMultiline`: แสดงผลฟิลด์ในหลายบรรทัด (ค่าเริ่มต้น: `false`)
- `-o, --output <DIR>`: ไดเรกทอรีที่จะบันทึกไฟล์ CSV (ค่าเริ่มต้น: `output`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `split-csv-timeline`

เตรียม CSV timeline ด้วย Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

แบ่ง CSV timeline เดี่ยวออกเป็น CSV timeline หลายไฟล์ในไดเรกทอรี `output` เริ่มต้น:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

แยกข้อมูลฟิลด์ด้วยอักขระขึ้นบรรทัดใหม่เพื่อสร้างรายการแบบหลายบรรทัด และบันทึกไปยังไดเรกทอรี `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## คำสั่ง `split-json-timeline`

แบ่ง JSONL timeline ขนาดใหญ่ออกเป็นไฟล์ที่เล็กลงโดยอิงตามชื่อคอมพิวเตอร์

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้
* เอาต์พุต: ไฟล์ JSONL หลายไฟล์

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์หรือไดเรกทอรี JSONL timeline ของ Hayabusa

ตัวเลือก:

- `-o, --output <DIR>`: ไดเรกทอรีที่จะบันทึกไฟล์ JSONL (ค่าเริ่มต้น: `output`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `split-json-timeline`

เตรียม JSONL timeline ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

แบ่ง JSONL timeline เดี่ยวออกเป็น JSONL timeline หลายไฟล์ในไดเรกทอรี `output` เริ่มต้น:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

บันทึกไปยังไดเรกทอรี `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

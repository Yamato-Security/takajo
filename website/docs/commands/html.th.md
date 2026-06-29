# คำสั่ง HTML

## คำสั่ง `html-report`

สร้างรายงานสรุปแบบ HTML สำหรับกฎและคอมพิวเตอร์ที่มีการตรวจจับ
คำสั่งนี้จะสร้างไฟล์ฐานข้อมูล DuckDB ที่มีการทำดัชนีก่อน (ค่าเริ่มต้น) หรือไฟล์ฐานข้อมูล SQLite เพื่อให้สามารถค้นหาข้อมูลที่จำเป็นในการสร้างรายงานสรุปได้อย่างรวดเร็ว

* อินพุต: JSONL
* โปรไฟล์: โปรไฟล์ verbose ใด ๆ
* เอาต์พุต: รายงานสรุป HTML แยกตามชื่อคอมพิวเตอร์ รวมถึงหน้าหลัก `index.html`

ตัวเลือกที่จำเป็น:

- `-o, --output`: ชื่อไดเรกทอรีของรายงาน html
- `-r, --rulepath`: พาธไปยังไดเรกทอรีกฎของ Hayabusa
- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์หรือไดเรกทอรีไทม์ไลน์ JSONL ของ Hayabusa

ตัวเลือก:

- `-C, --clobber`: เขียนทับไฟล์ฐานข้อมูลเมื่อบันทึก (ค่าเริ่มต้น: `false`)
- `-q, --quiet`: ไม่แสดงแบนเนอร์ตอนเริ่มทำงาน (ค่าเริ่มต้น: `false`)
- `-s, --dboutput`: บันทึกผลลัพธ์ลงในไฟล์ฐานข้อมูล (ค่าเริ่มต้น: `html-report.duckdb` หรือ `html-report.sqlite` เมื่อใช้ `--sqlite`)
- `--skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)
- `--sqlite`: ใช้แบ็กเอนด์ SQLite แทน DuckDB (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `html-report`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

หรือ

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

สร้างรายงานสรุป HTML:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### ภาพหน้าจอของ `html-report`

#### สรุปกฎ

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### สรุปคอมพิวเตอร์

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### รายการกฎ

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## คำสั่ง `html-server`

สร้างเว็บเซิร์ฟเวอร์แบบไดนามิกเพื่อดูรายงานสรุป HTML
คำสั่งนี้จะสร้างไฟล์ฐานข้อมูล DuckDB ที่มีการทำดัชนีก่อน (ค่าเริ่มต้น) หรือไฟล์ฐานข้อมูล SQLite เพื่อให้สามารถค้นหาข้อมูลที่จำเป็นในการสร้างรายงานสรุปได้อย่างรวดเร็ว
คล้ายกับคำสั่ง `html-report` แต่สามารถปรับขนาดได้ดีกว่าและอนุญาตให้กรองตามวันที่และกฎได้

* อินพุต: JSONL
* โปรไฟล์: โปรไฟล์ verbose ใด ๆ
* เอาต์พุต: โดยค่าเริ่มต้น จะรับฟังที่ `http://localhost:8823`

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์หรือไดเรกทอรีไทม์ไลน์ JSONL ของ Hayabusa

ตัวเลือก:

- `-C, --clobber`: เขียนทับไฟล์ฐานข้อมูลเมื่อบันทึก (ค่าเริ่มต้น: `false`)
- `-p, --port`: หมายเลขพอร์ตของเว็บเซิร์ฟเวอร์ (ค่าเริ่มต้น: `8823`)
- `-q, --quiet`: ไม่แสดงแบนเนอร์ตอนเริ่มทำงาน (ค่าเริ่มต้น: `false`)
- `-r, --rulepath`: พาธไปยังไดเรกทอรีกฎของ Hayabusa (เป็นตัวเลือกเสริมแต่จำเป็นสำหรับการสร้างลิงก์ที่ถูกต้องไปยังไฟล์กฎ)
- `-s, --dboutput`: บันทึกผลลัพธ์ลงในไฟล์ฐานข้อมูล (ค่าเริ่มต้น: `html-report.duckdb` หรือ `html-report.sqlite` เมื่อใช้ `--sqlite`)
- `--skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)
- `--sqlite`: ใช้แบ็กเอนด์ SQLite แทน DuckDB (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `html-report`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

หรือ

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

เริ่มเว็บเซิร์ฟเวอร์:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### ภาพหน้าจอของ `html-server`

#### รายการกฎ

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### สรุปคอมพิวเตอร์

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### การกรองกฎ

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### การกรองกฎ

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

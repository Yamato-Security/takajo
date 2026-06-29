# คำสั่ง Timeline

## คำสั่ง `timeline-logon`

คำสั่งนี้จะดึงข้อมูลจากเหตุการณ์การล็อกออน (logon) ต่อไปนี้ ปรับฟิลด์ให้เป็นมาตรฐาน และบันทึกผลลัพธ์ลงในไฟล์ CSV:

- `4624` - Successful Logon
- `4625` - Failed Logon
- `4634` - Account Logoff
- `4647` - User Initiated Logoff
- `4648` - Explicit Logon
- `4672` - Admin Logon

สิ่งนี้ทำให้ตรวจจับการเคลื่อนที่ในแนวข้าง (lateral movement), การเดา/พ่นรหัสผ่าน (password guessing/spraying), การยกระดับสิทธิ์ (privilege escalation) ฯลฯ ได้ง่ายขึ้น...

* Input: JSONL
* Profile: ใดก็ได้ ยกเว้น `all-field-info` และ `all-field-info-verbose`
* Output: CSV

ตัวเลือกที่จำเป็น:

- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป
- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ตัวเลือก:

- `-c, --calculateElapsedTime`: คำนวณเวลาที่ผ่านไปสำหรับการล็อกออนที่สำเร็จ (ค่าเริ่มต้น: `true`)
- `-l, --outputLogoffEvents`: แสดงเหตุการณ์การล็อกออฟเป็นรายการแยกต่างหาก (ค่าเริ่มต้น: `false`)
- `-a, --outputAdminLogonEvents`: แสดงเหตุการณ์การล็อกออนของผู้ดูแลระบบเป็นรายการแยกต่างหาก (ค่าเริ่มต้น: `false`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `timeline-logon`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

บันทึกไทม์ไลน์การล็อกออนลงในไฟล์ CSV:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### ภาพหน้าจอ `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## คำสั่ง `timeline-partition-diagnostic`

สร้างไทม์ไลน์ CSV ของเหตุการณ์การวินิจฉัยพาร์ติชัน (partition diagnostic) โดยการแยกวิเคราะห์ไฟล์ `Microsoft-Windows-Partition%4Diagnostic.evtx` ของ Windows 10 และรายงานข้อมูลเกี่ยวกับอุปกรณ์ที่เชื่อมต่อทั้งหมดและหมายเลขซีเรียลของวอลุ่ม (Volume Serial Numbers) ทั้งที่มีอยู่บนอุปกรณ์ในปัจจุบันและที่เคยมีอยู่ก่อนหน้านี้
กระบวนการนี้อ้างอิงจากเครื่องมือ [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser)

* Input: JSONL
* Profile: ใดก็ได้
* Output: เทอร์มินัลหรือ CSV

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ตัวเลือก:

- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `timeline-partition-diagnostic`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

สร้างไทม์ไลน์ CSV ของอุปกรณ์ที่เชื่อมต่อ:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## คำสั่ง `timeline-suspicious-processes`

สร้างไทม์ไลน์ CSV ของกระบวนการที่น่าสงสัย

* Input: JSONL
* Profile: ใดก็ได้ ยกเว้น `all-field-info` และ `all-field-info-verbose`
* Output: เทอร์มินัลหรือ CSV

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)

ตัวเลือก:

- `-l, --level <LEVEL>`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `high`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `timeline-suspicious-processes`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

ค้นหากระบวนการที่มีระดับการแจ้งเตือนเป็น `high` หรือสูงกว่า และแสดงผลลัพธ์ออกทางหน้าจอ:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

ค้นหากระบวนการที่มีระดับการแจ้งเตือนเป็น `low` หรือสูงกว่า และแสดงผลลัพธ์ออกทางหน้าจอ:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

บันทึกผลลัพธ์ลงในไฟล์ CSV:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### ภาพหน้าจอ `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## คำสั่ง `timeline-tasks`

คำสั่งนี้จะรวบรวมงานที่กำหนดเวลาไว้ (scheduled tasks) ใหม่จากเหตุการณ์ Security 4698 และแยกวิเคราะห์เนื้อหางานที่เป็น XML ออกมา

* Input: JSONL
* Profile: ใดก็ได้ ยกเว้น `all-field-info` และ `all-field-info-verbose`
* Output: เทอร์มินัลหรือไฟล์ CSV

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ตัวเลือก:

- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `timeline-tasks`

แสดงผลออกทางเทอร์มินัล:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

บันทึกลงใน CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

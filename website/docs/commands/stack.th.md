# คำสั่ง Stack

## คำสั่ง `stack-cmdlines`

คำสั่งนี้จะทำการ stack คอมมานด์ไลน์ที่ถูกเรียกใช้ โดยดึงข้อมูลจากอีเวนต์ `Sysmon 1` และ `Security 4688`

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-y, --ignoreSysmon`: ยกเว้นอีเวนต์ Sysmon 1 (ค่าเริ่มต้น: `false`)
- `-e, --ignoreSecurity`: ยกเว้นอีเวนต์ Security 4688 (ค่าเริ่มต้น: `false`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-cmdlines`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## คำสั่ง `stack-computers`

คำสั่งนี้จะทำการ stack ชื่อโฮสต์ของคอมพิวเตอร์ตามฟิลด์ `Computer`

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-c, --sourceComputers`: stack คอมพิวเตอร์ต้นทางแทนคอมพิวเตอร์ปลายทาง (ค่าเริ่มต้น: false)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-computers`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## คำสั่ง `stack-dns`

คำสั่งนี้จะทำการ stack คำสั่งสอบถาม DNS และการตอบกลับจากอีเวนต์ Sysmon 22

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-dns`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## คำสั่ง `stack-ip-addresses`

คำสั่งนี้จะทำการ stack ที่อยู่ IP ปลายทาง (ฟิลด์ `TgtIP`) หรือที่อยู่ IP ต้นทาง (ฟิลด์ `SrcIP`)

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-a, --targetIpAddresses`: stack ที่อยู่ IP ปลายทางแทนที่อยู่ IP ต้นทาง (ค่าเริ่มต้น: `false`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-ip-addresses`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## คำสั่ง `stack-logons`

สร้างรายการการล็อกออนตาม `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`
ผลลัพธ์จะถูกกรองออกเมื่อที่อยู่ IP ต้นทางเป็นที่อยู่ IP ภายในเครื่องตามค่าเริ่มต้น

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --localSrcIpAddresses`: รวมผลลัพธ์เมื่อที่อยู่ IP ต้นทางเป็นภายในเครื่อง
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-logons`

รันด้วยการตั้งค่าเริ่มต้น:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

รวมการล็อกออนภายในเครื่อง:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## คำสั่ง `stack-processes`

คำสั่งนี้จะทำการ stack โปรเซสที่ถูกเรียกใช้จากอีเวนต์ Sysmon 1 และ Security 4688

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `low`)
- `-y, --ignoreSysmon`: ยกเว้นอีเวนต์ Sysmon 1 (ค่าเริ่มต้น: `false`)
- `-e, --ignoreSecurity`: ยกเว้นอีเวนต์ Security 4688 (ค่าเริ่มต้น: `false`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-processes`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## คำสั่ง `stack-services`

คำสั่งนี้จะทำการ stack ชื่อเซอร์วิสและพาธจากอีเวนต์ System 7040 และ Security 4697

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-y, --ignoreSystem`: ยกเว้นอีเวนต์ System 7040 (ค่าเริ่มต้น: `false`)
- `-e, --ignoreSecurity`: ยกเว้นอีเวนต์ Security 4697 (ค่าเริ่มต้น: `false`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-services`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## คำสั่ง `stack-tasks`

คำสั่งนี้จะทำการ stack งานตามกำหนดเวลา (scheduled tasks) ใหม่จากอีเวนต์ Security 4698 และแยกวิเคราะห์เนื้อหางานแบบ XML ออกมา

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-tasks`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## คำสั่ง `stack-users`

คำสั่งนี้จะทำการ stack ผู้ใช้ปลายทาง (ฟิลด์ `TgtUser` (ค่าเริ่มต้น)) หรือผู้ใช้ต้นทาง (ฟิลด์ `SrcUser`) ในอีเวนต์ใด ๆ ที่มีฟิลด์เหล่านั้น พร้อมทั้งแสดงข้อมูลการแจ้งเตือนด้วย

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้นอกเหนือจาก `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ CSV

ออปชันที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ออปชัน:

- `-s, --sourceUsers`: stack ผู้ใช้ต้นทางแทนผู้ใช้ปลายทาง (ค่าเริ่มต้น: false)
- `-c, --filterComputerAccounts`: กรองบัญชีคอมพิวเตอร์ออก (ค่าเริ่มต้น: true)
- `-f, --filterSystemAccounts`: กรองบัญชีระบบออก (ค่าเริ่มต้น: true)
- `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `informational`)
- `-o, --output <CSV-FILE>`: ไฟล์ CSV ที่จะบันทึกผลลัพธ์ลงไป (ค่าเริ่มต้น: `stdout`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
- `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `stack-users`

เอาต์พุตไปยังเทอร์มินัล:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

บันทึกเป็น CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

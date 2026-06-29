# คำสั่ง Extract

## คำสั่ง `extract-scriptblocks`

แยกและประกอบกลับบันทึก script block ของ PowerShell EID 4104

> หมายเหตุ: สคริปต์ PowerShell เปิดดูได้ดีที่สุดในรูปแบบไฟล์ `.ps1` พร้อมการเน้นสีไวยากรณ์ของโค้ด แต่เราใช้นามสกุล `.txt` เพื่อป้องกันการรันโค้ดที่เป็นอันตรายโดยไม่ตั้งใจ

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้
* เอาต์พุต: เทอร์มินัลและไดเรกทอรีของสคริปต์ PowerShell

ตัวเลือกที่จำเป็น:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์หรือไดเรกทอรีไทม์ไลน์ JSONL ของ Hayabusa

ตัวเลือก:

 - `-l, --level`: ระบุระดับการแจ้งเตือนขั้นต่ำ (ค่าเริ่มต้น: `low`)
 - `-o, --output`: ไดเรกทอรีเอาต์พุต (ค่าเริ่มต้น: `scriptblock-logs`)
 - `-q, --quiet`: ไม่แสดงแบนเนอร์เปิดโปรแกรม (ค่าเริ่มต้น: `false`)
 - `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `extract-scriptblocks`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

แยกบันทึก script block ของ PowerShell EID 4104 ไปยังไดเรกทอรี `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### ภาพหน้าจอ `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

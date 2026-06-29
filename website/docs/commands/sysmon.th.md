# คำสั่ง Sysmon

## คำสั่ง `sysmon-process-tree`

แสดงผลแผนผังกระบวนการ (process tree) ของกระบวนการหนึ่ง ๆ เช่น กระบวนการที่น่าสงสัยหรือกระบวนการที่เป็นอันตราย

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้ ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: เทอร์มินัลหรือไฟล์ข้อความ

ตัวเลือกที่จำเป็น:

- `-p, --processGuid <Process GUID>`: sysmon process GUID
- `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL

ตัวเลือก:

- `-o, --output <TXT-FILE>`: ไฟล์ข้อความสำหรับบันทึกผลลัพธ์
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `sysmon-process-tree`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

บันทึกผลลัพธ์ลงในไฟล์ข้อความ:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### ภาพหน้าจอ `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

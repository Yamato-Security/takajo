# คำสั่ง List

## คำสั่ง `list-domains`

สร้างรายการโดเมนที่ไม่ซ้ำกันเพื่อใช้กับ `vt-domain-lookup`
ปัจจุบันจะตรวจสอบเฉพาะโดเมนที่ถูกสอบถามในล็อก Sysmon EID 22 เท่านั้น แต่จะได้รับการอัปเดตให้รองรับล็อก Windows DNS Client และ Server ที่มีในตัว

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: ไฟล์ข้อความ

ตัวเลือกที่จำเป็น:

 - `-o, --output <TXT-FILE>`: บันทึกผลลัพธ์ลงในไฟล์ข้อความ
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์หรือไดเรกทอรีไทม์ไลน์ JSONL ของ Hayabusa

ตัวเลือก:

 - `-s, --includeSubdomains`: รวมโดเมนย่อย (ค่าเริ่มต้น: `false`)
 - `-w, --includeWorkstations`: รวมชื่อเวิร์กสเตชันในเครื่อง (ค่าเริ่มต้น: `false`)
 - `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
 - `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `list-domains`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

บันทึกผลลัพธ์ลงในไฟล์ข้อความ:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

รวมโดเมนย่อย:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## คำสั่ง `list-hashes`

สร้างรายการแฮชของโพรเซสเพื่อใช้กับ vt-hash-lookup (อินพุต: JSONL, โปรไฟล์: standard)

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: ไฟล์ข้อความ

ตัวเลือกที่จำเป็น:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์ไทม์ไลน์ JSONL ของ Hayabusa หรือไดเรกทอรีของไฟล์ JSONL
 - `-o, --output <BASE-NAME>`: ระบุชื่อฐานสำหรับบันทึกผลลัพธ์ข้อความ

ตัวเลือก:

 - `-l, --level`: ระบุระดับขั้นต่ำ (ค่าเริ่มต้น: `high`)
 - `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
 - `-s, --skipProgressBar`: ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `list-hashes`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

บันทึกผลลัพธ์ลงในไฟล์ข้อความที่แตกต่างกันสำหรับแฮชแต่ละประเภท:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

ตัวอย่างเช่น หากแฮช `MD5`, `SHA1` และ `IMPHASH` ถูกจัดเก็บไว้ในล็อก sysmon ไฟล์ต่อไปนี้จะถูกสร้างขึ้น: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## คำสั่ง `list-ip-addresses`

สร้างรายการที่อยู่ IP ปลายทางและ/หรือต้นทางที่ไม่ซ้ำกันเพื่อใช้กับ `vt-ip-lookup`
มันจะดึงฟิลด์ `TgtIP` สำหรับที่อยู่ IP ปลายทาง และฟิลด์ `SrcIP` สำหรับที่อยู่ IP ต้นทางในผลลัพธ์ทั้งหมด และส่งออกเฉพาะที่อยู่ IP ที่ไม่ซ้ำกันลงในไฟล์ข้อความ

* อินพุต: JSONL
* โปรไฟล์: ใดก็ได้ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: ไฟล์ข้อความ

ตัวเลือกที่จำเป็น:

 - `-o, --output <TXT-FILE>`: บันทึกผลลัพธ์ลงในไฟล์ข้อความ
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: ไฟล์หรือไดเรกทอรีไทม์ไลน์ JSONL ของ Hayabusa

ตัวเลือก:

 - `-i, --inbound`: รวมทราฟฟิกขาเข้า (ค่าเริ่มต้น: `true`)
 - `-O, --outbound`: รวมทราฟฟิกขาออก (ค่าเริ่มต้น: `true`)
 - `-p, --privateIp`: รวมที่อยู่ IP ส่วนตัว (ค่าเริ่มต้น: `false`)
 - `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)
 - `-s, --skipProgressBar`: "ไม่แสดงแถบความคืบหน้า (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `list-ip-addresses`

เตรียมไทม์ไลน์ JSONL ด้วย Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

บันทึกผลลัพธ์ลงในไฟล์ข้อความ:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

ยกเว้นทราฟฟิกขาเข้า:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

รวมที่อยู่ IP ส่วนตัว:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## คำสั่ง `list-undetected-evtx`

แสดงรายการไฟล์ `.evtx` ทั้งหมดที่ Hayabusa ไม่มีกฎการตรวจจับ
สิ่งนี้มีไว้เพื่อใช้กับไฟล์ตัวอย่าง evtx ที่ทั้งหมดมีหลักฐานของกิจกรรมที่เป็นอันตราย เช่น ไฟล์ตัวอย่าง evtx ในที่เก็บ [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx)

* อินพุต: CSV
* โปรไฟล์: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > คุณต้องรัน Hayabusa ด้วยโปรไฟล์ที่บันทึกข้อมูลคอลัมน์ `%EvtxFile%` ก่อน และบันทึกผลลัพธ์ลงในไทม์ไลน์ CSV
  > คุณสามารถดูได้ว่า Hayabusa บันทึกคอลัมน์ใดบ้างตามโปรไฟล์ต่าง ๆ [ที่นี่](https://github.com/Yamato-Security/hayabusa#profiles)
* เอาต์พุต: เทอร์มินัลหรือไฟล์ข้อความ

ตัวเลือกที่จำเป็น:

- `-e, --evtx-dir <EVTX-DIR>`: ไดเรกทอรีของไฟล์ `.evtx` ที่คุณสแกนด้วย Hayabusa
- `-t, --timeline <CSV-FILE>`: ไทม์ไลน์ CSV ของ Hayabusa

ตัวเลือก:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: ระบุชื่อคอลัมน์ที่กำหนดเองสำหรับคอลัมน์ evtx (ค่าเริ่มต้น: ค่าเริ่มต้นของ Hayabusa คือ `EvtxFile`)
- `-o, --output <TXT-FILE>`: บันทึกผลลัพธ์ลงในไฟล์ข้อความ (ค่าเริ่มต้น: ส่งออกไปยังหน้าจอ)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `list-undetected-evtx`

เตรียมไทม์ไลน์ CSV ด้วย Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

ส่งออกผลลัพธ์ไปยังหน้าจอ:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

บันทึกผลลัพธ์ลงในไฟล์ข้อความ:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## คำสั่ง `list-unused-rules`

แสดงรายการกฎการตรวจจับ `.yml` ทั้งหมดที่ไม่ได้ตรวจจับสิ่งใดเลย
สิ่งนี้มีประโยชน์ในการช่วยพิจารณาความน่าเชื่อถือของกฎ
นั่นคือ กฎใดที่ทราบว่าสามารถค้นหากิจกรรมที่เป็นอันตรายได้ และกฎใดที่ยังไม่ได้รับการทดสอบและจำเป็นต้องมีไฟล์ตัวอย่าง `.evtx`

* อินพุต: CSV
* โปรไฟล์: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > คุณต้องรัน Hayabusa ด้วยโปรไฟล์ที่บันทึกข้อมูลคอลัมน์ `%RuleFile%` ก่อน และบันทึกผลลัพธ์ลงในไทม์ไลน์ CSV
  > คุณสามารถดูได้ว่า Hayabusa บันทึกคอลัมน์ใดบ้างตามโปรไฟล์ต่าง ๆ [ที่นี่](https://github.com/Yamato-Security/hayabusa#profiles)
* เอาต์พุต: เทอร์มินัลหรือไฟล์ข้อความ

ตัวเลือกที่จำเป็น:

- `-r, --rules-dir <DIR>`: ไดเรกทอรีของไฟล์กฎ `.yml` ที่คุณใช้กับ Hayabusa
- `-t, --timeline <CSV-FILE>`: ไทม์ไลน์ CSV ที่สร้างโดย Hayabusa

ตัวเลือก:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: ระบุชื่อคอลัมน์ที่กำหนดเองสำหรับคอลัมน์ไฟล์กฎ (ค่าเริ่มต้น: ค่าเริ่มต้นของ Hayabusa คือ `RuleFile`)
- `-o, --output <TXT-FILE>`: บันทึกผลลัพธ์ลงในไฟล์ข้อความ (ค่าเริ่มต้น: ส่งออกไปยังหน้าจอ)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `list-unused-rules`

เตรียมไทม์ไลน์ CSV ด้วย Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

ส่งออกผลลัพธ์ไปยังหน้าจอ:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

บันทึกผลลัพธ์ลงในไฟล์ข้อความ:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

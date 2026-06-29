# คำสั่ง VirusTotal

## คำสั่ง `vt-domain-lookup`

ค้นหารายการโดเมนบน VirusTotal

* อินพุต: ไฟล์ข้อความ
* โปรไฟล์: ใดก็ได้ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: CSV

ตัวเลือกที่จำเป็น:

- `-a, --apiKey <API-KEY>`: คีย์ API ของ VirusTotal ของคุณ
- `-d, --domainList <TXT-FILE>`: ไฟล์ข้อความที่มีรายการโดเมน
- `-o, --output <CSV-FILE>`: บันทึกผลลัพธ์ไปยังไฟล์ CSV

ตัวเลือก:

- `-j, --jsonOutput <JSON-FILE>`: ส่งออกการตอบกลับ JSON ทั้งหมดจาก VirusTotal ไปยังไฟล์ JSON
- `-r, --rateLimit <NUMBER>`: อัตราต่อนาทีในการส่งคำขอ (ค่าเริ่มต้น: `4`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `vt-domain-lookup`

ขั้นแรกให้สร้างรายการโดเมนด้วยคำสั่ง `list-domains`
จากนั้นค้นหาโดเมนเหล่านั้นด้วยคำสั่งต่อไปนี้:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## คำสั่ง `vt-hash-lookup`

ค้นหารายการแฮชบน VirusTotal

* อินพุต: ไฟล์ข้อความ
* โปรไฟล์: ใดก็ได้ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: CSV

ตัวเลือกที่จำเป็น:

- `-a, --apiKey <API-KEY>`: คีย์ API ของ VirusTotal ของคุณ
- `-H, --hashList <HASH-LIST>`: ไฟล์ข้อความที่มีแฮช
- `-o, --output <CSV-FILE>`: บันทึกผลลัพธ์ไปยังไฟล์ CSV

ตัวเลือก:

- `-j, --jsonOutput <JSON-FILE>`: ส่งออกการตอบกลับ JSON ทั้งหมดจาก VirusTotal ไปยังไฟล์ JSON
- `-r, --rateLimit <NUMBER>`: อัตราต่อนาทีในการส่งคำขอ (ค่าเริ่มต้น: `4`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## คำสั่ง `vt-ip-lookup`

ค้นหารายการที่อยู่ IP บน VirusTotal

* อินพุต: ไฟล์ข้อความ
* โปรไฟล์: ใดก็ได้ยกเว้น `all-field-info` และ `all-field-info-verbose`
* เอาต์พุต: CSV

ตัวเลือกที่จำเป็น:

- `-a, --apiKey <API-KEY>`: คีย์ API ของ VirusTotal ของคุณ
- `-i, --ipList <IP-ADDRESS-LIST>`: ไฟล์ข้อความที่มีที่อยู่ IP
- `-o, --output <CSV-FILE>`: บันทึกผลลัพธ์ไปยังไฟล์ CSV

ตัวเลือก:

- `-j, --jsonOutput <JSON-FILE>`: ส่งออกการตอบกลับ JSON ทั้งหมดจาก VirusTotal ไปยังไฟล์ JSON
- `-r, --rateLimit <NUMBER>`: อัตราต่อนาทีในการส่งคำขอ (ค่าเริ่มต้น: `4`)
- `-q, --quiet`: ไม่แสดงโลโก้ (ค่าเริ่มต้น: `false`)

### ตัวอย่างคำสั่ง `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

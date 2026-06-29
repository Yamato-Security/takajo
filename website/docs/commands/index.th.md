# รายการคำสั่ง

## คำสั่งสำหรับการทำงานอัตโนมัติ
* `automagic`: ดำเนินการคำสั่งให้ได้มากที่สุดเท่าที่จะทำได้โดยอัตโนมัติ และส่งผลลัพธ์ออกไปยังโฟลเดอร์ใหม่

## คำสั่งสำหรับการดึงข้อมูล
* `extract-scriptblocks`: ดึงและประกอบบันทึก PowerShell EID 4104 script block logs กลับเข้าด้วยกัน

## คำสั่ง HTML
* `html-report`: สร้างรายงานสรุปแบบ HTML ชนิดคงที่ (static)
* `html-server`: สร้างเว็บเซิร์ฟเวอร์แบบไดนามิกเพื่อดูรายงานสรุป HTML

## คำสั่งสำหรับสร้างรายการ
* `list-domains`: สร้างรายการโดเมนที่ไม่ซ้ำกันเพื่อใช้กับ `vt-domain-lookup`
* `list-hashes`: สร้างรายการแฮชของโปรเซสเพื่อใช้กับ `vt-hash-lookup`
* `list-ip-addresses`: สร้างรายการที่อยู่ IP ปลายทางและ/หรือต้นทางที่ไม่ซ้ำกันเพื่อใช้กับ `vt-ip-lookup`
* `list-undetected-evtx`: สร้างรายการไฟล์ evtx ที่ไม่ถูกตรวจพบ
* `list-unused-rules`: สร้างรายการกฎการตรวจจับที่ไม่ได้ถูกใช้งาน

## คำสั่งสำหรับการแยกข้อมูล
* `split-csv-timeline`: แยกไทม์ไลน์ CSV ขนาดใหญ่ออกเป็นไฟล์ที่เล็กลงตามชื่อคอมพิวเตอร์
* `split-json-timeline`: แยกไทม์ไลน์ JSONL ขนาดใหญ่ออกเป็นไฟล์ที่เล็กลงตามชื่อคอมพิวเตอร์

## คำสั่งสำหรับการจัดกลุ่ม (Stack)
* `stack-cmdlines`: จัดกลุ่มบรรทัดคำสั่งที่ถูกเรียกใช้งาน
* `stack-computers`: จัดกลุ่มคอมพิวเตอร์
* `stack-dns`: จัดกลุ่มการสอบถามและการตอบกลับ DNS
* `stack-ip-addresses`: จัดกลุ่มที่อยู่ IP ปลายทาง (ฟิลด์ `TgtIP`) หรือที่อยู่ IP ต้นทาง (ฟิลด์ `SrcIP`)
* `stack-logons`: จัดกลุ่มการล็อกออนตามผู้ใช้ปลายทาง คอมพิวเตอร์ปลายทาง ที่อยู่ IP ต้นทาง และคอมพิวเตอร์ต้นทาง
* `stack-processes`: จัดกลุ่มโปรเซสที่ถูกเรียกใช้งาน
* `stack-services`: จัดกลุ่มชื่อและเส้นทางของบริการจากเหตุการณ์ `System 7040` และ `Security 4697`
* `stack-tasks`: จัดกลุ่มงานตามกำหนดเวลาใหม่จากเหตุการณ์ `Security 4698` และแยกวิเคราะห์เนื้อหางานในรูปแบบ XML
* `stack-users`: จัดกลุ่มผู้ใช้ปลายทาง (ฟิลด์ `TgtUser`) หรือผู้ใช้ต้นทาง (ฟิลด์ `SrcUser`)

## คำสั่ง Sysmon
* `sysmon-process-tree`: แสดงผลแผนผังโปรเซส (process tree) ของโปรเซสที่ระบุ

## คำสั่งสำหรับไทม์ไลน์
* `timeline-logon`: สร้างไทม์ไลน์ CSV ของเหตุการณ์การล็อกออน
* `timeline-partition-diagnostic`: สร้างไทม์ไลน์ CSV ของเหตุการณ์ partition diagnostic
* `timeline-suspicious-processes`: สร้างไทม์ไลน์ CSV ของโปรเซสที่น่าสงสัย
* `timeline-tasks`: สร้างไทม์ไลน์ CSV ของงานตามกำหนดเวลา

## คำสั่ง TTP
* `ttp-summary`: สรุปกลยุทธ์ (tactics) และเทคนิค (techniques) ที่พบในแต่ละคอมพิวเตอร์
* `ttp-visualize`: ดึง TTPs และสร้างไฟล์ JSON เพื่อใช้แสดงผลใน MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: ดึง TTPs จากกฎ Sigma และสร้างไฟล์ JSON เพื่อใช้แสดงผลใน MITRE ATT&CK Navigator

## คำสั่ง VirusTotal
* `vt-domain-lookup`: ค้นหารายการโดเมนบน VirusTotal และรายงานโดเมนที่เป็นอันตราย
* `vt-hash-lookup`: ค้นหารายการแฮชบน VirusTotal และรายงานแฮชที่เป็นอันตราย
* `vt-ip-lookup`: ค้นหารายการที่อยู่ IP บน VirusTotal และรายงานที่อยู่ที่เป็นอันตราย

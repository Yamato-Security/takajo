---
hide:
  - navigation
  - toc
---

<div class="hb-hero" markdown>

![Takajo](assets/logo.png){ .hb-logo }

<p class="hb-tagline">
<strong>Takajō</strong> (鷹匠) เป็นเครื่องมือวิเคราะห์ฟอเรนสิกที่รวดเร็วสำหรับ
ผลลัพธ์ของ <a href="https://github.com/Yamato-Security/hayabusa">Hayabusa</a> สร้างโดย
<a href="https://github.com/Yamato-Security">Yamato Security</a> และเขียนด้วย
<a href="https://nim-lang.org/">Nim</a> Takajō มีความหมายว่า
<a href="https://en.wikipedia.org/wiki/Falconry">"คนฝึกเหยี่ยว"</a> ในภาษาญี่ปุ่น — มันวิเคราะห์
"สิ่งที่จับได้" (ผลลัพธ์) ของ Hayabusa
</p>

<div class="hb-cta" markdown>
[เริ่มต้นใช้งาน :material-rocket-launch:](getting-started/index.md){ .md-button .md-button--primary }
[คู่มืออ้างอิงคำสั่ง :material-console:](commands/index.md){ .md-button }
[ดูบน GitHub :fontawesome-brands-github:](https://github.com/Yamato-Security/takajo){ .md-button }
</div>

<p class="hb-badges">
<a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/v/release/Yamato-Security/takajo?color=blue&label=Stable%20Version&style=flat"/></a>
<a href="https://github.com/Yamato-Security/takajo/releases"><img src="https://img.shields.io/github/downloads/Yamato-Security/takajo/total?style=flat&label=GitHub%F0%9F%A6%85Downloads&color=blue"/></a>
<a href="https://github.com/Yamato-Security/takajo/stargazers"><img src="https://img.shields.io/github/stars/Yamato-Security/takajo?style=flat&label=GitHub%F0%9F%A6%85Stars"/></a>
<a href="https://codeblue.jp/2022/en/talks/?content=talks_24"><img src="https://img.shields.io/badge/CODE%20BLUE%20Bluebox-2022-blue"></a>
<a href="https://www.seccon.jp/2022/seccon_workshop/windows.html"><img src="https://img.shields.io/badge/SECCON-2023-blue"></a>
<a href="https://www.sans.org/cyber-security-training-events/digital-forensics-summit-2023/"><img src="https://img.shields.io/badge/SANS%20DFIR%20Summit-2023-blue"></a>
<a href="https://bsides.tokyo/2024/"><img src="https://img.shields.io/badge/BSides%20Tokyo-2024-blue"></a>
<a href="https://www.hacker.or.jp/hack-fes-2024/"><img src="https://img.shields.io/badge/Hack%20Fes.-2024-blue"></a>
<a href="https://hitcon.org/2024/CMT/"><img src="https://img.shields.io/badge/HITCON-2024-blue"></a>
<a href="https://www.blackhat.com/sector/2024/briefings/schedule/index.html#performing-dfir-and-threat-hunting-with-yamato-security-oss-tools-and-community-driven-knowledge-41347"><img src="https://img.shields.io/badge/SecTor-2024-blue"></a>
<a href="https://twitter.com/SecurityYamato"><img src="https://img.shields.io/twitter/follow/SecurityYamato?style=social"/></a>
</p>

</div>

---

## ทำไมต้อง Takajō?

<div class="grid cards" markdown>

-   :material-flash:{ .lg .middle } __ไบนารีเดียวที่รวดเร็ว__

    ---

    เขียนด้วย **Nim** — ปลอดภัยด้านหน่วยความจำ รวดเร็วเทียบเท่า C เนทีฟ และเป็นไบนารี
    เดี่ยวแบบสแตนด์อโลนบนทุกระบบปฏิบัติการ

-   :material-file-chart:{ .lg .middle } __รายงาน HTML__

    ---

    สร้างรายงานสรุปในรูปแบบ HTML จากผลลัพธ์ Hayabusa ของคุณ หรือนำเสนอแบบโต้ตอบได้

-   :material-file-tree:{ .lg .middle } __ทรีของกระบวนการ__

    ---

    สร้างใหม่และแสดง **ทรีของกระบวนการ** ของกระบวนการที่เป็นอันตรายจากบันทึก Sysmon

-   :material-layers-triple:{ .lg .middle } __การวิเคราะห์แบบ Stacking__

    ---

    จัดกลุ่มคอมมานด์ไลน์ คำขอ DNS การล็อกออน กระบวนการ บริการ งาน และอื่น ๆ เพื่อ
    เผยให้เห็นค่าผิดปกติ

-   :material-timeline-clock:{ .lg .middle } __ไทม์ไลน์ที่เจาะจง__

    ---

    สร้างไทม์ไลน์สำหรับการล็อกออน การใช้งาน USB กระบวนการและงานที่น่าสงสัย และแบ่ง
    ไทม์ไลน์ CSV/JSONL ขนาดใหญ่

-   :material-shield-search:{ .lg .middle } __TTP และ VirusTotal__

    ---

    แสดงภาพ TTP เป็นฮีตแมปใน **MITRE ATT&CK Navigator** และค้นหา IP
    โดเมน และแฮชบน **VirusTotal**

</div>

## ลิงก์ด่วน

<div class="grid cards" markdown>

-   __:material-book-open-variant: เพิ่งเริ่มใช้งาน?__

    เริ่มต้นด้วย [ภาพรวม](overview/index.md) จากนั้นไปที่
    [การเริ่มต้นใช้งาน](getting-started/index.md) เพื่อดาวน์โหลดและรัน Takajō

-   __:material-console-line: กำลังทำงานกับ CLI?__

    เรียกดู [รายการคำสั่ง](commands/index.md) และคู่มืออ้างอิงตามหมวดหมู่ —
    [Extract](commands/extract.md), [HTML](commands/html.md), [Stack](commands/stack.md),
    [Timeline](commands/timeline.md) และอื่น ๆ

-   __:material-puzzle: ต้องการเจาะลึกเพิ่มเติม?__

    สำรวจ [โปรเจกต์ที่เกี่ยวข้อง](resources/companion-projects.md)
    [บันทึกการเปลี่ยนแปลง](resources/changelog.md) และวิธีการ
    [มีส่วนร่วม](resources/contributing.md)

</div>

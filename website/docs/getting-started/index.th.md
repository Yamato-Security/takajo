# การดาวน์โหลด

โปรดดาวน์โหลด Takajō เวอร์ชันเสถียรล่าสุดพร้อมไบนารีที่คอมไพล์แล้ว หรือคอมไพล์ซอร์สโค้ดจากหน้า [Releases](https://github.com/Yamato-Security/takajo/releases)

> หมายเหตุ: เราจัดเตรียมไบนารีรุ่นเผยแพร่สำหรับ Windows แบบ 64 บิต และ macOS ที่ใช้ Intel และ Arm แต่ไม่มีสำหรับ Linux เนื่องจากในขณะนี้เป็นเรื่องยากที่จะจัดเตรียมไบนารี MUSL สำหรับ Linux

## ความต้องการของระบบ

คำสั่ง `html-report` และ `html-server` ใช้ [DuckDB](https://duckdb.org/) เป็นแบ็กเอนด์ฐานข้อมูลเริ่มต้นสำหรับการสืบค้นเชิงวิเคราะห์ที่รวดเร็ว
คุณจำเป็นต้องติดตั้ง DuckDB ก่อนใช้งานคำสั่งเหล่านี้
คุณสามารถใช้แฟล็ก `--sqlite` เพื่อใช้ SQLite แทนได้หากคุณไม่ต้องการติดตั้ง DuckDB

### macOS (Homebrew)

```
brew install duckdb
```

### Windows (winget)

```
winget install DuckDB.cli
```

### Linux

```
wget -q https://github.com/duckdb/duckdb/releases/download/v1.4.4/libduckdb-linux-amd64.zip
unzip -o libduckdb-linux-amd64.zip -d duckdb_lib
sudo cp duckdb_lib/duckdb.h /usr/local/include/
sudo cp duckdb_lib/libduckdb.so /usr/local/lib/
sudo ldconfig
```

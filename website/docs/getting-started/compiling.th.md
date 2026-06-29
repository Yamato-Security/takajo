# ขั้นสูง: การคอมไพล์จากซอร์สโค้ด (ทางเลือก)

ขั้นแรก ติดตั้ง Nim ด้วย [choosenim](https://github.com/nim-lang/choosenim)
คุณยังต้องติดตั้ง DuckDB ด้วย (ดู [Requirements](index.md#requirements)) เนื่องจากต้องใช้ไลบรารี C ของ DuckDB ในขณะคอมไพล์
จากนั้นคุณสามารถคอมไพล์จากซอร์สโค้ดได้ด้วยคำสั่งต่อไปนี้:

```
> nimble update
> nimble build -d:release --threads:on
```

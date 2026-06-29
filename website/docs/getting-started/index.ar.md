# التنزيلات

يُرجى تنزيل أحدث إصدار مستقر من Takajō مع الملفات الثنائية المُجمَّعة أو قم بتجميع الكود المصدري من صفحة [Releases](https://github.com/Yamato-Security/takajo/releases).

> ملاحظة: نحن نوفّر ملفات ثنائية للإصدارات لنظام Windows بنظام 64 بت ولنظام macOS القائم على معالجات Intel وArm ولكن ليس لنظام Linux لأنه من الصعب توفير ملفات ثنائية MUSL لنظام Linux في الوقت الحالي.

## المتطلبات

يستخدم الأمران `html-report` و`html-server` قاعدة بيانات [DuckDB](https://duckdb.org/) كخلفية افتراضية لقاعدة البيانات من أجل الاستعلامات التحليلية السريعة.
تحتاج إلى تثبيت DuckDB قبل استخدام هذه الأوامر.
يمكنك استخدام الراية `--sqlite` لاستخدام SQLite بدلاً من ذلك إذا كنت لا ترغب في تثبيت DuckDB.

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

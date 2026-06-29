# Perintah Timeline

## Perintah `timeline-logon`

Perintah ini mengekstrak informasi dari event logon berikut, menormalisasi field, dan menyimpan hasilnya ke file CSV:

- `4624` - Logon Berhasil
- `4625` - Logon Gagal
- `4634` - Logoff Akun
- `4647` - Logoff yang Diinisiasi Pengguna
- `4648` - Logon Eksplisit
- `4672` - Logon Admin

Hal ini mempermudah pendeteksian lateral movement, penebakan/penyemprotan kata sandi, eskalasi hak akses, dll...

* Input: JSONL
* Profile: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: CSV

Opsi yang diperlukan:

- `-o, --output <CSV-FILE>`: file CSV tempat menyimpan hasil.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: file timeline JSONL Hayabusa atau direktori berisi file JSONL

Opsi:

- `-c, --calculateElapsedTime`: menghitung waktu yang berlalu untuk logon yang berhasil. (default: `true`)
- `-l, --outputLogoffEvents`: menampilkan event logoff sebagai entri terpisah. (default: `false`)
- `-a, --outputAdminLogonEvents`: menampilkan event logon admin sebagai entri terpisah. (default: `false`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `timeline-logon`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Simpan timeline logon ke file CSV:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### Tangkapan layar `timeline-logon`

![timeline-logon](../assets/screenshots/timeline-logon.png)

## Perintah `timeline-partition-diagnostic`

Membuat timeline CSV dari event diagnostik partisi dengan mem-parsing file `Microsoft-Windows-Partition%4Diagnostic.evtx` Windows 10 dan melaporkan informasi tentang semua perangkat yang terhubung beserta Volume Serial Number-nya, baik yang saat ini ada pada perangkat maupun yang sebelumnya pernah ada.
Proses ini didasarkan pada tool [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser).

* Input: JSONL
* Profile: Apa saja
* Output: Terminal atau CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: file timeline JSONL Hayabusa atau direktori berisi file JSONL

Opsi:

- `-o, --output <CSV-FILE>`: file CSV tempat menyimpan hasil.
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `timeline-partition-diagnostic`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Buat timeline CSV dari perangkat yang terhubung:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## Perintah `timeline-suspicious-processes`

Membuat timeline CSV dari proses yang mencurigakan.

* Input: JSONL
* Profile: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: file timeline JSONL Hayabusa atau direktori berisi file JSONL
- `-o, --output <CSV-FILE>`: file CSV tempat menyimpan hasil (default: `stdout`)

Opsi:

- `-l, --level <LEVEL>`: menentukan level alert minimum (default: `high`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `timeline-suspicious-processes`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Cari proses yang memiliki level alert `high` atau lebih tinggi dan tampilkan hasilnya ke layar:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

Cari proses yang memiliki level alert `low` atau lebih tinggi dan tampilkan hasilnya ke layar:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Simpan hasil ke file CSV:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### Tangkapan layar `timeline-suspicious-processes`

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## Perintah `timeline-tasks`

Perintah ini akan menumpuk scheduled task baru dari event Security 4698 dan mem-parsing konten task XML.

* Input: JSONL
* Profile: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau file CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: file timeline JSONL Hayabusa atau direktori berisi file JSONL

Opsi:

- `-o, --output <CSV-FILE>`: file CSV tempat menyimpan hasil.
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `timeline-tasks`

Tampilkan ke terminal:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

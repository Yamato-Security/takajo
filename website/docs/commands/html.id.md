# Perintah HTML

## Perintah `html-report`

Membuat laporan ringkasan HTML untuk aturan dan komputer dengan deteksi.
Perintah ini pertama-tama membuat berkas basis data DuckDB yang terindeks (default) atau berkas basis data SQLite untuk melakukan pencarian cepat pada data yang diperlukan untuk membuat laporan ringkasan.

* Input: JSONL
* Profil: Profil verbose apa pun
* Output: Laporan ringkasan HTML individual berdasarkan nama komputer serta halaman utama `index.html`

Opsi yang diperlukan:

- `-o, --output`: nama direktori laporan html
- `-r, --rulepath`: path ke direktori aturan Hayabusa
- `-t, --timeline <JSONL-FILE-OR-DIR>`: berkas atau direktori timeline JSONL Hayabusa

Opsi:

- `-C, --clobber`: menimpa berkas basis data saat menyimpan (default: `false`)
- `-q, --quiet`: tidak menampilkan banner peluncuran (default: `false`)
- `-s, --dboutput`: menyimpan hasil ke berkas basis data (default: `html-report.duckdb` atau `html-report.sqlite` dengan `--sqlite`)
- `--skipProgressBar`: tidak menampilkan bilah kemajuan (default: `false`)
- `--sqlite`: menggunakan backend SQLite alih-alih DuckDB (default: `false`)

### Contoh perintah `html-report`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

atau

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Buat laporan ringkasan HTML:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### Tangkapan layar `html-report`

#### Ringkasan Aturan

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Ringkasan Komputer

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Daftar Aturan

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## Perintah `html-server`

Membuat server web dinamis untuk melihat laporan ringkasan HTML.
Perintah ini pertama-tama membuat berkas basis data DuckDB yang terindeks (default) atau berkas basis data SQLite untuk melakukan pencarian cepat pada data yang diperlukan untuk membuat laporan ringkasan.
Perintah ini mirip dengan perintah `html-report` tetapi lebih skalabel dan memungkinkan pemfilteran berdasarkan tanggal dan aturan.

* Input: JSONL
* Profil: Profil verbose apa pun
* Output: Secara default, akan mendengarkan di `http://localhost:8823`

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: berkas atau direktori timeline JSONL Hayabusa

Opsi:

- `-C, --clobber`: menimpa berkas basis data saat menyimpan (default: `false`)
- `-p, --port`: nomor port server web (default: `8823`)
- `-q, --quiet`: tidak menampilkan banner peluncuran (default: `false`)
- `-r, --rulepath`: path ke direktori aturan Hayabusa (ini opsional tetapi diperlukan untuk membuat tautan yang benar ke berkas aturan)
- `-s, --dboutput`: menyimpan hasil ke berkas basis data (default: `html-report.duckdb` atau `html-report.sqlite` dengan `--sqlite`)
- `--skipProgressBar`: tidak menampilkan bilah kemajuan (default: `false`)
- `--sqlite`: menggunakan backend SQLite alih-alih DuckDB (default: `false`)

### Contoh perintah `html-report`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

atau

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Mulai server web:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### Tangkapan layar `html-server`

#### Daftar Aturan

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Ringkasan Komputer

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Pemfilteran Aturan

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Pemfilteran Aturan

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

# Perintah Otomatisasi

## Perintah `automagic`

Secara otomatis menjalankan sebanyak mungkin perintah dan menampilkan hasil ke folder baru

> Catatan: Anda harus menggunakan profil `verbose` atau `super-verbose` untuk memanfaatkan semua perintah.

* Input: File JSONL atau direktori berisi file JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Folder baru dengan semua hasil dalam file yang berbeda

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: File atau direktori timeline JSONL Hayabusa.

Opsi:

- `-d, --displayTable`: menampilkan tabel hasil (default: `false`)
- `-l, --level`: menentukan tingkat peringatan minimum (default: `low`)
- `-o, --output`: direktori output (default: `case-1`)
- `-q, --quiet`: tidak menampilkan banner peluncuran (default: `false`)
- `-s, --skipProgressBar`: tidak menampilkan bilah kemajuan (default: `false`)

### Contoh perintah `automagic`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Jalankan sebanyak mungkin perintah Takajo dan simpan hasilnya di dalam folder `case-1`:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Jalankan sebanyak mungkin perintah Takajo pada direktori `hayabusa-results` dan simpan hasilnya di dalam folder `case-1`:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

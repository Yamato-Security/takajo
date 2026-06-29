# Perintah Split

## Perintah `split-csv-timeline`

Membagi timeline CSV berukuran besar menjadi beberapa timeline yang lebih kecil berdasarkan nama komputer.

* Input: CSV non-multiline
* Profil: Any
* Output: Beberapa file CSV

Opsi yang diperlukan:

- `-t, --timeline <CSV-FILE>`: Timeline CSV yang dibuat oleh Hayabusa.

Opsi:

- `-m, --makeMultiline`: menampilkan field dalam beberapa baris. (default: `false`)
- `-o, --output <DIR>`: direktori untuk menyimpan file CSV. (default: `output`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `split-csv-timeline`

Siapkan timeline CSV dengan Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Bagi satu timeline CSV menjadi beberapa timeline CSV di direktori `output` default:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Pisahkan informasi field dengan karakter baris baru untuk membuat entri multi-baris dan simpan ke direktori `case-1-csv`:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## Perintah `split-json-timeline`

Membagi timeline JSONL berukuran besar menjadi beberapa timeline yang lebih kecil berdasarkan nama komputer.

* Input: JSONL
* Profil: Any
* Output: Beberapa file JSONL

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: File atau direktori timeline JSONL Hayabusa.

Opsi:

- `-o, --output <DIR>`: direktori untuk menyimpan file JSONL. (default: `output`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `split-json-timeline`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Bagi satu timeline JSONL menjadi beberapa timeline JSONL di direktori `output` default:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

Simpan ke direktori `case-1-jsonl`:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

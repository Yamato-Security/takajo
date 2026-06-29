# Perintah List

## Perintah `list-domains`

Membuat daftar domain unik untuk digunakan dengan `vt-domain-lookup`.
Saat ini hanya akan memeriksa domain yang ditanyakan dalam log Sysmon EID 22 tetapi akan diperbarui untuk mendukung log Windows DNS Client dan Server bawaan.

* Input: JSONL
* Profil: Apa pun selain `all-field-info` dan `all-field-info-verbose`
* Output: Berkas teks

Opsi yang diperlukan:

 - `-o, --output <TXT-FILE>`: simpan hasil ke berkas teks.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: berkas atau direktori timeline JSONL Hayabusa.

Opsi:

 - `-s, --includeSubdomains`: sertakan subdomain (default: `false`)
 - `-w, --includeWorkstations`: sertakan nama workstation lokal (default: `false`)
 - `-q, --quiet`: jangan tampilkan logo (default: `false`)
 - `-s, --skipProgressBar`: jangan tampilkan bilah kemajuan (default: `false`)

### Contoh perintah `list-domains`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Simpan hasil ke berkas teks:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Sertakan subdomain:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## Perintah `list-hashes`

Membuat daftar hash proses untuk digunakan dengan vt-hash-lookup (input: JSONL, profil: standard)

* Input: JSONL
* Profil: Apa pun selain `all-field-info` dan `all-field-info-verbose`
* Output: Berkas teks

Opsi yang diperlukan:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: berkas atau direktori timeline JSONL Hayabusa dari berkas JSONL
 - `-o, --output <BASE-NAME>`: tentukan nama dasar untuk menyimpan hasil teks.

Opsi:

 - `-l, --level`: tentukan level minimum. (default: `high`)
 - `-q, --quiet`: jangan tampilkan logo. (default: `false`)
 - `-s, --skipProgressBar`: jangan tampilkan bilah kemajuan (default: `false`)

### Contoh perintah `list-hashes`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Simpan hasil ke berkas teks yang berbeda untuk setiap jenis hash:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Sebagai contoh, jika hash `MD5`, `SHA1` dan `IMPHASH` tersimpan dalam log sysmon, maka berkas berikut akan dibuat: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## Perintah `list-ip-addresses`

Membuat daftar alamat IP target dan/atau sumber yang unik untuk digunakan dengan `vt-ip-lookup`.
Ini akan mengekstrak field `TgtIP` untuk alamat IP target dan field `SrcIP` untuk alamat IP sumber dalam semua hasil dan hanya menampilkan alamat IP yang unik ke berkas teks.

* Input: JSONL
* Profil: Apa pun selain `all-field-info` dan `all-field-info-verbose`
* Output: Berkas teks

Opsi yang diperlukan:

 - `-o, --output <TXT-FILE>`: simpan hasil ke berkas teks.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: berkas atau direktori timeline JSONL Hayabusa.

Opsi:

 - `-i, --inbound`: sertakan lalu lintas masuk. (default: `true`)
 - `-O, --outbound`: sertakan lalu lintas keluar. (default: `true`)
 - `-p, --privateIp`: sertakan alamat IP privat (default: `false`)
 - `-q, --quiet`: jangan tampilkan logo. (default: `false`)
 - `-s, --skipProgressBar`: "jangan tampilkan bilah kemajuan (default: `false`)

### Contoh perintah `list-ip-addresses`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Simpan hasil ke berkas teks:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Kecualikan lalu lintas masuk:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Sertakan alamat IP privat:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## Perintah `list-undetected-evtx`

Mendaftar semua berkas `.evtx` yang tidak memiliki aturan deteksi pada Hayabusa.
Ini dimaksudkan untuk digunakan pada berkas evtx sampel yang semuanya berisi bukti aktivitas berbahaya seperti berkas evtx sampel di repositori [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx).

* Input: CSV
* Profil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Anda terlebih dahulu perlu menjalankan Hayabusa dengan profil yang menyimpan informasi kolom `%EvtxFile%` dan menyimpan hasilnya ke timeline CSV.
  > Anda dapat melihat kolom mana saja yang disimpan Hayabusa sesuai dengan profil yang berbeda [di sini](https://github.com/Yamato-Security/hayabusa#profiles).
* Output: Terminal atau berkas teks

Opsi yang diperlukan:

- `-e, --evtx-dir <EVTX-DIR>`: Direktori berkas `.evtx` yang Anda pindai dengan Hayabusa.
- `-t, --timeline <CSV-FILE>`: timeline CSV Hayabusa.

Opsi:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: tentukan nama kolom kustom untuk kolom evtx. (default: nilai default Hayabusa yaitu `EvtxFile`)
- `-o, --output <TXT-FILE>`: simpan hasil ke berkas teks. (default: output ke layar)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)

### Contoh perintah `list-undetected-evtx`

Siapkan timeline CSV dengan Hayabusa:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Tampilkan hasil ke layar:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Simpan hasil ke berkas teks:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## Perintah `list-unused-rules`

Mendaftar semua aturan deteksi `.yml` yang tidak mendeteksi apa pun.
Ini berguna untuk membantu menentukan keandalan aturan.
Yaitu, aturan mana yang diketahui menemukan aktivitas berbahaya dan mana yang masih belum teruji serta memerlukan berkas `.evtx` sampel.

* Input: CSV
* Profil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Anda terlebih dahulu perlu menjalankan Hayabusa dengan profil yang menyimpan informasi kolom `%RuleFile%` dan menyimpan hasilnya ke timeline CSV.
  > Anda dapat melihat kolom mana saja yang disimpan Hayabusa sesuai dengan profil yang berbeda [di sini](https://github.com/Yamato-Security/hayabusa#profiles).
* Output: Terminal atau berkas teks

Opsi yang diperlukan:

- `-r, --rules-dir <DIR>`: direktori berkas aturan `.yml` yang Anda gunakan dengan Hayabusa.
- `-t, --timeline <CSV-FILE>`: timeline CSV yang dibuat oleh Hayabusa.

Opsi:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: tentukan nama kolom kustom untuk kolom berkas aturan. (default: nilai default Hayabusa yaitu `RuleFile`)
- `-o, --output <TXT-FILE>`: simpan hasil ke berkas teks. (default: output ke layar)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)

### Contoh perintah `list-unused-rules`

Siapkan timeline CSV dengan Hayabusa:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Tampilkan hasil ke layar:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Simpan hasil ke berkas teks:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

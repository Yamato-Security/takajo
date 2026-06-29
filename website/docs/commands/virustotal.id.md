# Perintah VirusTotal

## Perintah `vt-domain-lookup`

Mencari daftar domain di VirusTotal

* Input: Berkas teks
* Profil: Apa pun selain `all-field-info` dan `all-field-info-verbose`
* Output: CSV

Opsi yang diperlukan:

- `-a, --apiKey <API-KEY>`: kunci API VirusTotal Anda.
- `-d, --domainList <TXT-FILE>`: berkas teks berisi daftar domain.
- `-o, --output <CSV-FILE>`: menyimpan hasil ke berkas CSV.

Opsi:

- `-j, --jsonOutput <JSON-FILE>`: mengeluarkan semua respons JSON dari VirusTotal ke berkas JSON.
- `-r, --rateLimit <NUMBER>`: laju per menit untuk mengirim permintaan. (default: `4`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `vt-domain-lookup`

Pertama, buat daftar domain dengan perintah `list-domains`.
Kemudian cari domain tersebut dengan cara berikut:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## Perintah `vt-hash-lookup`

Mencari daftar hash di VirusTotal.

* Input: Berkas teks
* Profil: Apa pun selain `all-field-info` dan `all-field-info-verbose`
* Output: CSV

Opsi yang diperlukan:

- `-a, --apiKey <API-KEY>`: kunci API VirusTotal Anda.
- `-H, --hashList <HASH-LIST>`: berkas teks berisi hash.
- `-o, --output <CSV-FILE>`: menyimpan hasil ke berkas CSV.

Opsi:

- `-j, --jsonOutput <JSON-FILE>`: mengeluarkan semua respons JSON dari VirusTotal ke berkas JSON.
- `-r, --rateLimit <NUMBER>`: laju per menit untuk mengirim permintaan. (default: `4`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `vt-hash-lookup`

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## Perintah `vt-ip-lookup`

Mencari daftar alamat IP di VirusTotal.

* Input: Berkas teks
* Profil: Apa pun selain `all-field-info` dan `all-field-info-verbose`
* Output: CSV

Opsi yang diperlukan:

- `-a, --apiKey <API-KEY>`: kunci API VirusTotal Anda.
- `-i, --ipList <IP-ADDRESS-LIST>`: berkas teks berisi alamat IP.
- `-o, --output <CSV-FILE>`: menyimpan hasil ke berkas CSV.

Opsi:

- `-j, --jsonOutput <JSON-FILE>`: mengeluarkan semua respons JSON dari VirusTotal ke berkas JSON.
- `-r, --rateLimit <NUMBER>`: laju per menit untuk mengirim permintaan. (default: `4`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `vt-ip-lookup`

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

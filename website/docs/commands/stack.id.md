# Perintah Stack

## Perintah `stack-cmdlines`

Perintah ini akan menumpuk command line yang dieksekusi dengan mengekstrak informasi dari event `Sysmon 1` dan `Security 4688`.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-y, --ignoreSysmon`: kecualikan event Sysmon 1 (default: `false`)
- `-e, --ignoreSecurity`: kecualikan event Security 4688 (default: `false`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-cmdlines`

Output ke terminal:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## Perintah `stack-computers`

Perintah ini akan menumpuk hostname komputer berdasarkan field `Computer`.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-c, --sourceComputers`: tumpuk komputer sumber alih-alih komputer target (default: false)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-computers`

Output ke terminal:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## Perintah `stack-dns`

Perintah ini akan menumpuk kueri dan respons DNS dari event Sysmon 22.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-dns`

Output ke terminal:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## Perintah `stack-ip-addresses`

Perintah ini akan menumpuk alamat IP target (field `TgtIP`) atau alamat IP sumber (field `SrcIP`).

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-a, --targetIpAddresses`: tumpuk alamat IP target alih-alih alamat IP sumber (default: `false`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-ip-addresses`

Output ke terminal:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## Perintah `stack-logons`

Membuat daftar logon berdasarkan `Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer`.
Secara default, hasil disaring keluar ketika alamat IP sumber merupakan alamat IP lokal.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --localSrcIpAddresses`: sertakan hasil ketika alamat IP sumber adalah lokal.
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-logons`

Jalankan dengan pengaturan default:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Sertakan logon lokal:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## Perintah `stack-processes`

Perintah ini akan menumpuk proses yang dieksekusi dari event Sysmon 1 dan Security 4688.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `low`)
- `-y, --ignoreSysmon`: kecualikan event Sysmon 1 (default: `false`)
- `-e, --ignoreSecurity`: kecualikan event Security 4688 (default: `false`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-processes`

Output ke terminal:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## Perintah `stack-services`

Perintah ini akan menumpuk nama dan path layanan dari event System 7040 dan Security 4697.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-y, --ignoreSystem`: kecualikan event System 7040 (default: `false`)
- `-e, --ignoreSecurity`: kecualikan event Security 4697 (default: `false`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-services`

Output ke terminal:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## Perintah `stack-tasks`

Perintah ini akan menumpuk scheduled task baru dari event Security 4698 dan mengurai konten task XML.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-tasks`

Output ke terminal:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## Perintah `stack-users`

Perintah ini akan menumpuk pengguna target (field `TgtUser` (default)) atau pengguna sumber (field `SrcUser`) di setiap event yang memiliki field tersebut serta menampilkan informasi peringatan.

* Input: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Output: Terminal atau berkas CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Berkas timeline JSONL Hayabusa atau direktori berisi berkas JSONL

Opsi:

- `-s, --sourceUsers`: tumpuk pengguna sumber alih-alih pengguna target (default: false)
- `-c, --filterComputerAccounts`: saring keluar akun komputer (default: true)
- `-f, --filterSystemAccounts`: saring keluar akun sistem (default: true)
- `-l, --level`: tentukan level peringatan minimum (default: `informational`)
- `-o, --output <CSV-FILE>`: berkas CSV untuk menyimpan hasil (default: `stdout`)
- `-q, --quiet`: jangan tampilkan logo. (default: `false`)
- `-s, --skipProgressBar`: jangan tampilkan progress bar (default: `false`)

### Contoh perintah `stack-users`

Output ke terminal:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

Simpan ke CSV:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

# Perintah Sysmon

## Perintah `sysmon-process-tree`

Menampilkan pohon proses dari suatu proses tertentu, seperti proses yang mencurigakan atau berbahaya.

* Masukan: JSONL
* Profil: Apa saja selain `all-field-info` dan `all-field-info-verbose`
* Keluaran: Terminal atau berkas teks

Opsi yang diperlukan:

- `-p, --processGuid <Process GUID>`: GUID proses sysmon
- `-t, --timeline <JSONL-FILE-OR-DIR>`: berkas timeline JSONL Hayabusa atau direktori berkas JSONL

Opsi:

- `-o, --output <TXT-FILE>`: berkas teks untuk menyimpan hasilnya.
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `sysmon-process-tree`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Simpan hasilnya ke berkas teks:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### Tangkapan layar `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

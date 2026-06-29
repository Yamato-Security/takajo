# Perintah Extract

## Perintah `extract-scriptblocks`

Mengekstrak dan menyusun ulang log script block PowerShell EID 4104.

> Catatan: Script PowerShell paling baik dibuka sebagai file `.ps1` dengan penyorotan sintaks kode, tetapi kami menggunakan ekstensi `.txt` untuk mencegah eksekusi kode berbahaya secara tidak sengaja.

* Input: JSONL
* Profil: Apa saja
* Output: Terminal dan direktori Script PowerShell

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: File atau direktori timeline JSONL Hayabusa

Opsi:

 - `-l, --level`: menentukan level peringatan minimum (default: `low`)
 - `-o, --output`: direktori output (default: `scriptblock-logs`)
 - `-q, --quiet`: tidak menampilkan banner peluncuran (default: `false`)
 - `-s, --skipProgressBar`: tidak menampilkan progress bar (default: `false`)

### Contoh perintah `extract-scriptblocks`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Ekstrak log script block PowerShell EID 4104 ke direktori `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### Tangkapan layar `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

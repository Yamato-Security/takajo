# Perintah TTP

## Perintah `ttp-summary`

Perintah ini meringkas taktik dan teknik yang ditemukan di setiap komputer berdasarkan TTP MITRE ATT&CK yang didefinisikan dalam field `tags` pada aturan sigma.

* Input: JSONL
* Profil: Profil yang menampilkan field `%MitreTactics%` dan `%MitreTags%`. (Contoh: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Output: Terminal atau CSV

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: file timeline JSONL Hayabusa atau direktori berisi file JSONL

Opsi:

- `-o, --output <CSV-FILE>`: file CSV tempat menyimpan hasilnya.
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `ttp-summary`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Cetak ringkasan TTP ke terminal:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Simpan hasilnya ke file CSV:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### Tangkapan layar `ttp-summary`

![ttp-summary](../assets/screenshots/ttp-summary.png)

## Perintah `ttp-visualize`

Perintah ini mengekstrak TTP dan membuat file JSON untuk divisualisasikan di [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Input: JSONL
* Profil: Profil yang menampilkan field `%MitreTactics%` dan `%MitreTags%`. (Contoh: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Output: JSON

Opsi yang diperlukan:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: file timeline JSONL Hayabusa atau direktori berisi file JSONL

Opsi:

- `-o, --output <JSON-FILE>`: file JSON tempat menyimpan hasilnya. (default: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `ttp-visualize`

Siapkan timeline JSONL dengan Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Ekstrak TTP dan simpan ke `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

Buka [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), klik `Open Existing Layer` dan unggah file JSON yang telah disimpan.

### Tangkapan layar `ttp-visualize`

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## Perintah `ttp-visualize-sigma`

Perintah ini mengekstrak TTP dari Sigma dan membuat file JSON untuk divisualisasikan di [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Input: Direktori aturan Sigma
* Output: JSON

Opsi yang diperlukan:

- `-r, --ruleDir <SIGMA-DIR>`: direktori aturan Sigma

Opsi:

- `-o, --output <JSON-FILE>`: file JSON tempat menyimpan hasilnya. (default: `mitre-attack-navigator.json`)
- `-q, --quiet`: tidak menampilkan logo. (default: `false`)

### Contoh perintah `ttp-visualize-sigma`

Klon repositori Sigma:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Ekstrak TTP dari Sigma dan simpan ke `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

# Daftar Perintah

## Perintah Otomatisasi
* `automagic`: secara otomatis menjalankan sebanyak mungkin perintah dan mengeluarkan hasilnya ke folder baru

## Perintah Ekstraksi
* `extract-scriptblocks`: mengekstrak dan menyusun kembali log blok skrip PowerShell EID 4104

## Perintah HTML
* `html-report`: membuat laporan ringkasan HTML statis
* `html-server`: membuat server web dinamis untuk melihat laporan ringkasan HTML

## Perintah Daftar
* `list-domains`: membuat daftar domain unik untuk digunakan dengan `vt-domain-lookup`
* `list-hashes`: membuat daftar hash proses untuk digunakan dengan `vt-hash-lookup`
* `list-ip-addresses`: membuat daftar alamat IP target dan/atau sumber yang unik untuk digunakan dengan `vt-ip-lookup`
* `list-undetected-evtx`: membuat daftar berkas evtx yang tidak terdeteksi
* `list-unused-rules`: membuat daftar aturan deteksi yang tidak digunakan

## Perintah Pemisahan
* `split-csv-timeline`: memisahkan linimasa CSV besar menjadi linimasa yang lebih kecil berdasarkan nama komputer
* `split-json-timeline`: memisahkan linimasa JSONL besar menjadi linimasa yang lebih kecil berdasarkan nama komputer

## Perintah Stack
* `stack-cmdlines`: menumpuk baris perintah yang dieksekusi
* `stack-computers`: menumpuk komputer
* `stack-dns`: menumpuk kueri dan respons DNS
* `stack-ip-addresses`: menumpuk alamat IP target (field `TgtIP`) atau alamat IP sumber (field `SrcIP`)
* `stack-logons`: menumpuk logon berdasarkan pengguna target, komputer target, alamat IP sumber, dan komputer sumber
* `stack-processes`: menumpuk proses yang dieksekusi
* `stack-services`: menumpuk nama dan jalur layanan dari event `System 7040` dan `Security 4697`
* `stack-tasks`: menumpuk tugas terjadwal baru dari event `Security 4698` dan mengurai konten tugas XML
* `stack-users`: menumpuk pengguna target (field `TgtUser`) atau pengguna sumber (field `SrcUser`)

## Perintah Sysmon
* `sysmon-process-tree`: mengeluarkan pohon proses dari suatu proses tertentu

## Perintah Linimasa
* `timeline-logon`: membuat linimasa CSV dari event logon
* `timeline-partition-diagnostic`: membuat linimasa CSV dari event diagnostik partisi
* `timeline-suspicious-processes`: membuat linimasa CSV dari proses yang mencurigakan
* `timeline-tasks`: membuat linimasa CSV dari tugas terjadwal

## Perintah TTP
* `ttp-summary`: meringkas taktik dan teknik yang ditemukan di setiap komputer
* `ttp-visualize`: mengekstrak TTP dan membuat berkas JSON untuk divisualisasikan di MITRE ATT&CK Navigator
* `ttp-visualize-sigma`: mengekstrak TTP dari aturan Sigma dan membuat berkas JSON untuk divisualisasikan di MITRE ATT&CK Navigator

## Perintah VirusTotal
* `vt-domain-lookup`: mencari daftar domain di VirusTotal dan melaporkan yang berbahaya
* `vt-hash-lookup`: mencari daftar hash di VirusTotal dan melaporkan yang berbahaya
* `vt-ip-lookup`: mencari daftar alamat IP di VirusTotal dan melaporkan yang berbahaya

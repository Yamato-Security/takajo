# Sysmon Komutları

## `sysmon-process-tree` komutu

Şüpheli veya kötü amaçlı bir süreç gibi belirli bir sürecin süreç ağacını çıktı olarak verir.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışındaki herhangi biri
* Çıktı: Terminal veya metin dosyası

Gerekli seçenekler:

- `-p, --processGuid <Process GUID>`: sysmon süreç GUID'i
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarından oluşan dizin

Seçenekler:

- `-o, --output <TXT-FILE>`: sonuçların kaydedileceği bir metin dosyası.
- `-q, --quiet`: logoyu görüntüleme. (varsayılan: `false`)

### `sysmon-process-tree` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesi hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Sonuçları bir metin dosyasına kaydedin:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### `sysmon-process-tree` ekran görüntüsü

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

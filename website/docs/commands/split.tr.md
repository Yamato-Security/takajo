# Bölme Komutları

## `split-csv-timeline` komutu

Büyük bir CSV zaman çizelgesini bilgisayar adına göre daha küçük parçalara böler.

* Girdi: Çok satırlı olmayan CSV
* Profil: Herhangi biri
* Çıktı: Birden fazla CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <CSV-FILE>`: Hayabusa tarafından oluşturulan CSV zaman çizelgesi.

Seçenekler:

- `-m, --makeMultiline`: alanları birden fazla satırda çıktılar. (varsayılan: `false`)
- `-o, --output <DIR>`: CSV dosyalarının kaydedileceği dizin. (varsayılan: `output`)
- `-q, --quiet`: logoyu görüntüleme. (varsayılan: `false`)

### `split-csv-timeline` komut örnekleri

CSV zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -o timeline.csv -w
```

Tek bir CSV zaman çizelgesini varsayılan `output` dizininde birden fazla CSV zaman çizelgesine bölün:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv
```

Çok satırlı girdiler oluşturmak için alan bilgilerini yeni satır karakterleriyle ayırın ve `case-1-csv` dizinine kaydedin:

```
takajo.exe split-csv-timeline -t ../hayabusa/timeline.csv -m -o case-1-csv
```

## `split-json-timeline` komutu

Büyük bir JSONL zaman çizelgesini bilgisayar adına göre daha küçük parçalara böler.

* Girdi: JSONL
* Profil: Herhangi biri
* Çıktı: Birden fazla JSONL dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini.

Seçenekler:

- `-o, --output <DIR>`: JSONL dosyalarının kaydedileceği dizin. (varsayılan: `output`)
- `-q, --quiet`: logoyu görüntüleme. (varsayılan: `false`)

### `split-json-timeline` komut örnekleri

JSONL zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Tek bir JSONL zaman çizelgesini varsayılan `output` dizininde birden fazla JSONL zaman çizelgesine bölün:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl
```

`case-1-jsonl` dizinine kaydedin:

```
takajo.exe split-json-timeline -t ../hayabusa/timeline.jsonl -o case-1-jsonl
```

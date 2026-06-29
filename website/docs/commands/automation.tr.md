# Otomasyon Komutları

## `automagic` komutu

Mümkün olduğunca çok komutu otomatik olarak çalıştırır ve sonuçları yeni bir klasöre yazar

> Not: Tüm komutlardan yararlanmak için `verbose` veya `super-verbose` profilini kullanmalısınız.

* Girdi: JSONL dosyası veya JSONL dosyalarının bulunduğu dizin
* Profil: `all-field-info` ve `all-field-info-verbose` dışındaki herhangi biri
* Çıktı: Tüm sonuçların farklı dosyalarda bulunduğu yeni bir klasör

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini.

Seçenekler:

- `-d, --displayTable`: sonuç tablosunu görüntüle (varsayılan: `false`)
- `-l, --level`: minimum uyarı seviyesini belirt (varsayılan: `low`)
- `-o, --output`: çıktı dizini (varsayılan: `case-1`)
- `-q, --quiet`: başlangıç afişini görüntüleme (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu görüntüleme (varsayılan: `false`)

### `automagic` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesini hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Mümkün olduğunca çok Takajo komutunu çalıştırın ve sonuçları `case-1` klasörü altına kaydedin:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Mümkün olduğunca çok Takajo komutunu `hayabusa-results` dizini üzerinde çalıştırın ve sonuçları `case-1` klasörü altına kaydedin:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

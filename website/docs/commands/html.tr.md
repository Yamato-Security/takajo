# HTML Komutları

## `html-report` komutu

Tespitleri olan kurallar ve bilgisayarlar için HTML özet raporları oluşturur.
Bu komut, özet raporları oluşturmak için gereken veriler üzerinde hızlı aramalar yapmak amacıyla önce indekslenmiş bir DuckDB veritabanı dosyası (varsayılan) veya SQLite veritabanı dosyası oluşturur.

* Girdi: JSONL
* Profil: Herhangi bir ayrıntılı (verbose) profil
* Çıktı: Bilgisayar adına dayalı bireysel HTML özet raporları ve bir `index.html` ana sayfası

Zorunlu seçenekler:

- `-o, --output`: html rapor dizini adı
- `-r, --rulepath`: Hayabusa kuralları dizininin yolu
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini

Seçenekler:

- `-C, --clobber`: kaydederken veritabanı dosyasının üzerine yaz (varsayılan: `false`)
- `-q, --quiet`: başlangıç afişini görüntüleme (varsayılan: `false`)
- `-s, --dboutput`: sonuçları bir veritabanı dosyasına kaydet (varsayılan: `html-report.duckdb` veya `--sqlite` ile `html-report.sqlite`)
- `--skipProgressBar`: ilerleme çubuğunu görüntüleme (varsayılan: `false`)
- `--sqlite`: DuckDB yerine SQLite arka ucunu kullan (varsayılan: `false`)

### `html-report` komutu örneği

Hayabusa ile JSONL zaman çizelgesini hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

veya

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

HTML özet raporlarını oluşturun:

```
takajo.exe html-report -t ../hayabusa/hayabusa-results.jsonl -o htmlreport -r ../hayabusa/rules
```

### `html-report` ekran görüntüleri

#### Kural Özeti

![html-report-rule-summary](../assets/screenshots/html-report-1-rule-summary.png)

#### Bilgisayar Özeti

![html-report-computer-summary](../assets/screenshots/html-report-2-computer-summary.png)

#### Kural Listesi

![html-report-rule-list](../assets/screenshots/html-report-3-rule-list.png)

## `html-server` komutu

HTML özet raporlarını görüntülemek için dinamik bir web sunucusu oluşturur.
Bu komut, özet raporları oluşturmak için gereken veriler üzerinde hızlı aramalar yapmak amacıyla önce indekslenmiş bir DuckDB veritabanı dosyası (varsayılan) veya SQLite veritabanı dosyası oluşturur.
`html-report` komutuna benzer ancak daha ölçeklenebilirdir ve tarihler ile kurallar üzerinde filtreleme yapılmasına olanak tanır.

* Girdi: JSONL
* Profil: Herhangi bir ayrıntılı (verbose) profil
* Çıktı: Varsayılan olarak `http://localhost:8823` üzerinde dinleme yapar

Zorunlu seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini

Seçenekler:

- `-C, --clobber`: kaydederken veritabanı dosyasının üzerine yaz (varsayılan: `false`)
- `-p, --port`: web sunucusu port numarası (varsayılan: `8823`)
- `-q, --quiet`: başlangıç afişini görüntüleme (varsayılan: `false`)
- `-r, --rulepath`: Hayabusa kuralları dizininin yolu (bu isteğe bağlıdır ancak kural dosyalarına doğru bağlantılar oluşturmak için gereklidir)
- `-s, --dboutput`: sonuçları bir veritabanı dosyasına kaydet (varsayılan: `html-report.duckdb` veya `--sqlite` ile `html-report.sqlite`)
- `--skipProgressBar`: ilerleme çubuğunu görüntüleme (varsayılan: `false`)
- `--sqlite`: DuckDB yerine SQLite arka ucunu kullan (varsayılan: `false`)

### `html-report` komutu örneği

Hayabusa ile JSONL zaman çizelgesini hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

veya

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p super-verbose
```

Web sunucusunu başlatın:

```
takajo.exe html-server -t ../hayabusa/hayabusa-results.jsonl -r ../hayabusa/rules
```

### `html-server` ekran görüntüleri

#### Kurallar Listesi

![html-server-rules-list](../assets/screenshots/html-server-1-rules-list.png)

#### Bilgisayar Özeti

![html-server-computer-summary](../assets/screenshots/html-server-2-computer-summary.png)

#### Kural Filtreleme

![html-server-date-filtering](../assets/screenshots/html-server-3-date-filtering.png)

#### Kural Filtreleme

![html-server-rule-filtering](../assets/screenshots/html-server-4-rule-filtering.png)

# Zaman Çizelgesi Komutları

## `timeline-logon` komutu

Bu komut, aşağıdaki oturum açma olaylarından bilgi çıkarır, alanları normalleştirir ve sonuçları bir CSV dosyasına kaydeder:

- `4624` - Başarılı Oturum Açma
- `4625` - Başarısız Oturum Açma
- `4634` - Hesap Oturum Kapatma
- `4647` - Kullanıcı Tarafından Başlatılan Oturum Kapatma
- `4648` - Açık Oturum Açma
- `4672` - Yönetici Oturum Açma

Bu, yanal hareketi, parola tahmini/püskürtmesini, ayrıcalık yükseltmeyi vb. tespit etmeyi kolaylaştırır...

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: CSV

Gerekli seçenekler:

- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası.
- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-c, --calculateElapsedTime`: başarılı oturum açmalar için geçen süreyi hesapla. (varsayılan: `true`)
- `-l, --outputLogoffEvents`: oturum kapatma olaylarını ayrı girdiler olarak çıktıla. (varsayılan: `false`)
- `-a, --outputAdminLogonEvents`: yönetici oturum açma olaylarını ayrı girdiler olarak çıktıla. (varsayılan: `false`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)

### `timeline-logon` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesi hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Oturum açma zaman çizelgesini bir CSV dosyasına kaydedin:

```
takajo.exe timeline-logon -t ../hayabusa/timeline.jsonl -o logon-timeline.csv
```

### `timeline-logon` ekran görüntüsü

![timeline-logon](../assets/screenshots/timeline-logon.png)

## `timeline-partition-diagnostic` komutu

Windows 10 `Microsoft-Windows-Partition%4Diagnostic.evtx` dosyalarını ayrıştırarak bölüm tanılama olaylarının bir CSV zaman çizelgesini oluşturur ve bağlı tüm cihazlar ile bunların Birim Seri Numaraları hakkında, hem şu anda cihazda mevcut olanlar hem de önceden var olanlar hakkında bilgi raporlar.
Bu işlem, [Partition-4DiagnosticParser](https://github.com/theAtropos4n6/Partition-4DiagnosticParser) aracına dayanmaktadır.

* Girdi: JSONL
* Profil: Herhangi biri
* Çıktı: Terminal veya CSV

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası.
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)

### `timeline-partition-diagnostic` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesi hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Bağlı cihazların bir CSV zaman çizelgesini oluşturun:

```
takajo.exe timeline-partition-diagnostic -t ../hayabusa/timeline.jsonl -o partition-diagnostic-timeline.csv
```

## `timeline-suspicious-processes` komutu

Şüpheli süreçlerin bir CSV zaman çizelgesini oluşturur.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)

Seçenekler:

- `-l, --level <LEVEL>`: minimum uyarı seviyesini belirt (varsayılan: `high`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)

### `timeline-suspicious-processes` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesi hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

`high` veya üzeri bir uyarı seviyesine sahip olan süreçleri arayın ve sonuçları ekrana çıktılayın:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl
```

`low` veya üzeri bir uyarı seviyesine sahip olan süreçleri arayın ve sonuçları ekrana çıktılayın:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -l low
```

Sonuçları bir CSV dosyasına kaydedin:

```
takajo.exe timeline-suspicious-processes -t ../hayabusa/timeline.jsonl -o suspicous-processes.csv
```

### `timeline-suspicious-processes` ekran görüntüsü

![timeline-suspicious-processes](../assets/screenshots/timeline-suspicious-processes.png)

## `timeline-tasks` komutu

Bu komut, Security 4698 olaylarından yeni zamanlanmış görevleri yığınlar ve XML görev içeriğini ayrıştırır.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası.
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)

### `timeline-tasks` komutu örnekleri

Terminale çıktıla:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydet:

```
takajo.exe timeline-tasks -t ../hayabusa/timeline.jsonl -o timeline-tasks.csv
```

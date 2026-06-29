# List Komutları

## `list-domains` komutu

`vt-domain-lookup` ile kullanılacak benzersiz alan adlarından oluşan bir liste oluşturur.
Şu anda yalnızca Sysmon EID 22 günlüklerinde sorgulanan alan adlarını kontrol eder, ancak yerleşik Windows DNS İstemci ve Sunucu günlüklerini destekleyecek şekilde güncellenecektir.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Metin dosyası

Gerekli seçenekler:

 - `-o, --output <TXT-FILE>`: sonuçları bir metin dosyasına kaydeder.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini.

Seçenekler:

 - `-s, --includeSubdomains`: alt alan adlarını dahil eder (varsayılan: `false`)
 - `-w, --includeWorkstations`: yerel iş istasyonu adlarını dahil eder (varsayılan: `false`)
 - `-q, --quiet`: logoyu görüntülemez (varsayılan: `false`)
 - `-s, --skipProgressBar`: ilerleme çubuğunu görüntülemez (varsayılan: `false`)

### `list-domains` komut örnekleri

JSONL zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Sonuçları bir metin dosyasına kaydedin:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt
```

Alt alan adlarını dahil edin:

```
takajo.exe list-domains -t ../hayabusa/timeline.jsonl -o domains.txt -s
```

## `list-hashes` komutu

vt-hash-lookup ile kullanılacak süreç hash'lerinden oluşan bir liste oluşturur (girdi: JSONL, profil: standard)

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Metin dosyası

Gerekli seçenekler:

 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarından oluşan dizin
 - `-o, --output <BASE-NAME>`: metin sonuçlarını kaydetmek için temel adı belirtin.

Seçenekler:

 - `-l, --level`: minimum seviyeyi belirtin. (varsayılan: `high`)
 - `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)
 - `-s, --skipProgressBar`: ilerleme çubuğunu görüntülemez (varsayılan: `false`)

### `list-hashes` komut örnekleri

JSONL zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Her hash türü için sonuçları farklı bir metin dosyasına kaydedin:

```
takajo.exe list-hashes -t ../hayabusa/timeline.jsonl -o case-1
```

Örneğin, sysmon günlüklerinde `MD5`, `SHA1` ve `IMPHASH` hash'leri depolanmışsa, aşağıdaki dosyalar oluşturulur: `case-1-MD5-hashes.txt`, `case-1-SHA1-hashes.txt`, `case-1-ImportHashes.txt`

## `list-ip-addresses` komutu

`vt-ip-lookup` ile kullanılacak benzersiz hedef ve/veya kaynak IP adreslerinden oluşan bir liste oluşturur.
Tüm sonuçlarda hedef IP adresleri için `TgtIP` alanlarını ve kaynak IP adresleri için `SrcIP` alanlarını çıkarır ve yalnızca benzersiz IP adreslerini bir metin dosyasına yazar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Metin dosyası

Gerekli seçenekler:

 - `-o, --output <TXT-FILE>`: sonuçları bir metin dosyasına kaydeder.
 - `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini.

Seçenekler:

 - `-i, --inbound`: gelen trafiği dahil eder. (varsayılan: `true`)
 - `-O, --outbound`: giden trafiği dahil eder. (varsayılan: `true`)
 - `-p, --privateIp`: özel IP adreslerini dahil eder (varsayılan: `false`)
 - `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)
 - `-s, --skipProgressBar`: "ilerleme çubuğunu görüntülemez (varsayılan: `false`)

### `list-ip-addresses` komut örnekleri

JSONL zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Sonuçları bir metin dosyasına kaydedin:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt
```

Gelen trafiği hariç tutun:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -i=false
```

Özel IP adreslerini dahil edin:

```
takajo.exe list-ip-addresses -t ../hayabusa/timeline.jsonl -o ipAddresses.txt -p
```

## `list-undetected-evtx` komutu

Hayabusa'nın bir algılama kuralına sahip olmadığı tüm `.evtx` dosyalarını listeler.
Bu, [hayabusa-sample-evtx](https://github.com/Yamato-Security/hayabusa-evtx) deposundaki örnek evtx dosyaları gibi, tümü kötü amaçlı etkinlik kanıtı içeren örnek evtx dosyalarında kullanılmak üzere tasarlanmıştır.

* Girdi: CSV
* Profil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Öncelikle Hayabusa'yı `%EvtxFile%` sütun bilgisini kaydeden bir profille çalıştırmanız ve sonuçları bir CSV zaman çizelgesine kaydetmeniz gerekir.
  > Hayabusa'nın farklı profillere göre hangi sütunları kaydettiğini [buradan](https://github.com/Yamato-Security/hayabusa#profiles) görebilirsiniz.
* Çıktı: Terminal veya metin dosyası

Gerekli seçenekler:

- `-e, --evtx-dir <EVTX-DIR>`: Hayabusa ile taradığınız `.evtx` dosyalarının dizini.
- `-t, --timeline <CSV-FILE>`: Hayabusa CSV zaman çizelgesi.

Seçenekler:

- `-c, --column-name <CUSTOM-EVTX-COLUMN>`: evtx sütunu için özel bir sütun adı belirtin. (varsayılan: Hayabusa'nın varsayılanı olan `EvtxFile`)
- `-o, --output <TXT-FILE>`: sonuçları bir metin dosyasına kaydeder. (varsayılan: ekrana çıktı verir)
- `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)

### `list-undetected-evtx` komut örnekleri

CSV zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Sonuçları ekrana çıkarın:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR>
```

Sonuçları bir metin dosyasına kaydedin:

```
takajo.exe list-undetected-evtx -t ../hayabusa/timeline.csv -e <EVTX-DIR> -o undetected-evtx.txt
```

## `list-unused-rules` komutu

Hiçbir şey algılamayan tüm `.yml` algılama kurallarını listeler.
Bu, kuralların güvenilirliğini belirlemeye yardımcı olmak için faydalıdır.
Yani, hangi kuralların kötü amaçlı etkinlik bulduğu bilinen kurallar olduğunu ve hangilerinin hâlâ test edilmemiş olduğunu ve örnek `.evtx` dosyalarına ihtiyaç duyduğunu belirlemeye yarar.

* Girdi: CSV
* Profil: `verbose`, `all-field-info-verbose`, `super-verbose`, `timesketch-verbose`
  > Öncelikle Hayabusa'yı `%RuleFile%` sütun bilgisini kaydeden bir profille çalıştırmanız ve sonuçları bir CSV zaman çizelgesine kaydetmeniz gerekir.
  > Hayabusa'nın farklı profillere göre hangi sütunları kaydettiğini [buradan](https://github.com/Yamato-Security/hayabusa#profiles) görebilirsiniz.
* Çıktı: Terminal veya metin dosyası

Gerekli seçenekler:

- `-r, --rules-dir <DIR>`: Hayabusa ile kullandığınız `.yml` kural dosyalarının dizini.
- `-t, --timeline <CSV-FILE>`: Hayabusa tarafından oluşturulan CSV zaman çizelgesi.

Seçenekler:

- `-c, --column-name <CUSTOM-RULE-FILE-COLUMN>`: kural dosyası sütunu için özel bir sütun adı belirtin. (varsayılan: Hayabusa'nın varsayılanı olan `RuleFile`)
- `-o, --output <TXT-FILE>`: sonuçları bir metin dosyasına kaydeder. (varsayılan: ekrana çıktı verir)
- `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)

### `list-unused-rules` komut örnekleri

CSV zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe csv-timeline -d <EVTX-DIR> -p verbose -o timeline.csv -w
```

Sonuçları ekrana çıkarın:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules
```

Sonuçları bir metin dosyasına kaydedin:

```
takajo.exe list-unused-rules -t ../hayabusa/timeline.csv -r ../hayabusa/rules -o unused-rules.txt
```

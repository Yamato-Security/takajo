# Yığınlama Komutları

## `stack-cmdlines` komutu

Bu komut, `Sysmon 1` ve `Security 4688` olaylarından bilgi çıkararak çalıştırılan komut satırlarını yığınlar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-y, --ignoreSysmon`: Sysmon 1 olaylarını hariç tut (varsayılan: `false`)
- `-e, --ignoreSecurity`: Security 4688 olaylarını hariç tut (varsayılan: `false`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-cmdlines` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-cmdlines -t ../hayabusa/timeline.jsonl -o stack-cmdlines.csv
```

## `stack-computers` komutu

Bu komut, `Computer` alanına göre bilgisayar ana bilgisayar adlarını yığınlar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-c, --sourceComputers`: hedef bilgisayarlar yerine kaynak bilgisayarları yığınla (varsayılan: false)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-computers` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-computers -t ../hayabusa/timeline.jsonl -o stack-computers.csv
```

## `stack-dns` komutu

Bu komut, Sysmon 22 olaylarından DNS sorgularını ve yanıtlarını yığınlar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-dns` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-dns -t ../hayabusa/timeline.jsonl -o stack-dns.csv
```

## `stack-ip-addresses` komutu

Bu komut, hedef IP adreslerini (`TgtIP` alanı) veya kaynak IP adreslerini (`SrcIP` alanı) yığınlar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-a, --targetIpAddresses`: kaynak IP adresleri yerine hedef IP adreslerini yığınla (varsayılan: `false`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-ip-addresses` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-ip-addresses -t ../hayabusa/timeline.jsonl -o stack-ip-addresses.csv
```

## `stack-logons` komutu

`Target User`, `Target Computer`, `Logon Type`, `Source IP Address`, `Source Computer` alanlarına göre oturum açma listesi oluşturur.
Varsayılan olarak, kaynak IP adresi yerel bir IP adresi olduğunda sonuçlar filtrelenir.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --localSrcIpAddresses`: kaynak IP adresi yerel olduğunda sonuçları dahil et.
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-logons` komut örnekleri

Varsayılan ayarlarla çalıştırma:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl
```

Yerel oturum açmaları dahil etme:

```
takajo.exe stack-logons -t ../hayabusa/timeline.jsonl -l
```

## `stack-processes` komutu

Bu komut, Sysmon 1 ve Security 4688 olaylarından çalıştırılan işlemleri yığınlar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `low`)
- `-y, --ignoreSysmon`: Sysmon 1 olaylarını hariç tut (varsayılan: `false`)
- `-e, --ignoreSecurity`: Security 4688 olaylarını hariç tut (varsayılan: `false`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-processes` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-processes -t ../hayabusa/timeline.jsonl -o stack-processes.csv
```

## `stack-services` komutu

Bu komut, System 7040 ve Security 4697 olaylarından hizmet adlarını ve yollarını yığınlar.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-y, --ignoreSystem`: System 7040 olaylarını hariç tut (varsayılan: `false`)
- `-e, --ignoreSecurity`: Security 4697 olaylarını hariç tut (varsayılan: `false`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-services` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-services -t ../hayabusa/timeline.jsonl -o stack-services.csv
```

## `stack-tasks` komutu

Bu komut, Security 4698 olaylarından yeni zamanlanmış görevleri yığınlar ve XML görev içeriğini ayrıştırır.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-tasks` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-tasks -t ../hayabusa/timeline.jsonl -o stack-tasks.csv
```

## `stack-users` komutu

Bu komut, hedef kullanıcıları (`TgtUser` alanı (varsayılan)) veya kaynak kullanıcıları (`SrcUser` alanı) bu alanlara sahip herhangi bir olayda yığınlar ve ayrıca uyarı bilgilerini gösterir.

* Girdi: JSONL
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: Terminal veya CSV dosyası

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-s, --sourceUsers`: hedef kullanıcılar yerine kaynak kullanıcıları yığınla (varsayılan: false)
- `-c, --filterComputerAccounts`: bilgisayar hesaplarını filtrele (varsayılan: true)
- `-f, --filterSystemAccounts`: sistem hesaplarını filtrele (varsayılan: true)
- `-l, --level`: minimum uyarı düzeyini belirtin (varsayılan: `informational`)
- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası (varsayılan: `stdout`)
- `-q, --quiet`: logoyu gösterme. (varsayılan: `false`)
- `-s, --skipProgressBar`: ilerleme çubuğunu gösterme (varsayılan: `false`)

### `stack-users` komut örnekleri

Terminale çıktı verme:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl
```

CSV'ye kaydetme:

```
takajo.exe stack-users -t ../hayabusa/timeline.jsonl -o stack-users.csv
```

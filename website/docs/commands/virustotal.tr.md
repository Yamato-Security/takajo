# VirusTotal Komutları

## `vt-domain-lookup` komutu

VirusTotal üzerinde bir alan adı listesini sorgular

* Girdi: Metin dosyası
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: CSV

Gerekli seçenekler:

- `-a, --apiKey <API-KEY>`: VirusTotal API anahtarınız.
- `-d, --domainList <TXT-FILE>`: alan adlarının bulunduğu bir metin dosyası listesi.
- `-o, --output <CSV-FILE>`: sonuçları bir CSV dosyasına kaydeder.

Seçenekler:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal'dan gelen tüm JSON yanıtlarını bir JSON dosyasına çıktı olarak verir.
- `-r, --rateLimit <NUMBER>`: dakikada istek gönderme oranı. (varsayılan: `4`)
- `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)

### `vt-domain-lookup` komutu örnekleri

Önce `list-domains` komutuyla bir alan adı listesi oluşturun.
Ardından bu alan adlarını aşağıdaki şekilde sorgulayın:

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup` komutu

VirusTotal üzerinde bir hash listesini sorgular.

* Girdi: Metin dosyası
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: CSV

Gerekli seçenekler:

- `-a, --apiKey <API-KEY>`: VirusTotal API anahtarınız.
- `-H, --hashList <HASH-LIST>`: hashlerin bulunduğu bir metin dosyası.
- `-o, --output <CSV-FILE>`: sonuçları bir CSV dosyasına kaydeder.

Seçenekler:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal'dan gelen tüm JSON yanıtlarını bir JSON dosyasına çıktı olarak verir.
- `-r, --rateLimit <NUMBER>`: dakikada istek gönderme oranı. (varsayılan: `4`)
- `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)

### `vt-hash-lookup` komutu örnekleri

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup` komutu

VirusTotal üzerinde bir IP adresi listesini sorgular.

* Girdi: Metin dosyası
* Profil: `all-field-info` ve `all-field-info-verbose` dışında herhangi biri
* Çıktı: CSV

Gerekli seçenekler:

- `-a, --apiKey <API-KEY>`: VirusTotal API anahtarınız.
- `-i, --ipList <IP-ADDRESS-LIST>`: IP adreslerinin bulunduğu bir metin dosyası.
- `-o, --output <CSV-FILE>`: sonuçları bir CSV dosyasına kaydeder.

Seçenekler:

- `-j, --jsonOutput <JSON-FILE>`: VirusTotal'dan gelen tüm JSON yanıtlarını bir JSON dosyasına çıktı olarak verir.
- `-r, --rateLimit <NUMBER>`: dakikada istek gönderme oranı. (varsayılan: `4`)
- `-q, --quiet`: logoyu görüntülemez. (varsayılan: `false`)

### `vt-ip-lookup` komutu örnekleri

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```

# TTP Komutları

## `ttp-summary` komutu

Bu komut, sigma kurallarının `tags` alanında tanımlanan MITRE ATT&CK TTP'lerine göre her bilgisayarda bulunan taktikleri ve teknikleri özetler.

* Girdi: JSONL
* Profil: `%MitreTactics%` ve `%MitreTags%` alanlarını çıktılayan bir profil. (Örn: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Çıktı: Terminal veya CSV

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-o, --output <CSV-FILE>`: sonuçların kaydedileceği CSV dosyası.
- `-q, --quiet`: logoyu görüntüleme. (varsayılan: `false`)

### `ttp-summary` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesi hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTP özetini terminale yazdırın:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Sonuçları bir CSV dosyasına kaydedin:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### `ttp-summary` ekran görüntüsü

![ttp-summary](../assets/screenshots/ttp-summary.png)

## `ttp-visualize` komutu

Bu komut TTP'leri çıkarır ve [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) içinde görselleştirmek için bir JSON dosyası oluşturur.

* Girdi: JSONL
* Profil: `%MitreTactics%` ve `%MitreTags%` alanlarını çıktılayan bir profil. (Örn: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Çıktı: JSON

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya JSONL dosyalarının bulunduğu dizin

Seçenekler:

- `-o, --output <JSON-FILE>`: sonuçların kaydedileceği JSON dosyası. (varsayılan: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: logoyu görüntüleme. (varsayılan: `false`)

### `ttp-visualize` komutu örnekleri

Hayabusa ile JSONL zaman çizelgesi hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

TTP'leri çıkarın ve `mitre-ttp-heatmap.json` dosyasına kaydedin:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

[https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/) adresini açın, `Open Existing Layer` üzerine tıklayın ve kaydedilen JSON dosyasını yükleyin.

### `ttp-visualize` ekran görüntüsü

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## `ttp-visualize-sigma` komutu

Bu komut Sigma'dan TTP'leri çıkarır ve [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) içinde görselleştirmek için bir JSON dosyası oluşturur.

* Girdi: Sigma kuralları dizini
* Çıktı: JSON

Gerekli seçenekler:

- `-r, --ruleDir <SIGMA-DIR>`: Sigma kuralları dizini

Seçenekler:

- `-o, --output <JSON-FILE>`: sonuçların kaydedileceği JSON dosyası. (varsayılan: `mitre-attack-navigator.json`)
- `-q, --quiet`: logoyu görüntüleme. (varsayılan: `false`)

### `ttp-visualize-sigma` komutu örnekleri

Sigma deposunu klonlayın:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Sigma'dan TTP'leri çıkarın ve `mitre-attack-navigator.json` dosyasına kaydedin:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

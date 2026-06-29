# Çıkarma Komutları

## `extract-scriptblocks` komutu

PowerShell EID 4104 betik bloğu günlüklerini çıkarır ve yeniden birleştirir.

> Not: PowerShell betikleri, kod söz dizimi vurgulamasıyla birlikte `.ps1` dosyaları olarak açıldığında en iyi şekilde görüntülenir, ancak kötü amaçlı kodun yanlışlıkla çalıştırılmasını önlemek için `.txt` uzantısını kullanıyoruz.

* Girdi: JSONL
* Profil: Herhangi
* Çıktı: Terminal ve PowerShell Betikleri dizini

Gerekli seçenekler:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: Hayabusa JSONL zaman çizelgesi dosyası veya dizini

Seçenekler:

 - `-l, --level`: minimum uyarı seviyesini belirtin (varsayılan: `low`)
 - `-o, --output`: çıktı dizini (varsayılan: `scriptblock-logs`)
 - `-q, --quiet`: başlangıç afişini görüntüleme (varsayılan: `false`)
 - `-s, --skipProgressBar`: ilerleme çubuğunu görüntüleme (varsayılan: `false`)

### `extract-scriptblocks` komutu örneği

JSONL zaman çizelgesini Hayabusa ile hazırlayın:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

PowerShell EID 4104 betik bloğu günlüklerini `scriptblock-logs` dizinine çıkarın:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### `extract-scriptblocks` ekran görüntüsü

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

# Komut Listesi

## Otomasyon Komutları
* `automagic`: mümkün olduğunca çok komutu otomatik olarak çalıştırır ve sonuçları yeni bir klasöre çıktı olarak verir

## Çıkarma Komutları
* `extract-scriptblocks`: PowerShell EID 4104 betik bloğu günlüklerini çıkarır ve yeniden birleştirir

## HTML Komutları
* `html-report`: statik HTML özet raporları oluşturur
* `html-server`: HTML özet raporlarını görüntülemek için dinamik bir web sunucusu oluşturur

## Liste Komutları
* `list-domains`: `vt-domain-lookup` ile kullanılacak benzersiz alan adlarının bir listesini oluşturur
* `list-hashes`: `vt-hash-lookup` ile kullanılacak işlem karma değerlerinin bir listesini oluşturur
* `list-ip-addresses`: `vt-ip-lookup` ile kullanılacak benzersiz hedef ve/veya kaynak IP adreslerinin bir listesini oluşturur
* `list-undetected-evtx`: tespit edilmemiş evtx dosyalarının bir listesini oluşturur
* `list-unused-rules`: kullanılmayan tespit kurallarının bir listesini oluşturur

## Bölme Komutları
* `split-csv-timeline`: büyük bir CSV zaman çizelgesini bilgisayar adına göre daha küçük olanlara böler
* `split-json-timeline`: büyük bir JSONL zaman çizelgesini bilgisayar adına göre daha küçük olanlara böler

## Yığınlama Komutları
* `stack-cmdlines`: çalıştırılan komut satırlarını yığınlar
* `stack-computers`: bilgisayarları yığınlar
* `stack-dns`: DNS sorgularını ve yanıtlarını yığınlar
* `stack-ip-addresses`: hedef IP adreslerini (`TgtIP` alanı) veya kaynak IP adreslerini (`SrcIP` alanı) yığınlar
* `stack-logons`: oturum açma işlemlerini hedef kullanıcı, hedef bilgisayar, kaynak IP adresi ve kaynak bilgisayara göre yığınlar
* `stack-processes`: çalıştırılan işlemleri yığınlar
* `stack-services`: `System 7040` ve `Security 4697` olaylarından hizmet adlarını ve yollarını yığınlar
* `stack-tasks`: `Security 4698` olaylarından yeni zamanlanmış görevleri yığınlar ve XML görev içeriğini ayrıştırır
* `stack-users`: hedef kullanıcıları (`TgtUser` alanı) veya kaynak kullanıcıları (`SrcUser` alanı) yığınlar

## Sysmon Komutları
* `sysmon-process-tree`: belirli bir işlemin işlem ağacını çıktı olarak verir

## Zaman Çizelgesi Komutları
* `timeline-logon`: oturum açma olaylarının bir CSV zaman çizelgesini oluşturur
* `timeline-partition-diagnostic`: bölüm tanılama olaylarının bir CSV zaman çizelgesini oluşturur
* `timeline-suspicious-processes`: şüpheli işlemlerin bir CSV zaman çizelgesini oluşturur
* `timeline-tasks`: zamanlanmış görevlerin bir CSV zaman çizelgesini oluşturur

## TTP Komutları
* `ttp-summary`: her bilgisayarda bulunan taktikleri ve teknikleri özetler
* `ttp-visualize`: TTP'leri çıkarır ve MITRE ATT&CK Navigator'da görselleştirmek için bir JSON dosyası oluşturur
* `ttp-visualize-sigma`: Sigma kurallarından TTP'leri çıkarır ve MITRE ATT&CK Navigator'da görselleştirmek için bir JSON dosyası oluşturur

## VirusTotal Komutları
* `vt-domain-lookup`: VirusTotal'da bir alan adı listesini arar ve kötü amaçlı olanları raporlar
* `vt-hash-lookup`: VirusTotal'da bir karma değer listesini arar ve kötü amaçlı olanları raporlar
* `vt-ip-lookup`: VirusTotal'da bir IP adresi listesini arar ve kötü amaçlı olanları raporlar

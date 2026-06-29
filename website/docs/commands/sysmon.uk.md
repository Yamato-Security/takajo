# Команди Sysmon

## Команда `sysmon-process-tree`

Виводить дерево процесів певного процесу, наприклад підозрілого або шкідливого процесу.

* Вхідні дані: JSONL
* Профіль: будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихідні дані: термінал або текстовий файл

Обов'язкові параметри:

- `-p, --processGuid <Process GUID>`: process GUID sysmon
- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa у форматі JSONL або каталог із файлами JSONL

Параметри:

- `-o, --output <TXT-FILE>`: текстовий файл для збереження результатів.
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `sysmon-process-tree`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Збережіть результати у текстовому файлі:

```
takajo.exe sysmon-process-tree -t ../hayabusa/timeline.jsonl -p "365ABB72-3D4A-5CEB-0000-0010FA93FD00" -o process-tree.txt
```

### Знімок екрана `sysmon-process-tree`

![sysmon-process-tree](../assets/screenshots/sysmon-process-tree.png)

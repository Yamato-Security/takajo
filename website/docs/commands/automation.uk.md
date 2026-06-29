# Команди автоматизації

## Команда `automagic`

Автоматично виконує якомога більше команд і виводить результати до нової теки

> Примітка: Слід використовувати профіль `verbose` або `super-verbose`, щоб задіяти всі команди.

* Вхідні дані: файл JSONL або тека з файлами JSONL
* Профіль: будь-який, окрім `all-field-info` та `all-field-info-verbose`
* Вихідні дані: нова тека з усіма результатами в різних файлах

Обов'язкові параметри:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або тека часової шкали JSONL від Hayabusa.

Параметри:

- `-d, --displayTable`: відображати таблицю результатів (типово: `false`)
- `-l, --level`: вказати мінімальний рівень сповіщення (типово: `low`)
- `-o, --output`: тека для виведення (типово: `case-1`)
- `-q, --quiet`: не відображати банер запуску (типово: `false`)
- `-s, --skipProgressBar`: не відображати смугу прогресу (типово: `false`)

### Приклади команди `automagic`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Виконайте якомога більше команд Takajo та збережіть результати в теці `case-1`:

```
takajo.exe automagic -t ../hayabusa/timeline.jsonl -o case-1
```

Виконайте якомога більше команд Takajo для теки `hayabusa-results` та збережіть результати в теці `case-1`:

```
takajo.exe automagic -t ../hayabusa/hayabusa-results/ -o case-1
```

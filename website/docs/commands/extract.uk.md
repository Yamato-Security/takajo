# Команди вилучення

## Команда `extract-scriptblocks`

Вилучає та повторно збирає журнали блоків сценаріїв PowerShell EID 4104.

> Примітка: Сценарії PowerShell найкраще відкривати як файли `.ps1` із підсвічуванням синтаксису коду, але ми використовуємо розширення `.txt`, щоб запобігти будь-якому випадковому запуску шкідливого коду.

* Вхідні дані: JSONL
* Профіль: Будь-який
* Вихідні дані: Термінал і каталог сценаріїв PowerShell

Обовʼязкові параметри:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл або каталог часової шкали Hayabusa у форматі JSONL

Параметри:

 - `-l, --level`: вказати мінімальний рівень сповіщення (за замовчуванням: `low`)
 - `-o, --output`: вихідний каталог (за замовчуванням: `scriptblock-logs`)
 - `-q, --quiet`: не відображати банер запуску (за замовчуванням: `false`)
 - `-s, --skipProgressBar`: не відображати індикатор виконання (за замовчуванням: `false`)

### Приклад команди `extract-scriptblocks`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w
```

Вилучіть журнали блоків сценаріїв PowerShell EID 4104 до каталогу `scriptblock-logs`:

```
takajo.exe extract-scriptblocks -t ../hayabusa/timeline.jsonl
```

### Знімок екрана `extract-scriptblocks`

![extract-scriptblocks](../assets/screenshots/extract-scriptblocks.png)

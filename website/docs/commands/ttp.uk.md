# Команди TTP

## Команда `ttp-summary`

Ця команда узагальнює тактики та техніки, виявлені на кожному комп'ютері, відповідно до TTP MITRE ATT&CK, визначених у полі `tags` правил sigma.

* Вхідні дані: JSONL
* Профіль: профіль, що виводить поля `%MitreTactics%` та `%MitreTags%`. (Напр.: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Вихідні дані: термінал або CSV

Обов'язкові параметри:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa JSONL або каталог файлів JSONL

Параметри:

- `-o, --output <CSV-FILE>`: файл CSV для збереження результатів.
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `ttp-summary`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Вивести підсумок TTP у термінал:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl
```

Зберегти результати у файл CSV:

```
takajo.exe ttp-summary -t ../hayabusa/timeline.jsonl -o ttp-summary.csv
```

### Знімок екрана `ttp-summary`

![ttp-summary](../assets/screenshots/ttp-summary.png)

## Команда `ttp-visualize`

Ця команда витягує TTP та створює файл JSON для візуалізації у [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Вхідні дані: JSONL
* Профіль: профіль, що виводить поля `%MitreTactics%` та `%MitreTags%`. (Напр.: `verbose`, `all-field-info-verbose`, `super-verbose`)
* Вихідні дані: JSON

Обов'язкові параметри:

- `-t, --timeline <JSONL-FILE-OR-DIR>`: файл часової шкали Hayabusa JSONL або каталог файлів JSONL

Параметри:

- `-o, --output <JSON-FILE>`: файл JSON для збереження результатів. (за замовчуванням: `mitre-ttp-heatmap.json`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `ttp-visualize`

Підготуйте часову шкалу JSONL за допомогою Hayabusa:

```
hayabusa.exe json-timeline -d <EVTX-DIR> -L -o timeline.jsonl -w -p verbose
```

Витягти TTP та зберегти у `mitre-ttp-heatmap.json`:

```
takajo.exe ttp-visualize -t ../hayabusa/timeline.jsonl
```

Відкрийте [https://mitre-attack.github.io/attack-navigator/](https://mitre-attack.github.io/attack-navigator/), натисніть `Open Existing Layer` та завантажте збережений файл JSON.

### Знімок екрана `ttp-visualize`

![ttp-visualize](../assets/screenshots/ttp-visualize.png)

## Команда `ttp-visualize-sigma`

Ця команда витягує TTP із Sigma та створює файл JSON для візуалізації у [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

* Вхідні дані: каталог правил Sigma
* Вихідні дані: JSON

Обов'язкові параметри:

- `-r, --ruleDir <SIGMA-DIR>`: каталог правил Sigma

Параметри:

- `-o, --output <JSON-FILE>`: файл JSON для збереження результатів. (за замовчуванням: `mitre-attack-navigator.json`)
- `-q, --quiet`: не відображати логотип. (за замовчуванням: `false`)

### Приклади команди `ttp-visualize-sigma`

Клонуйте репозиторій Sigma:

```
git clone https://github.com/SigmaHQ/sigma.git
```

Витягти TTP із Sigma та зберегти у `mitre-attack-navigator.json`:

```
takajo.exe ttp-visualize-sigma -r ../sigma
```

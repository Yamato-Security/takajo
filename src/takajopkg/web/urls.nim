import prologue

import ./controllers/controller
import ./controllers/computers
import ./controllers/summary
import ./controllers/rules

const urlPatterns* = @[
    pattern("/", controller.index),
    pattern("/computer", controller.computer),
    pattern("/computer/summary", controller.computer_summary),
    pattern("/rule/content", controller.rule_content),
    pattern("/img/favicon.png", controller.favicon),
    pattern("/api/computer", computers.computer),
    pattern("/api/computer/summary", computers.summary),
    pattern("/api/summary", summary.list),
    pattern("/api/sidemenu", computers.sidemenu),
    pattern("/api/rules", rules.list),
    pattern("/api/rules/content", rules.getRuleContent),
    pattern("/js/common.js", controller.js_handler),
    pattern("/js/flatpickr.js", controller.js_handler),
    pattern("/js/tailwind.js", controller.js_handler),
    pattern("/js/prism.js", controller.js_handler),
    pattern("/js/prism-yaml.js", controller.js_handler),
    pattern("/js/alpinejs.3.14.1.js", controller.js_handler),
    pattern("/css/prism.css", controller.css_handler),
    pattern("/css/all.css", controller.css_handler),
    pattern("/css/flatpickr.css", controller.css_handler),
    pattern("/webfonts/fa-solid-900.woff2", controller.webfonts_handler),
    pattern("/webfonts/fa-solid-900.ttf", controller.webfonts_handler),
]

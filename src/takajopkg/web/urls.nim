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
    pattern("/js/common.js", controller.commonjs),
    pattern("/img/favicon.png", controller.favicon),
    pattern("/api/computer", computers.computer),
    pattern("/api/computer/summary", computers.summary),
    pattern("/api/summary", summary.list),
    pattern("/api/sidemenu", computers.sidemenu),
    pattern("/api/rules", rules.list),
    pattern("/api/rules/content", rules.getRuleContent),
]

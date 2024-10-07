import prologue

import ./controllers/controller
import ./controllers/computers
import ./controllers/summary

const urlPatterns* = @[
    pattern("/", controller.index),
    pattern("/computer", controller.computer),
    pattern("/computer/summary", controller.computer_summary),
    pattern("/js/common.js", controller.commonjs),
    pattern("/api/computer", computers.computer),
    pattern("/api/computer/summary", computers.summary),
    pattern("/api/summary", summary.list),
    pattern("/api/sidemenu", computers.sidemenu),
]

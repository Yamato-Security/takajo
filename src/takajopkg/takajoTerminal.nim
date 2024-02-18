import nancy
import terminal
import termstyle
import std/strutils

proc outputLogo*(): string =
    let logo = """
╔════╦═══╦╗╔═╦═══╗ ╔╦═══╗
║╔╗╔╗║╔═╗║║║╔╣╔═╗║ ║║╔═╗║
╚╝║║╚╣║ ║║╚╝╝║║ ║║ ║║║ ║║
  ║║ ║╚═╝║╔╗╖║╚═╝╠╗║║║ ║║
 ╔╝╚╗║╔═╗║║║╚╣╔═╗║╚╝║╚═╝║
 ╚══╝╚╝ ╚╩╝╚═╩╝ ╚╩══╩═══╝
  by Yamato Security
"""
    return logo


proc colorWrite*(color: ForegroundColor, ansiEscape: string, txt: string) =
    # Remove ANSI escape sequences and use stdout.styledWrite instead
    let replacedTxt = txt.replace(ansiEscape,"").replace(termClear,"")
    if "│" in replacedTxt:
      stdout.styledWrite(color, replacedTxt.replace("│ ",""))
      stdout.write "│ "
    else:
      stdout.styledWrite(color, replacedTxt)


proc stdoutStyledWrite*(txt: string) =
    if txt.startsWith(termRed):
      colorWrite(fgRed, termRed,txt)
    elif txt.startsWith(termGreen):
      colorWrite(fgGreen, termGreen, txt)
    elif txt.startsWith(termYellow):
      colorWrite(fgYellow, termYellow, txt)
    elif txt.startsWith(termCyan):
      colorWrite(fgCyan, termCyan, txt)
    else:
      stdout.write txt.replace(termClear,"")


proc echoTableSepsWithStyled*(table: TerminalTable, maxSize = terminalWidth(), seps = defaultSeps) =
    # This function equivalent to echoTableSeps without using ANSI escape to avoid the following issue.
    # https://github.com/PMunch/nancy/issues/4
    # https://github.com/PMunch/nancy/blob/9918716a563f64d740df6a02db42662781e94fc8/src/nancy.nim#L195C6-L195C19
    let sizes = table.getColumnSizes(maxSize - 4, padding = 3)
    printSeparator(top)
    for k, entry in table.entries(sizes):
      for _, row in entry():
        stdout.write seps.vertical & " "
        for i, cell in row():
          stdoutStyledWrite cell & (if i != sizes.high: " " & seps.vertical & " " else: "")
        stdout.write " " & seps.vertical & "\n"
      if k != table.rows - 1:
        printSeparator(center)
    printSeparator(bottom)

proc levelColor*(level:string): proc(ss: varargs[string, `$`]): string =
    if "crit" in level:
        return red
    elif "high" in level:
        return yellow
    elif "med" in level:
        return cyan
    elif "low" in level:
        return green
    return white
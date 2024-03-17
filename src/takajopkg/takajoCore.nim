import general
import hayabusaJson
import nancy
import takajoTerminal
import std/enumerate
import std/options
import suru
import times

type CmdResult* = ref object
    results*: string = ""
    savedFiles*: string = ""

type AbstractCmd* = ref object of RootObj
    timeline*: string = ""
    skipProgressBar*: bool
    name*: string = ""
    options*: string = "(default)"
    msg*: string = ""
    output*: string = ""
    cmdResult*: CmdResult = CmdResult(results:"", savedFiles:"")
    displayTable*: bool = true

method filter*(self: AbstractCmd, x: HayabusaJson):bool {.base.} =
  return true

method analyze*(self: AbstractCmd, x: HayabusaJson) {.base.} =
  raise newException(ValueError, "analyze(AbstractCmd) is not implemented")

method resultOutput*(self: AbstractCmd) {.base.} =
  raise newException(ValueError, "resultOutput(AbstractCmd) is not implemented")

proc analyzeJSONLFile*(self: AbstractCmd, cmds: seq[AbstractCmd] = newSeq[AbstractCmd]()) =
    let startTime = epochTime()
    var commands = cmds
    if commands.len() == 0:
        # automagic以外では、自身のオブジェクトだけを実行
        commands = @[self]

    var bar: SuruBar
    if not self.skipProgressBar:
        bar = initSuruBar()
        bar[0].total = countJsonlAndStartMsg(self.name, self.msg, self.timeline)
        bar.setup()

    for line in lines(self.timeline):
        if not self.skipProgressBar:
            inc bar
            bar.update(1000000000)
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()
        for cmd in commands:
            try:
                if cmd.filter(jsonLine):
                    cmd.analyze(jsonLine)
            except CatchableError:
                continue

    if not self.skipProgressBar:
      bar.finish()

    var resultSummaryTable:seq[CmdResult] = @[]
    for cmd in commands:
        cmd.resultOutput()
        resultSummaryTable.add(cmd.cmdResult)

    if resultSummaryTable.len > 1:
        # automagicコマンドの時だけ、最後に全コマンドまとめたサマリを出力する
        var table: TerminalTable
        table.add @["Command", "Results", "Saved Files"]
        for i, result in enumerate(resultSummaryTable):
            table.add commands[i].name, result.results, result.savedFiles
        echo ""
        table.echoTableSepsWithStyled(seps = boxSeps)

    outputElapsedTime(startTime)
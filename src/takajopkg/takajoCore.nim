import general
import hayabusaJson
import std/options
import suru
import times

type
  AbstractCmd* = ref object of RootObj
    timeline*: string
    skipProgressBar*: bool
    name*: string
    msg*: string
    output*: string

method filter*(self: AbstractCmd, x: HayabusaJson):bool {.base.} =
  raise newException(ValueError, "filterHayabusaJSON is not implemented")

method analyze*(self: AbstractCmd, x: HayabusaJson) {.base.} =
  raise newException(ValueError, "analyzeHayabusaJSON is not implemented")

method resultOutput*(self: AbstractCmd) {.base.} =
  raise newException(ValueError, "resultOutput is not implemented")

proc analyzeJSONLFile*(self: AbstractCmd) =
    let startTime = epochTime()
    var bar: SuruBar
    let skipProgressBar = self.skipProgressBar
    let timeline = self.timeline

    if not skipProgressBar:
        bar = initSuruBar()
        bar[0].total = countJsonlAndStartMsg(self.name, self.msg, timeline)
        bar.setup()

    for line in lines(timeline):
        if not skipProgressBar:
            inc bar
            bar.update(1000000000)
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()
        if self.filter(jsonLine):
            self.analyze(jsonLine)
    if not skipProgressBar:
      bar.finish()
    self.resultOutput()
    outputElapsedTime(startTime)

proc analyzeJSONLFileWithMultipleCmd*(baseCmd:AbstractCmd , cmds: seq[AbstractCmd]) =
    let startTime = epochTime()
    var bar: SuruBar
    let skipProgressBar = baseCmd.skipProgressBar
    let timeline = baseCmd.timeline

    if not skipProgressBar:
        bar = initSuruBar()
        bar[0].total = countJsonlAndStartMsg(baseCmd.name, baseCmd.msg, timeline)
        bar.setup()

    for line in lines(timeline):
        if not skipProgressBar:
            inc bar
            bar.update(1000000000)
        let jsonLineOpt = parseLine(line)
        if jsonLineOpt.isNone:
            continue
        let jsonLine:HayabusaJson = jsonLineOpt.get()
        for cmd in cmds:
            if cmd.filter(jsonLine):
                cmd.analyze(jsonLine)
    if not skipProgressBar:
      bar.finish()

    for cmd in cmds:
        cmd.resultOutput()
    outputElapsedTime(startTime)
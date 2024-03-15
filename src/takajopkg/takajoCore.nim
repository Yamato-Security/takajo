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
  return true

method analyze*(self: AbstractCmd, x: HayabusaJson) {.base.} =
  raise newException(ValueError, "analyze(AbstractCmd) is not implemented")

method resultOutput*(self: AbstractCmd) {.base.} =
  raise newException(ValueError, "resultOutput(AbstractCmd) is not implemented")

proc analyzeJSONLFile*(self: AbstractCmd, cmds: seq[AbstractCmd] = newSeq[AbstractCmd]()) =
    let startTime = epochTime()
    var bar: SuruBar
    let skipProgressBar = self.skipProgressBar
    let timeline = self.timeline
    var commands = cmds
    if commands.len() == 0:
        commands = @[self]
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
        for cmd in commands:
            try:
                if cmd.filter(jsonLine):
                    cmd.analyze(jsonLine)
            except CatchableError:
                continue
    if not skipProgressBar:
      bar.finish()
    for cmd in commands:
        cmd.resultOutput()
    outputElapsedTime(startTime)
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

method eventFilter*(self: AbstractCmd, x: HayabusaJson):bool {.base.} =
  raise newException(ValueError, "eventFilter is not implemented")

method eventProcess*(self: AbstractCmd, x: HayabusaJson){.base.}=
  raise newException(ValueError, "eventProcess is not implemented")

method resultOutput*(self: AbstractCmd) {.base.} =
  raise newException(ValueError, "resultOutput is not implemented")

proc analyzeJSONLLine*(self: AbstractCmd, x: HayabusaJson) =
    if self.eventFilter(x):
        self.eventProcess(x)

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
        self.analyzeJSONLLine(jsonLine)
    if not skipProgressBar:
      bar.finish()
    self.resultOutput()
    outputElapsedTime(startTime)
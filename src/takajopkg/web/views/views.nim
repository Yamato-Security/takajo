import json
import prologue
import ./templates/index_view

proc index*(ctx: Context) {.async.} =
  resp index_view.render()

proc store*(ctx: Context) {.async.} =
  try:
    let params = ctx.request.body.parseJson
    let name = params["name"].getStr
    let response = %*{"message": "Hello " & name}
    resp jsonResponse(response)
  except Exception:
    let response = %*{"message": "エラーが発生しました"}
    resp jsonResponse(response, Http400)

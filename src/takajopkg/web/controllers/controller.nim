import json
import prologue
import ./computers
#import ../views/views

proc index*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("index.html", "src/takajopkg/web/static")

#
# Computer Page
#
proc computer*(ctx: Context) {.async.} =
  let computer = ctx.request.queryParams.getOrDefault("computer", "")
  
  await ctx.staticFileResponse("content.html", "src/takajopkg/web/static")

#
# Computer Summary Page
#
proc computer_summary*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("computer_summary.html", "src/takajopkg/web/static")


proc commonjs*(ctx: Context) {.async.} = 
  await ctx.staticFileResponse("js/common.js", "src/takajopkg/web/static")
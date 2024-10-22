import prologue

proc index*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("index.htm", "src/takajopkg/web/static")

#
# Computer Page
#
proc computer*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("content.htm", "src/takajopkg/web/static")

#
# Computer Summary Page
#
proc computer_summary*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("computer_summary.htm", "src/takajopkg/web/static")


proc commonjs*(ctx: Context) {.async.} = 
  await ctx.staticFileResponse("js/common.js", "src/takajopkg/web/static")

proc favicon*(ctx: Context) {.async.} = 
  await ctx.staticFileResponse("img/favicon.png", "src/takajopkg/web/static")
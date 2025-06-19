import prologue

proc index*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("index.htm", "templates/static")

#
# Computer Page
#
proc computer*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("content.htm", "templates/static")

#
# Computer Summary Page
#
proc computer_summary*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("computer_summary.htm", "templates/static")

#
# Rule Content Page
#
proc rule_content*(ctx: Context) {.async.} =
  await ctx.staticFileResponse("rule.htm", "templates/static")


proc commonjs*(ctx: Context) {.async.} = 
  await ctx.staticFileResponse("js/common.js", "templates/static")

proc favicon*(ctx: Context) {.async.} = 
  await ctx.staticFileResponse("img/favicon.png", "templates/static")
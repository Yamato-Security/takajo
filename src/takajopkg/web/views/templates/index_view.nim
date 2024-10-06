import karax / [karaxdsl, vdom]

proc render*(): string =
  let vnode = buildHtml(tdiv(class = "mt-3")):
    h1: text("Hello World")
  result = $vnode
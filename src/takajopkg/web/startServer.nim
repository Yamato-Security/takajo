import prologue
import prologue/middlewares/staticfile
import urls

#
#
#
proc initialServer(port: int) =

    var f = open("./templates/common.js", FileMode.fmRead)

    var html = ""
    while f.endOfFile == false :
        html &= f.readLine() & "\n"
    f.close()

    html = html.replace("[%PORT%]", $port)
    
    var write = open("./src/takajopkg/web/static/js/common.js", FileMode.fmWrite)
    write.writeLine(html)
    write.close()


#
# Server Settings
# 
proc startServer*(sqlite: string, rulepath: string, port: int = 8089) =
    
    if fileExists(sqlite) == false:
        echo "Not found sqlite file: " & sqlite
        return

    initialServer(port)

    let settings = newSettings(
        appName = sqlite,
        debug = true,
        port = Port(port)
    )

    let app = newApp(settings = settings)
    app.addRoute(urls.urlPatterns, "")    
    app.run()


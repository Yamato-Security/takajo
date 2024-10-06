import prologue
import prologue/middlewares/staticfile
import urls

#
# Server Settings
# 
proc startServer*(sqlite: string, rulepath: string, port: int = 8089) =
    
    if fileExists(sqlite) == false:
        echo "Not found sqlite file: " & sqlite
        return

    let settings = newSettings(
        appName = sqlite,
        debug = true,
        port = Port(port)
    )

    let app = newApp(settings = settings)
    app.addRoute(urls.urlPatterns, "")    
    app.run()

    


import Skribent
import os.log

extension Tag {
    static var appStore: Tag {
        return Tag(name: "App Store", prefix: "💰")
    }
}

enum AppStoreErrors: Error {
    case appStoreOffline
}

class ExamplePlugin: Plugin {
    func log(level: LogLevel, tag: Tag?, file: String, functionName: String, line: Int, production: Bool) {
        // log to Crashlytics/Logstash
    }
}


class App {
    func initLogger() {
        let plugin = ExamplePlugin()
        Skribent.add(plugin: plugin)
        Skribent.runInProductionMode = false
    }

    func run() {
        Skribent.log(level: .info("This is an info"))
        Skribent.log(level: .debug("This is a debug"))
        Skribent.log(level: .error("This is an error", AppStoreErrors.appStoreOffline))
        Skribent.log(level: .warning("This is a warning"))

        Skribent.log(level: .info("Info with tag"), tag: .appStore)
        Skribent.log(level: .debug("Debug with tag"), tag: .appStore)
        Skribent.log(level: .error("Error with tag", AppStoreErrors.appStoreOffline), tag: .appStore)
        Skribent.log(level: .warning("Warning with tag"), tag: .appStore)
    }
}

let app = App()
app.run()

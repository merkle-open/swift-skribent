#  Skribent 📜

>  Norsk: skribent m1 (fra latin av scribere 'skrive') forfatter, særlig av essay og avhandlinger eller artikler i dagspressen

>  Deutsch: Vielschreiber, Schreiberling (zu lateinisch scribens (Genitiv: scribentis), 1. Partizip von: scribere = schreiben)

Skribent is an easy zero config Logger which still can be extended at some point and is typesafe

```swift
Skribent.log(level: .info("This is an info"))
Skribent.log(level: .debug("This is a debug"))
Skribent.log(level: .error("This is an error", AppStoreErrors.appStoreOffline))
Skribent.log(level: .warning("This is a warning"))
```

# What and where is logged

Skribent uses the unified logging system provided by Apple if possible. This means all messages get logged into
the developer console and device console as well the levels `error` and `warning` are persisted to the data store.
This means those logs are accessible even after the App stopped to run.

The unified logging system is only usable for apps running on OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0 or newer.
For older system the `NSLog` class is used for logging which also logs to the developer and device console. But no
persistence features here.

## Production mode

It's discouraged to log into the device console in production therefore can logging to the console be disabled
with a flag

```swift
Skribent.runInProductionMode = true
```

Logs are still passed to plugins despite active production mode.

# Features

### Tags

Tags are groups of logs which belong together. A tag is defined with a name and a prefix which are displayed in the logs.
To tidy up your logs for debug purposes or disable some log in production it's possible to ignore tags.

```swift
extension Tag {
    static var appStore: Tag {
        return Tag(name: "App Store", prefix: "💰")
    }
}

Skribent.shared.ignore(tag: .appStore)
Skribent.shared.unignore(tag: .appStore)
```

Logs of ignored tags are no passed down to plugins.

### Plugins

Its possible to implement plugins which are get the same information passed as the log method and 
additionally the production mode
````swift
class ExamplePlugin: Plugin {
    func log(level: LogLevel, tag: Tag?, file: String, functionName: String, line: Int, production: Bool) {
        // log to Crashlytics/Logstash
    }
}

let plugin = ExamplePlugin()
Skribent.add(plugin: plugin)
````


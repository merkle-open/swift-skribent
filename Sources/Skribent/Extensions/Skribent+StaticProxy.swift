import Foundation

// This extension serves as static proxy for the logger
extension Skribent {
    public static func log(
            level: LogLevel,
            tag: Tag? = nil,
            file: String = #file,
            functionName: String = #function,
            line: Int = #line) {
        Skribent.shared.log(level: level, tag: tag, file: file, functionName: functionName, line: line)
    }

    public static var runInProductionMode: Bool {
        get {
            return Skribent.shared.productionMode
        }
        set {
            Skribent.shared.productionMode = newValue
        }
    }

    public static func add(plugin: Plugin) {
        Skribent.shared.add(plugin: plugin)
    }

    public static func ignore(tag: Tag) {
        Skribent.shared.ignore(tag: tag)
    }

    public static func unignore(tag: Tag) {
        Skribent.shared.unignore(tag: tag)
    }
}
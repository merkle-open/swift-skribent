import Foundation

public protocol Loggable {
    func log(
            level: LogLevel,
            tag: Tag?,
            file: String,
            functionName: String,
            line: Int)
    func add(plugin: Plugin)
    func ignore(tag: Tag)
    func unignore(tag: Tag)
}

import Foundation

public protocol Plugin {
    func log(
        level: LogLevel,
        tag: Tag?,
        file: String,
        functionName: String,
        line: Int,
        production: Bool)
}

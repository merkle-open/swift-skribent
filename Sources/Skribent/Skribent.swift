import Foundation
import os.log

public class Skribent: Loggable {
    private var plugins = [Plugin]()
    private var ignoredTags = Set<Tag>()
    private(set) public static var shared = Skribent()
    var productionMode = false

    init() {
    }

    public func add(plugin: Plugin) {
        plugins.append(plugin)
    }

    public func ignore(tag: Tag) {
        self.ignoredTags.insert(tag)
    }

    public func unignore(tag: Tag) {
        self.ignoredTags.remove(tag)
    }


    public func log(
            level: LogLevel,
            tag: Tag? = nil,
            file: String = #file,
            functionName: String = #function,
            line: Int = #line) {

        if let tag = tag,
           ignoredTags.contains(tag) {
            return
        }

        if !productionMode {
            let unifiedPrefix = [level.prefix, tag?.prefix ?? "", tag?.name ?? ""].joined(separator: " ")

            let formatString: StaticString = "%@ %@ Line %i %@"
            let formatStringError: StaticString = "%@ %@ Line %i %@ Error: %@"

            switch level {
            case .debug(let message), .info(let message), .warning(let message):

                if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
                    os_log(formatString,
                            log: OSLog.default,
                            type: level.osLevel,
                            unifiedPrefix,
                            file.lastPathComponent,
                            line,
                            message.description)
                } else {
                    NSLog(formatString.description,
                            unifiedPrefix,
                            file.lastPathComponent,
                            line,
                            message.description)
                }

            case .error(let message, let error):

                if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
                    os_log(formatStringError,
                            log: OSLog.default,
                            type: level.osLevel,
                            unifiedPrefix,
                            file.lastPathComponent,
                            line,
                            message.description,
                            error.localizedDescription)
                } else {
                    NSLog(formatStringError.description,
                            unifiedPrefix,
                            file.lastPathComponent,
                            line,
                            message.description,
                            error.localizedDescription)
                }

            }
        }

        plugins.forEach {
            $0.log(level: level, tag: tag, file: file, functionName: functionName, line: line, production: self.productionMode)
        }
    }

}

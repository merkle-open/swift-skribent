import Foundation
import os.log

public enum LogLevel {
    case debug(CustomStringConvertible)
    case info(CustomStringConvertible)
    case warning(CustomStringConvertible)
    case error(CustomStringConvertible, Error)

    var prefix: String {
        switch self {
        case .error: return "❌"
        case .warning: return "⚠️"
        case .info: return "ℹ️"
        case .debug: return "🔨"
        }
    }

    @available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
    var osLevel: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .error
        case .error:
            return .error
        }
    }
}

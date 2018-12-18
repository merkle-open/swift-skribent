import Foundation

extension String {
    var lastPathComponent: String {
        return String(self.split(separator: "/").last ?? "")
    }
}

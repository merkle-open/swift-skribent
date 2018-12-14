import Foundation

public struct Tag {
    public init(name: String, prefix: String) {
        self.name = name
        self.prefix = prefix
    }
    var name: String
    var prefix: String
}

extension Tag: Hashable {
    public static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name && lhs.prefix == rhs.prefix
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(prefix)
    }
}

import Foundation

public struct MoodGroup: Identifiable, Hashable {
    public let id: UUID
    public var name: String
    public var description: String
    public var memberAvatars: [String]
    public var category: String

    public init(
        id: UUID = UUID(),
        name: String,
        description: String = "",
        memberAvatars: [String] = [],
        category: String = "DISCUSSION"
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.memberAvatars = memberAvatars
        self.category = category
    }
}

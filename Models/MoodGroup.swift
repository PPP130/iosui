import Foundation

struct MoodGroup: Identifiable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var memberAvatars: [String]
    var category: String

    init(
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

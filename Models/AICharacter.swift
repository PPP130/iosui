import Foundation

struct AICharacter: Identifiable, Hashable {
    let id: UUID
    var name: String
    var colorHex: String
    var personality: String
    var isSelected: Bool

    init(
        id: UUID = UUID(),
        name: String,
        colorHex: String,
        personality: String = "",
        isSelected: Bool = false
    ) {
        self.id = id
        self.name = name
        self.colorHex = colorHex
        self.personality = personality
        self.isSelected = isSelected
    }
}

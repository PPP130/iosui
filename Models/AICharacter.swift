import Foundation

public struct AICharacter: Identifiable, Hashable {
    public let id: UUID
    public var name: String
    public var colorHex: String
    public var personality: String
    public var isSelected: Bool

    public init(
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

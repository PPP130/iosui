import Foundation

public struct Message: Identifiable, Hashable {
    public let id: UUID
    public var senderId: UUID
    public var text: String
    public var isFromCurrentUser: Bool
    public var timestamp: Date

    public init(
        id: UUID = UUID(),
        senderId: UUID,
        text: String,
        isFromCurrentUser: Bool,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.senderId = senderId
        self.text = text
        self.isFromCurrentUser = isFromCurrentUser
        self.timestamp = timestamp
    }
}

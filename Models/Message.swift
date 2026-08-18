import Foundation

struct Message: Identifiable, Hashable {
    let id: UUID
    var senderId: UUID
    var text: String
    var isFromCurrentUser: Bool
    var timestamp: Date

    init(
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

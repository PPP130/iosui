import Foundation

public struct User: Identifiable, Hashable {
    public let id: UUID
    public var name: String
    public var avatarColor: String
    public var bio: String
    public var coinBalance: Int
    public var isFollowing: Bool

    public init(
        id: UUID = UUID(),
        name: String,
        avatarColor: String,
        bio: String = "",
        coinBalance: Int = 0,
        isFollowing: Bool = false
    ) {
        self.id = id
        self.name = name
        self.avatarColor = avatarColor
        self.bio = bio
        self.coinBalance = coinBalance
        self.isFollowing = isFollowing
    }
}

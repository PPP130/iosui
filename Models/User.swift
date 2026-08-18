import Foundation

struct User: Identifiable, Hashable {
    let id: UUID
    var name: String
    var avatarColor: String
    var bio: String
    var coinBalance: Int
    var isFollowing: Bool

    init(
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

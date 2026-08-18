import Foundation

public struct Post: Identifiable, Hashable {
    public let id: UUID
    public var author: User
    public var text: String
    public var imageName: String
    public var moodTag: String
    public var likes: Int
    public var comments: Int
    public var createdAt: Date

    public init(
        id: UUID = UUID(),
        author: User,
        text: String,
        imageName: String = "",
        moodTag: String,
        likes: Int = 0,
        comments: Int = 0,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.author = author
        self.text = text
        self.imageName = imageName
        self.moodTag = moodTag
        self.likes = likes
        self.comments = comments
        self.createdAt = createdAt
    }
}

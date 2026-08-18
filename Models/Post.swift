import Foundation

struct Post: Identifiable, Hashable {
    let id: UUID
    var author: User
    var text: String
    var imageName: String
    var moodTag: String
    var likes: Int
    var comments: Int
    var createdAt: Date

    init(
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

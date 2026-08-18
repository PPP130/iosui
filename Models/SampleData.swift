import Foundation

struct MoodBottle: Identifiable, Hashable {
    let id: UUID
    var mood: MoodTag
    var text: String
    var authorName: String
    var colorHex: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        mood: MoodTag,
        text: String,
        authorName: String,
        colorHex: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.mood = mood
        self.text = text
        self.authorName = authorName
        self.colorHex = colorHex
        self.createdAt = createdAt
    }
}

enum SampleData {

    // MARK: - Users

    static let lex: User = User(
        name: "Lex",
        avatarColor: "#F5F5F5",
        bio: "White-haired dreamer. Soft nights, loud thoughts.",
        coinBalance: 1280,
        isFollowing: true
    )

    static let marlowe: User = User(
        name: "Marlowe",
        avatarColor: "#A0E8F0",
        bio: "Quiet observer. I collect moments, not things.",
        coinBalance: 942,
        isFollowing: false
    )

    static let camille: User = User(
        name: "Camille",
        avatarColor: "#FFB5C5",
        bio: "Hearts that speak louder than words.",
        coinBalance: 2104,
        isFollowing: true
    )

    static let rowan: User = User(
        name: "Rowan",
        avatarColor: "#C8B6FF",
        bio: "Stargazer. Half here, half somewhere far.",
        coinBalance: 760,
        isFollowing: false
    )

    static let sampleUsers: [User] = [lex, marlowe, camille, rowan]

    // MARK: - Followings / Blacklists

    static let sampleFollowings: [User] = [lex, camille]
    static let sampleBlacklists: [User] = [rowan]

    // MARK: - Posts

    static let samplePosts: [Post] = [
        Post(
            author: lex,
            text: "Tonight the sky feels heavier than usual. Holding a quiet wish for everyone reading this.",
            imageName: "placeholder_moon",
            moodTag: MoodTag.lonely.rawValue,
            likes: 184,
            comments: 22,
            createdAt: Date().addingTimeInterval(-60 * 12)
        ),
        Post(
            author: marlowe,
            text: "I made tea and forgot about it. Twice. The kind of day that asks for slow music and softer light.",
            imageName: "placeholder_tea",
            moodTag: MoodTag.calm.rawValue,
            likes: 96,
            comments: 9,
            createdAt: Date().addingTimeInterval(-60 * 60 * 3)
        ),
        Post(
            author: camille,
            text: "Somehow I am both exhausted and wide awake. Anyone else feel like their heart is running a marathon?",
            imageName: "placeholder_heart",
            moodTag: MoodTag.anxious.rawValue,
            likes: 312,
            comments: 47,
            createdAt: Date().addingTimeInterval(-60 * 60 * 5)
        ),
        Post(
            author: rowan,
            text: "A small thing: I laughed at a stranger's dog today and it fixed 2% of my week.",
            imageName: "placeholder_dog",
            moodTag: MoodTag.happy.rawValue,
            likes: 421,
            comments: 31,
            createdAt: Date().addingTimeInterval(-60 * 60 * 8)
        ),
        Post(
            author: lex,
            text: "Good news! I finished that thing I kept putting off. Sending sparkles to anyone who needs them.",
            imageName: "placeholder_sparkle",
            moodTag: MoodTag.excited.rawValue,
            likes: 277,
            comments: 18,
            createdAt: Date().addingTimeInterval(-60 * 60 * 22)
        )
    ]

    // MARK: - AI Characters

    static let sampleAICharacters: [AICharacter] = [
        AICharacter(name: "Selene",    colorHex: "#A0E8F0", personality: "Gentle night companion, asks soft questions."),
        AICharacter(name: "Harper",    colorHex: "#FFB5C5", personality: "Warm and chatty, like a friend at a cafe."),
        AICharacter(name: "Vivienne",  colorHex: "#C8B6FF", personality: "Quietly poetic, finds metaphors in small things."),
        AICharacter(name: "Tessa",     colorHex: "#FFD6A0", personality: "Sunny and encouraging, celebrates tiny wins."),
        AICharacter(name: "Camille",   colorHex: "#B5E2C2", personality: "Calm and grounding, breathes with you."),
        AICharacter(name: "Maelyn",    colorHex: "#F5C8E1", personality: "Playful and curious, asks 'what if' questions."),
        AICharacter(name: "Marlowe",   colorHex: "#AEC6FF", personality: "Thoughtful listener, gives space to silence."),
        AICharacter(name: "Rowan",     colorHex: "#E0C9A6", personality: "Wandering poet, sees the world in chapters."),
        AICharacter(name: "Ada",       colorHex: "#D7B3F0", personality: "Logical and kind, helps untangle big feelings."),
        AICharacter(name: "Lilya",     colorHex: "#FFE0A6", personality: "Soft-spoken dreamer, believes in second chances.")
    ]

    // MARK: - Mood Groups

    static let sampleMoodGroups: [MoodGroup] = [
        MoodGroup(
            name: "Quiet Thoughts",
            description: "A circle for the things you almost didn't say.",
            memberAvatars: ["#A0E8F0", "#C8B6FF", "#F5F5F5", "#B5E2C2"],
            category: "CIRCLE"
        ),
        MoodGroup(
            name: "Soft Recovery",
            description: "Healing is slow and that is okay here.",
            memberAvatars: ["#FFB5C5", "#FFD6A0", "#AEC6FF"],
            category: "DISCUSSION"
        ),
        MoodGroup(
            name: "Midnight Talk",
            description: "Late night company for restless minds.",
            memberAvatars: ["#C8B6FF", "#F5C8E1", "#A0E8F0", "#E0C9A6"],
            category: "DISCUSSION"
        ),
        MoodGroup(
            name: "Heart Fragments",
            description: "Where broken pieces are held with care.",
            memberAvatars: ["#FFB5C5", "#D7B3F0", "#FFE0A6"],
            category: "CIRCLE"
        ),
        MoodGroup(
            name: "Inner Peace Lab",
            description: "Tiny experiments in feeling okay.",
            memberAvatars: ["#B5E2C2", "#A0E8F0", "#FFD6A0", "#C8B6FF"],
            category: "DISCUSSION"
        ),
        MoodGroup(
            name: "Tiny Wins Club",
            description: "Celebrate the smallest victories, loudly or quietly.",
            memberAvatars: ["#FFD6A0", "#B5E2C2", "#FFB5C5", "#AEC6FF", "#E0C9A6"],
            category: "CIRCLE"
        )
    ]

    // MARK: - Chat Messages

    static let sampleMessages: [Message] = [
        Message(senderId: lex.id,      text: "Hi, I just wanted to say the moon looked beautiful tonight.",   isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "I saw it too. Did it feel a little closer to you?",     isFromCurrentUser: true),
        Message(senderId: lex.id,      text: "Yes. The kind of night where you want to tell someone.",          isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "I am glad you did.",                                   isFromCurrentUser: true),

        Message(senderId: marlowe.id,  text: "Slow morning. Coffee, then nothing. Then more coffee.",          isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "That sounds like a kind of luxury to me.",              isFromCurrentUser: true),
        Message(senderId: marlowe.id,  text: "It is. I am trying to notice it before it slips away.",         isFromCurrentUser: false),

        Message(senderId: camille.id,  text: "I keep starting sentences and not finishing them.",               isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "Maybe the unfinished ones are the truest.",             isFromCurrentUser: true),
        Message(senderId: camille.id,  text: "That one made me cry a little. Thank you.",                     isFromCurrentUser: false),

        Message(senderId: rowan.id,    text: "A small win: I drank water before noon.",                       isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "Tiny wins count the loudest.",                          isFromCurrentUser: true),
        Message(senderId: rowan.id,    text: "Saving that one in my notes.",                                  isFromCurrentUser: false),

        Message(senderId: User.sampleCurrentId, text: "I had a hard day today. Not sure why exactly.",          isFromCurrentUser: true),
        Message(senderId: lex.id,      text: "You don't need a reason for a hard day.",                       isFromCurrentUser: false),
        Message(senderId: lex.id,      text: "Want to sit here with me for a bit?",                            isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "Yes. Please.",                                          isFromCurrentUser: true),

        Message(senderId: marlowe.id,  text: "I think the version of me from a year ago would be proud.",      isFromCurrentUser: false),
        Message(senderId: User.sampleCurrentId, text: "And the version five years from now is rooting for you.", isFromCurrentUser: true),
        Message(senderId: marlowe.id,  text: "Okay. Tonight I am going to sleep a little earlier.",             isFromCurrentUser: false)
    ]

    // MARK: - Mood Bottles

    static let sampleMoodBottles: [MoodBottle] = [
        MoodBottle(mood: .calm,    text: "I watched the rain for a long time today and forgot to worry.", authorName: "Marlowe", colorHex: "#A0E8F0"),
        MoodBottle(mood: .lonely,  text: "I miss someone I have not thought about in years.",             authorName: "Lex",     colorHex: "#C8B6FF"),
        MoodBottle(mood: .anxious, text: "My chest has been loud all day. I am still here though.",         authorName: "Camille", colorHex: "#FFB5C5"),
        MoodBottle(mood: .happy,   text: "Tiny joy: a stranger waved at me first.",                       authorName: "Rowan",   colorHex: "#FFD6A0"),
        MoodBottle(mood: .excited, text: "Something is shifting and I cannot name it yet.",                authorName: "Lex",     colorHex: "#B5E2C2"),
        MoodBottle(mood: .sad,     text: "It is okay to be soft on hard days.",                            authorName: "Marlowe", colorHex: "#AEC6FF"),
        MoodBottle(mood: .calm,    text: "I took the long way home and it was the right way.",             authorName: "Camille", colorHex: "#D7B3F0")
    ]
}

private extension User {
    // A stable id used for "current user" messages in sample chat data.
    static let sampleCurrentId: UUID = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
}

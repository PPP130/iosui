import Foundation

enum MoodTag: String, CaseIterable, Identifiable, Hashable {
    case happy
    case sad
    case anxious
    case calm
    case excited
    case lonely

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .happy:   return "Happy"
        case .sad:     return "Sad"
        case .anxious: return "Anxious"
        case .calm:    return "Calm"
        case .excited: return "Excited"
        case .lonely:  return "Lonely"
        }
    }
}

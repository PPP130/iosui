//
//  EmojiCard.swift
//  HI - Emotion Social App
//
//  Rounded card displaying a mood emoji + label with a custom gradient
//  background. Used for mood pickers and quick emotion shortcuts.
//

import SwiftUI

// MARK: - EmojiCard

public struct EmojiCard: View {

    // Public API
    public let emoji: String
    public let label: String
    public let gradient: [Color]
    public let action: (() -> Void)?

    // Layout
    private let cardSize: CGFloat = 120
    private let cornerRadius: CGFloat = 24

    public init(
        emoji: String,
        label: String,
        gradient: [Color],
        action: (() -> Void)? = nil
    ) {
        self.emoji = emoji
        self.label = label
        self.gradient = gradient
        self.action = action
    }

    public var body: some View {
        let card = cardContent
        return Group {
            if let action = action {
                Button(action: action) { card }
                    .buttonStyle(PressableCardStyle())
            } else {
                card
            }
        }
    }

    private var cardContent: some View {
        ZStack {
            // Gradient background
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: gradient.isEmpty
                            ? [Color.brandPrimary, Color.brandPrimary.opacity(0.7)]
                            : gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // Subtle highlight for a 3D feel
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.25), Color.white.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .center
                    )
                )

            VStack(spacing: 8) {
                Text(emoji)
                    .font(.system(size: 40))
                    .shadow(color: .black.opacity(0.10), radius: 2, x: 0, y: 1)

                Text(label)
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .padding(.horizontal, 6)
            }
            .padding(8)
        }
        .frame(width: cardSize, height: cardSize)
        .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Press feedback

private struct PressableCardStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Preset gradients (convenience)

public extension Array where Element == Color {
    /// Common mood gradient presets.
    static let moodHappy: [Color] = [Color(red: 1.00, green: 0.78, blue: 0.20), Color(red: 1.00, green: 0.45, blue: 0.20)]
    static let moodCalm: [Color]  = [Color(red: 0.69, green: 0.91, blue: 0.94), Color(red: 0.40, green: 0.70, blue: 0.95)]
    static let moodSad: [Color]   = [Color(red: 0.42, green: 0.45, blue: 0.80), Color(red: 0.21, green: 0.27, blue: 0.55)]
    static let moodAngry: [Color] = [Color(red: 0.95, green: 0.30, blue: 0.30), Color(red: 0.65, green: 0.10, blue: 0.20)]
    static let moodLove: [Color]  = [Color(red: 1.00, green: 0.45, blue: 0.65), Color(red: 0.90, green: 0.20, blue: 0.45)]
    static let moodTired: [Color] = [Color(red: 0.65, green: 0.55, blue: 0.85), Color(red: 0.40, green: 0.30, blue: 0.65)]
}

// MARK: - Preview

#Preview("EmojiCard") {
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    return LazyVGrid(columns: columns, spacing: 12) {
        EmojiCard(emoji: "😊", label: "Happy", gradient: .moodHappy)
        EmojiCard(emoji: "😌", label: "Calm",  gradient: .moodCalm)
        EmojiCard(emoji: "😢", label: "Sad",   gradient: .moodSad)
        EmojiCard(emoji: "😡", label: "Angry", gradient: .moodAngry)
        EmojiCard(emoji: "🥰", label: "Love",  gradient: .moodLove)
        EmojiCard(emoji: "😴", label: "Tired", gradient: .moodTired)
    }
    .padding(20)
    .gradientBackground()
}

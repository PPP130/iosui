//
//  MessageBubble.swift
//  HI - Emotion Social App
//
//  Chat bubble. White for messages from the other user, cyan for the
//  current user. Asymmetric corner radii give the bubbles a "tail" feel.
//

import SwiftUI

// MARK: - MessageBubble

public struct MessageBubble: View {

    // Public API
    public let text: String
    public let isFromCurrentUser: Bool

    public init(text: String, isFromCurrentUser: Bool) {
        self.text = text
        self.isFromCurrentUser = isFromCurrentUser
    }

    // Layout
    private let maxBubbleWidth: CGFloat = 280
    private let cornerLarge: CGFloat = 20
    private let cornerSmall: CGFloat = 6

    public var body: some View {
        HStack {
            if isFromCurrentUser { Spacer(minLength: 40) }

            Text(text)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(textColor)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: cornerLarge, style: .continuous)
                        .fill(bubbleColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerLarge, style: .continuous)
                        .stroke(Color.black.opacity(0.04), lineWidth: 1)
                )
                .clipShape(BubbleShape(isFromCurrentUser: isFromCurrentUser))
                .frame(maxWidth: maxBubbleWidth, alignment: alignment)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

            if !isFromCurrentUser { Spacer(minLength: 40) }
        }
    }

    // MARK: - Styling

    private var bubbleColor: Color {
        isFromCurrentUser ? Color.brandPrimary : .white
    }

    private var textColor: Color {
        isFromCurrentUser ? .white : .brandBlack
    }

    private var alignment: Alignment {
        isFromCurrentUser ? .trailing : .leading
    }
}

// MARK: - Bubble shape with asymmetric corners

private struct BubbleShape: Shape {
    let isFromCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        let large: CGFloat = 20
        let small: CGFloat = 6

        let tl = isFromCurrentUser ? large : large
        let tr = isFromCurrentUser ? small : large
        let br = isFromCurrentUser ? large : large
        let bl = isFromCurrentUser ? large : small

        return Path { path in
            // Start near the top-left after the rounded corner
            path.move(to: CGPoint(x: rect.minX + tl, y: rect.minY))

            // Top edge
            path.addLine(to: CGPoint(x: rect.maxX - tr, y: rect.minY))
            // Top-right corner
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + tr),
                control: CGPoint(x: rect.maxX, y: rect.minY)
            )
            // Right edge
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
            // Bottom-right corner
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - br, y: rect.maxY),
                control: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            // Bottom edge
            path.addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
            // Bottom-left corner
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - bl),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
            // Left edge
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + tl))
            // Top-left corner
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + tl, y: rect.minY),
                control: CGPoint(x: rect.minX, y: rect.minY)
            )
            path.closeSubpath()
        }
    }
}

// MARK: - Preview

#Preview("MessageBubble") {
    VStack(spacing: 12) {
        MessageBubble(text: "Hey! How are you today?", isFromCurrentUser: false)
        MessageBubble(text: "I'm good, thanks! Just enjoying the new HI app.", isFromCurrentUser: true)
        MessageBubble(text: "That sounds great. What did you discover?", isFromCurrentUser: false)
        MessageBubble(text: "Lots of cool mood cards and AI chats!", isFromCurrentUser: true)
    }
    .padding(20)
    .gradientBackground()
}

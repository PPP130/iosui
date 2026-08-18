//
//  GradientBackground.swift
//  HI - Emotion Social App
//
//  A simple cyan-to-white vertical gradient background modifier.
//

import SwiftUI

// MARK: - ViewModifier

/// Applies the brand's signature cyan-to-white vertical gradient background.
public struct GradientBackgroundModifier: ViewModifier {

    private let topColor: Color
    private let bottomColor: Color

    public init(
        topColor: Color = Color(red: 0.69, green: 0.91, blue: 0.94),
        bottomColor: Color = .white
    ) {
        self.topColor = topColor
        self.bottomColor = bottomColor
    }

    public func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [topColor, bottomColor],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            content
        }
    }
}

// MARK: - View extension

public extension View {
    /// Applies the brand's signature cyan-to-white vertical gradient background.
    func gradientBackground(
        topColor: Color = Color(red: 0.69, green: 0.91, blue: 0.94),
        bottomColor: Color = .white
    ) -> some View {
        modifier(GradientBackgroundModifier(topColor: topColor, bottomColor: bottomColor))
    }
}

// MARK: - Preview

#Preview("Gradient Background") {
    VStack(spacing: 16) {
        Text("HI")
            .font(.system(size: 64, weight: .heavy))
            .foregroundColor(.brandBlack)
        Text("Cyan to white")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.brandBlack.opacity(0.7))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .gradientBackground()
}

//
//  PrimaryButton.swift
//  HI - Emotion Social App
//
//  Black rounded primary button with optional 3D-style star decoration
//  in the top-right corner.
//

import SwiftUI

// MARK: - PrimaryButton

public struct PrimaryButton: View {

    // Public API
    public let title: String
    public let trailingIcon: String?
    public let action: () -> Void

    // Layout
    private let height: CGFloat = 56
    private let cornerRadius: CGFloat = 32

    // Init
    public init(
        title: String,
        trailingIcon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.trailingIcon = trailingIcon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                // Title
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(Color.brandBlack)
                    )
                    .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

                // 3D star decoration overlay (top-right)
                if let icon = trailingIcon {
                    StarDecoration(systemName: icon)
                        .offset(x: 6, y: -6)
                }
            }
        }
        .buttonStyle(PressableButtonStyle())
    }
}

// MARK: - 3D Star Decoration

private struct StarDecoration: View {
    let systemName: String

    var body: some View {
        ZStack {
            // Soft outer glow
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.95, blue: 0.4),
                            Color(red: 1.0, green: 0.78, blue: 0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.18), radius: 3, x: 0, y: 2)

            // Highlight overlay
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.85),
                            Color.white.opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .blendMode(.screen)
                .mask(
                    Image(systemName: systemName)
                        .font(.system(size: 18, weight: .black))
                )
        }
    }
}

// MARK: - Press feedback style

private struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview("PrimaryButton") {
    VStack(spacing: 24) {
        PrimaryButton(title: "Continue") {
            print("Continue tapped")
        }

        PrimaryButton(title: "Get Started", trailingIcon: "star.fill") {
            print("Get Started tapped")
        }
    }
    .padding(32)
    .gradientBackground()
}

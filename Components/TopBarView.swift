//
//  TopBarView.swift
//  HI - Emotion Social App
//
//  Top bar with a back chevron (left), bold title (center),
//  and a circular "!" alert button (right).
//

import SwiftUI

// MARK: - TopBarView

public struct TopBarView: View {

    // Public API
    public let title: String
    public let onBack: () -> Void
    public let onAlert: (() -> Void)?

    public init(
        title: String,
        onBack: @escaping () -> Void,
        onAlert: (() -> Void)? = nil
    ) {
        self.title = title
        self.onBack = onBack
        self.onAlert = onAlert
    }

    public var body: some View {
        HStack(spacing: 0) {
            // Back chevron
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.brandBlack)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PressableButtonStyle())

            // Title
            Text(title)
                .font(.system(size: 17, weight: .heavy))
                .foregroundColor(.brandBlack)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

            // Alert button
            if let onAlert = onAlert {
                Button(action: onAlert) {
                    ZStack {
                        Circle()
                            .fill(Color.brandPink.opacity(0.15))
                            .frame(width: 32, height: 32)

                        Text("!")
                            .font(.system(size: 18, weight: .heavy))
                            .foregroundColor(Color.brandPink)
                    }
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                }
                .buttonStyle(PressableButtonStyle())
            } else {
                // Spacer to keep title centered when no alert is provided
                Color.clear
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
    }
}

// MARK: - Press feedback

private struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview("TopBarView") {
    struct TopBarPreviewWrapper: View {
        @State private var showAlert = false

        var body: some View {
            VStack(spacing: 0) {
                TopBarView(
                    title: "Profile",
                    onBack: { print("Back tapped") },
                    onAlert: { print("Alert tapped") }
                )

                Spacer()
            }
            .gradientBackground()
        }
    }

    return TopBarPreviewWrapper()
}

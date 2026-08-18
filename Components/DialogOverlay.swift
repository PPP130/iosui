//
//  DialogOverlay.swift
//  HI - Emotion Social App
//
//  Generic modal: black scrim + white rounded card centered on screen.
//  Title (pink), body text, and a single button.
//

import SwiftUI

// MARK: - DialogOverlay

public struct DialogOverlay: View {

    // Public API
    public let title: String
    public let message: String
    public let buttonTitle: String
    public let onDismiss: () -> Void

    public init(
        title: String,
        message: String,
        buttonTitle: String,
        onDismiss: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            // Black scrim
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .transition(.opacity)

            // Card
            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundColor(Color.brandPink)
                    .multilineTextAlignment(.center)

                Text(message)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.brandBlack)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                // Button
                Button(action: onDismiss) {
                    Text(buttonTitle)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(Color.brandBlack)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                }
                .buttonStyle(PressableDialogButtonStyle())
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .padding(.bottom, 20)
            .frame(maxWidth: 320)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
            .transition(.scale(scale: 0.9).combined(with: .opacity))
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: UUID())
    }
}

// MARK: - Press feedback

private struct PressableDialogButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Convenience modifier

public extension View {
    /// Presents a `DialogOverlay` when `isPresented` is true.
    func dialogOverlay(
        isPresented: Bool,
        title: String,
        message: String,
        buttonTitle: String = "OK",
        onDismiss: @escaping () -> Void
    ) -> some View {
        ZStack {
            self

            if isPresented {
                DialogOverlay(
                    title: title,
                    message: message,
                    buttonTitle: buttonTitle,
                    onDismiss: onDismiss
                )
                .zIndex(1)
            }
        }
    }
}

// MARK: - Preview

#Preview("DialogOverlay") {
    struct DialogPreviewWrapper: View {
        @State private var show = true

        var body: some View {
            ZStack {
                VStack {
                    Text("Background content")
                        .font(.title2)
                        .foregroundColor(.brandBlack)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .gradientBackground()

                if show {
                    DialogOverlay(
                        title: "Are you sure?",
                        message: "This action cannot be undone. Please confirm to continue.",
                        buttonTitle: "Got it"
                    ) {
                        show = false
                    }
                }
            }
        }
    }

    return DialogPreviewWrapper()
}

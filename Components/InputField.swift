//
//  InputField.swift
//  HI - Emotion Social App
//
//  A light gray rounded input field with a placeholder.
//

import SwiftUI

// MARK: - InputField

public struct InputField: View {

    // Public API
    public let placeholder: String
    @Binding public var text: String

    // Layout
    private let height: CGFloat = 52
    private let cornerRadius: CGFloat = 16

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    public var body: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.brandBlack.opacity(0.35)))
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.brandBlack)
            .padding(.horizontal, 16)
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.brandBgLight)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.black.opacity(0.04), lineWidth: 1)
            )
            .autocorrectionDisabled(false)
            .textInputAutocapitalization(.sentences)
    }
}

// MARK: - Preview

#Preview("InputField") {
    struct InputPreviewWrapper: View {
        @State private var name: String = ""
        @State private var email: String = "user@example.com"

        var body: some View {
            VStack(spacing: 16) {
                InputField(placeholder: "Name", text: $name)
                InputField(placeholder: "Email", text: $email)
            }
            .padding(24)
            .gradientBackground()
        }
    }

    return InputPreviewWrapper()
}

//
//  LoginView.swift
//  HI - Emotion Social App
//
//  Login page built on the full-bleed `login.png` design image. A
//  "Get Start" primary CTA is overlaid at the bottom and fires
//  `onLogin` when tapped.
//

import SwiftUI

// MARK: - LoginView

public struct LoginView: View {

    // MARK: Public API

    /// Called when the user taps the "Get Start" button.
    public let onLogin: () -> Void

    // MARK: Init

    public init(onLogin: @escaping () -> Void) {
        self.onLogin = onLogin
    }

    // MARK: Body

    public var body: some View {
        ZStack {
            // Full-bleed login design image
            ImageLoader.background(AppImages.login)

            VStack {
                Spacer()

                // Primary CTA at the bottom
                PrimaryButton(title: "Get Start", action: onLogin)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
    }
}

// MARK: - Preview

#Preview("Login") {
    LoginView(onLogin: {
        print("Get Start tapped — sign in")
    })
}

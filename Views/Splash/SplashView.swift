//
//  SplashView.swift
//  HI - Emotion Social App
//
//  Launching page: a full-bleed splash design image (`splash.png`)
//  with an auto-transition after 1.5 seconds via the `onFinish`
//  callback.
//

import SwiftUI

// MARK: - SplashView

public struct SplashView: View {

    // MARK: Public API

    /// Called after 1.5 seconds so the host can advance to the
    /// next screen (typically Onboarding or Login).
    public let onFinish: () -> Void

    // MARK: Init

    public init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }

    // MARK: Body

    public var body: some View {
        ZStack {
            // Full-bleed splash design image
            ImageLoader.background(AppImages.splash)

            // Optional foreground reserved for future overlay content
            Color.clear
        }
        .onAppear {
            // Auto-transition after 1.5s. Use DispatchQueue so the
            // transition also fires if SwiftUI re-renders the view
            // for any reason after the initial onAppear.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                onFinish()
            }
        }
    }
}

// MARK: - Preview

#Preview("Splash") {
    SplashView(onFinish: {
        // Simulated transition after 1.5s
        print("Splash finished — advance to next screen")
    })
}

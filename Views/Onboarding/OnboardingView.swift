//
//  OnboardingView.swift
//  HI - Emotion Social App
//
//  3-page horizontal swipe onboarding built on `TabView(.page)`. Each
//  page is a full-bleed onboarding design image with a top bar
//  (back chevron + Skip), page-indicator dots, and a primary CTA
//  that reads "Next" on pages 1-2 and "Get Start" on the last page.
//

import SwiftUI

// MARK: - OnboardingView

public struct OnboardingView: View {

    // MARK: Public API

    /// Called when the user finishes the carousel (either by tapping
    /// "Get Start" on the last page, or "Skip" at the top).
    public let onComplete: () -> Void

    // MARK: State

    @State private var currentPage: Int = 0
    private let pageCount = 3

    // MARK: Init

    public init(onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }

    // MARK: Body

    public var body: some View {
        ZStack {
            // Paged design images fill the screen
            TabView(selection: $currentPage) {
                ImageLoader.background(AppImages.onboarding1)
                    .tag(0)
                ImageLoader.background(AppImages.onboarding2)
                    .tag(1)
                ImageLoader.background(AppImages.onboarding3)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            // Foreground overlays
            VStack(spacing: 0) {
                topBar
                    .padding(.horizontal, 24)
                    .padding(.top, 12)

                Spacer()

                // Page indicator dots
                pageIndicator
                    .padding(.bottom, 16)

                // Primary CTA
                PrimaryButton(title: isLastPage ? "Get Start" : "Next") {
                    advance()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }

    // MARK: - Computed

    private var isLastPage: Bool { currentPage == pageCount - 1 }

    // MARK: - Top bar

    private var topBar: some View {
        HStack {
            // Back chevron
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    if currentPage > 0 { currentPage -= 1 }
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.brandBlack)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color.brandBlack.opacity(currentPage == 0 ? 0 : 0.05))
                    )
            }
            .opacity(currentPage == 0 ? 0 : 1)
            .disabled(currentPage == 0)

            Spacer()

            // Skip
            Button {
                onComplete()
            } label: {
                Text("Skip")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.brandBlack)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
            }
            .opacity(isLastPage ? 0 : 1)
            .disabled(isLastPage)
        }
    }

    // MARK: - Page indicator

    private var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { i in
                Capsule()
                    .fill(i == currentPage ? Color.brandBlack : Color.brandBlack.opacity(0.18))
                    .frame(width: i == currentPage ? 24 : 8, height: 8)
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: currentPage)
            }
        }
    }

    // MARK: - Actions

    private func advance() {
        if isLastPage {
            onComplete()
        } else {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                currentPage += 1
            }
        }
    }
}

// MARK: - Preview

#Preview("Onboarding") {
    OnboardingView(onComplete: {
        print("Onboarding complete — advance to Login")
    })
}

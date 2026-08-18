//
//  HomeView.swift
//  HI - Emotion Social App
//
//  Main entry page. Uses the full-bleed `home.png` design image
//  (which already contains the WELCOME header, snow globe, feature
//  cards and 4-tab bar) and overlays a transparent HStack of 4
//  buttons so taps on the tab regions work.
//

import SwiftUI

public struct HomeView: View {

    // MARK: State

    @State private var selectedTab: Int = 0

    // MARK: Init

    public init() {}

    // MARK: Body

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Full-bleed home design image
            ImageLoader.background(AppImages.home)

            // Transparent tab interaction overlay
            GeometryReader { proxy in
                let bottomInset = proxy.safeAreaInsets.bottom
                let tabBarHeight: CGFloat = 64
                let tabAreaHeight = tabBarHeight + bottomInset
                let tabAreaY = proxy.size.height - tabAreaHeight

                // 4 transparent buttons matching the home/ai/favorite/me tab icons
                HStack(spacing: 0) {
                    tabButton(label: "Home", index: 0)
                    tabButton(label: "AI", index: 1)
                    tabButton(label: "Favorite", index: 2)
                    tabButton(label: "Me", index: 3)
                }
                .frame(height: tabBarHeight)
                .frame(maxWidth: .infinity)
                .position(
                    x: proxy.size.width / 2,
                    y: tabAreaY + tabBarHeight / 2
                )
                .allowsHitTesting(true)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    // MARK: - Tab button

    private func tabButton(label: String, index: Int) -> some View {
        Button {
            selectedTab = index
        } label: {
            // Transparent tap target
            Color.clear
                .contentShape(Rectangle())
                .accessibilityLabel(Text(label))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview("Home") {
    HomeView()
}

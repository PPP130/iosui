//
//  MyProfileView.swift
//  HI - Emotion Social App
//
//  User's own profile screen. Uses the real design PNG (which
//  contains the "Lex" header, 140pt avatar, yellow My coins card,
//  4 menu rows, and the 4-Tab bar at the bottom). Floating
//  transparent HStack buttons overlay the image at the bottom to
//  keep the custom tab bar interactive.
//

import SwiftUI

public struct MyProfileView: View {

    @State private var selectedTab: AppTab = .me

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Bottom layer: the real design image
            ImageLoader.background(AppImages.myProfile)

            // 4 transparent tab buttons inside safeAreaInset
            tabBarOverlay
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    // MARK: - Tab bar overlay

    private var tabBarOverlay: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    Color.clear
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .frame(height: 80)
        .accessibilityElement(children: .contain)
    }
}

// MARK: - Preview

#Preview("MyProfileView") {
    MyProfileView()
}

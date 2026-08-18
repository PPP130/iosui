//
//  VideoListView.swift
//  HI - Emotion Social App
//
//  Video call / live streaming list. Shows a vertical beige→brown
//  gradient background (simulating a window looking out at trees),
//  two floating comment bubbles from viewers, a chat input bar and
//  a custom 4-tab bottom bar (AI tab selected).
//

import SwiftUI

// MARK: - VideoListView

public struct VideoListView: View {

    // Local state
    @State private var inputText: String = ""
    @State private var selectedTab: VideoTab = .ai

    // Two sample comments
    private let comments: [VideoComment] = [
        VideoComment(
            avatarHex: "#FFB5C5",
            initial: "M",
            text: "Every small step in expressing yourself is progress."
        ),
        VideoComment(
            avatarHex: "#C8B6FF",
            initial: "L",
            text: "Sending you quiet courage for tonight."
        )
    ]

    public init() {}

    public var body: some View {
        ZStack {
            // 1. Window background: beige → brown → dark brown vertical gradient
            LinearGradient(
                colors: [
                    Color(red: 0.91, green: 0.86, blue: 0.74),  // beige
                    Color(red: 0.55, green: 0.40, blue: 0.28),  // warm brown
                    Color(red: 0.22, green: 0.15, blue: 0.10)   // dark brown
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // 2. Faint "trees" silhouettes to feel like a window
            TreeSilhouettes()
                .opacity(0.35)
                .ignoresSafeArea()

            // 3. Main vertical stack
            VStack(spacing: 0) {
                topBar
                    .padding(.horizontal, 12)
                    .padding(.top, 6)

                Spacer()

                floatingComments
                    .padding(.horizontal, 16)

                Spacer()

                inputBar
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)

                bottomTabBar
            }
        }
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack {
            // Capsule with avatar + "lex" + check
            HStack(spacing: 8) {
                AvatarView(name: "Lex", colorHex: "#F5F5F5", size: .small)

                Text("lex")
                    .font(.system(size: 15, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)

                // White circle with black checkmark
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 18, height: 18)
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.brandBlack)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.35))
            )

            Spacer()

            // Gray circular "!" alert
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.25))
                    .frame(width: 36, height: 36)

                Text("!")
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(.white)
            }
        }
    }

    // MARK: - Floating comment bubbles

    private var floatingComments: some View {
        VStack(alignment: .leading, spacing: 14) {
            ForEach(comments) { comment in
                CommentBubbleRow(comment: comment)
            }
        }
    }

    // MARK: - Input bar

    private var inputBar: some View {
        HStack(spacing: 10) {
            // Rounded dark semi-transparent background
            HStack(spacing: 8) {
                TextField("", text: $inputText,
                          prompt: Text("Please enter...")
                            .foregroundColor(.white.opacity(0.55)))
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)

                // Paper plane (send) icon
                Button(action: { /* send */ }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white.opacity(0.85))
                        .frame(width: 32, height: 32)
                }
            }
            .padding(.horizontal, 14)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.black.opacity(0.45))
            )

            // Cyan "Hi" smiley button
            ZStack {
                Circle()
                    .fill(Color.brandPrimary)
                    .frame(width: 44, height: 44)
                    .shadow(color: Color.brandPrimary.opacity(0.5), radius: 6, x: 0, y: 2)

                Text("Hi")
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .foregroundColor(.brandBlack)
            }
        }
    }

    // MARK: - Bottom tab bar

    private var bottomTabBar: some View {
        HStack(spacing: 0) {
            ForEach(VideoTab.allCases) { tab in
                TabButton(
                    tab: tab,
                    isSelected: tab == selectedTab
                ) {
                    selectedTab = tab
                }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 22)
        .frame(maxWidth: .infinity)
        .background(
            Color.black.opacity(0.55)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

// MARK: - Tab enum

private enum VideoTab: String, CaseIterable, Identifiable {
    case home    = "Home"
    case ai      = "AI"
    case favorite = "Favorite"
    case me      = "Me"

    var id: String { rawValue }

    var systemIcon: String {
        switch self {
        case .home:     return "house.fill"
        case .ai:       return "sparkles"
        case .favorite: return "heart.fill"
        case .me:       return "person.fill"
        }
    }
}

// MARK: - Tab button

private struct TabButton: View {
    let tab: VideoTab
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        // Selected pill (cyan)
                        Capsule()
                            .fill(Color.brandPrimary)
                            .frame(width: 48, height: 28)
                            .shadow(color: Color.brandPrimary.opacity(0.5),
                                    radius: 6, x: 0, y: 2)
                    }
                    Image(systemName: tab.systemIcon)
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(isSelected ? .brandBlack : .white.opacity(0.7))
                }
                .frame(height: 28)

                Text(tab.rawValue)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .brandBlack : .white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Comment data model

private struct VideoComment: Identifiable {
    let id = UUID()
    let avatarHex: String
    let initial: String
    let text: String
}

// MARK: - Comment bubble row

private struct CommentBubbleRow: View {
    let comment: VideoComment

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AvatarView(name: comment.initial, colorHex: comment.avatarHex, size: .small)

            Text(comment.text)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.gray.opacity(0.55))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                )

            Spacer(minLength: 0)
        }
    }
}

// MARK: - Faint tree silhouettes (window background)

private struct TreeSilhouettes: View {
    var body: some View {
        GeometryReader { proxy in
            let w = proxy.size.width
            let h = proxy.size.height

            ZStack {
                // Distant soft hill
                Ellipse()
                    .fill(Color.black.opacity(0.30))
                    .frame(width: w * 1.4, height: h * 0.45)
                    .position(x: w * 0.5, y: h * 0.85)

                // Three tree trunks with leafy tops
                ForEach(0..<5, id: \.self) { i in
                    let x = w * CGFloat([0.10, 0.30, 0.55, 0.78, 0.92][i])
                    let top = h * CGFloat([0.50, 0.42, 0.48, 0.40, 0.55][i])
                    let size = CGFloat([80, 110, 90, 130, 70][i])

                    VStack(spacing: 0) {
                        // Leafy top
                        Ellipse()
                            .fill(Color.black.opacity(0.55))
                            .frame(width: size, height: size * 1.1)
                        // Trunk
                        Rectangle()
                            .fill(Color.black.opacity(0.65))
                            .frame(width: size * 0.18, height: size * 0.7)
                    }
                    .position(x: x, y: top + size * 0.5)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("VideoListView") {
    VideoListView()
}

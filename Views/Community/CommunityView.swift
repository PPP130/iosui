//
//  CommunityView.swift
//  HI - Emotion Social App
//
//  Community feed screen. Vertical list of post cards with
//  horizontal filter chips at the top.
//

import SwiftUI

// MARK: - Filter chip

private enum CommunityFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case dailyMood = "Daily Mood"
    case emotionStories = "Emotion Stories"

    var id: String { rawValue }
}

// MARK: - CommunityView

public struct CommunityView: View {

    // Sample data
    private let posts: [Post] = SampleData.samplePosts

    // State
    @State private var selectedFilter: CommunityFilter = .all

    public init() {}

    public var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Community",
                    onBack: { /* tab root – no back action */ },
                    onAlert: { /* alert tapped */ }
                )

                filterChipsRow

                postsList
            }
        }
    }

    // MARK: - Filter chips

    private var filterChipsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(CommunityFilter.allCases) { filter in
                    FilterChip(
                        title: filter.rawValue,
                        isSelected: filter == selectedFilter
                    ) {
                        selectedFilter = filter
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }

    // MARK: - Posts list

    private var postsList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(posts) { post in
                    CommunityPostCard(post: post)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 4)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - FilterChip

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .heavy, design: .rounded))
                .foregroundColor(isSelected ? .white : .brandBlack)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.brandBlack : Color.white)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.black.opacity(isSelected ? 0 : 0.06), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - CommunityPostCard

private struct CommunityPostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image area with gradient placeholder
            ZStack(alignment: .topTrailing) {
                LinearGradient(
                    colors: gradientColors(for: post),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

                // "!" alert icon in top-right of the image
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.92))
                        .frame(width: 32, height: 32)
                    Text("!")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(.brandBlack)
                }
                .padding(12)
            }

            // Bottom content
            HStack(alignment: .center, spacing: 12) {
                AvatarView(
                    name: post.author.name,
                    colorHex: post.author.avatarColor,
                    size: .small
                )

                VStack(alignment: .leading, spacing: 4) {
                    Text(post.author.name)
                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)

                    Text(post.text)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.92))
                        .lineLimit(2)
                }

                Spacer(minLength: 8)

                // Two circular action buttons (cyan)
                HStack(spacing: 8) {
                    CircleActionButton(systemName: "bubble.right.fill")
                    CircleActionButton(systemName: "hand.thumbsup.fill")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                Color.brandBlack
            )
            .clipShape(
                UnevenRoundedRectangle(
                    bottomLeadingRadius: 24,
                    bottomTrailingRadius: 24,
                    style: .continuous
                )
            )
        }
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
    }

    // Deterministic gradient per mood so the cards don't all look the same.
    private func gradientColors(for post: Post) -> [Color] {
        switch post.moodTag {
        case "lonely":
            return [Color(red: 0.40, green: 0.50, blue: 0.65),
                    Color(red: 0.18, green: 0.22, blue: 0.32)]
        case "calm":
            return [Color(red: 0.55, green: 0.78, blue: 0.62),
                    Color(red: 0.30, green: 0.50, blue: 0.45)]
        case "anxious":
            return [Color(red: 0.95, green: 0.66, blue: 0.70),
                    Color(red: 0.80, green: 0.30, blue: 0.55)]
        case "happy":
            return [Color(red: 1.00, green: 0.85, blue: 0.30),
                    Color(red: 0.95, green: 0.55, blue: 0.25)]
        case "excited":
            return [Color(red: 0.65, green: 0.50, blue: 0.95),
                    Color(red: 0.95, green: 0.40, blue: 0.70)]
        case "sad":
            return [Color(red: 0.45, green: 0.55, blue: 0.75),
                    Color(red: 0.20, green: 0.30, blue: 0.55)]
        default:
            return [Color(red: 0.45, green: 0.75, blue: 0.85),
                    Color(red: 0.25, green: 0.55, blue: 0.70)]
        }
    }
}

// MARK: - CircleActionButton

private struct CircleActionButton: View {
    let systemName: String

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.brandPrimary)
                .frame(width: 36, height: 36)
            Image(systemName: systemName)
                .font(.system(size: 14, weight: .heavy))
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview

#Preview("CommunityView") {
    CommunityView()
}

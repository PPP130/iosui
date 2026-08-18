//
//  MyPostsView.swift
//  HI - Emotion Social App
//
//  The user's own published posts. A 3-column grid of square
//  thumbnails, each with a gradient background tinted by the
//  post's mood. The same top bar style as the other profile
//  screens, with only a back arrow.
//

import SwiftUI

// MARK: - MyPostsView

public struct MyPostsView: View {

    // Sample data — only the current user's posts
    private let posts: [Post] = SampleData.samplePosts.filter {
        $0.author.id == SampleData.lex.id
    }

    // Grid configuration
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 3
    )

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "My Posts",
                    onBack: { dismiss() }
                )

                if posts.isEmpty {
                    emptyState
                } else {
                    postsGrid
                }
            }
        }
    }

    // MARK: - Posts grid

    private var postsGrid: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(posts) { post in
                    PostThumbnail(post: post)
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
    }

    // MARK: - Empty state

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(.brandBlack.opacity(0.3))

            Text("No posts yet")
                .font(.brandBody)
                .foregroundColor(.brandBlack.opacity(0.5))

            Text("Share your first mood to fill this grid.")
                .font(.brandCaption)
                .foregroundColor(.brandBlack.opacity(0.4))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
        }
    }
}

// MARK: - PostThumbnail

/// A single square thumbnail used in the 3-column grid. Renders
/// a gradient tinted by the post's mood and overlays the mood
/// emoji in the top-right corner.
private struct PostThumbnail: View {
    let post: Post

    var body: some View {
        ZStack(alignment: .topTrailing) {
            LinearGradient(
                colors: gradientColors(for: post),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            // Optional mood-emoji chip in the top-right
            Text(moodEmoji(for: post.moodTag))
                .font(.system(size: 18))
                .padding(6)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.85))
                )
                .padding(6)
        }
    }

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

    private func moodEmoji(for tag: String) -> String {
        switch tag {
        case "happy":   return "😊"
        case "sad":     return "😢"
        case "anxious": return "😰"
        case "calm":    return "🌿"
        case "excited": return "✨"
        case "lonely":  return "🌙"
        default:        return "💭"
        }
    }
}

// MARK: - Preview

#Preview("MyPostsView") {
    MyPostsView()
}

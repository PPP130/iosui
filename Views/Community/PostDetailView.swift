//
//  PostDetailView.swift
//  HI - Emotion Social App
//
//  Single post detail with a custom top bar, big image, caption,
//  a single sample comment, and an input bar at the bottom.
//

import SwiftUI

// MARK: - PostDetailView

public struct PostDetailView: View {

    // Sample data
    private let post: Post = SampleData.samplePosts.first ?? SampleData.samplePosts[0]

    // State
    @State private var commentText: String = ""
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                customTopBar
                contentScroll
            }

            inputBar
        }
        .navigationBarHidden(true)
    }

    // MARK: - Top bar (custom)

    private var customTopBar: some View {
        HStack(spacing: 12) {
            // Back arrow
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.brandBlack)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            // Small avatar + name
            AvatarView(
                name: post.author.name,
                colorHex: post.author.avatarColor,
                size: .small
            )

            Text(post.author.name)
                .font(.system(size: 16, weight: .heavy, design: .rounded))
                .foregroundColor(.brandBlack)

            Spacer()

            // "!" alert button
            Button {
                /* alert tapped */
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.brandPink.opacity(0.15))
                        .frame(width: 32, height: 32)
                    Text("!")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(Color.brandPink)
                }
                .frame(width: 40, height: 40)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(Color.white)
    }

    // MARK: - Content scroll

    private var contentScroll: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Big post image
                LinearGradient(
                    colors: postGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 320)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .padding(.horizontal, 16)
                .padding(.top, 8)

                // Caption
                Text(post.text)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.brandBlack)
                    .lineLimit(nil)
                    .padding(.horizontal, 20)

                Divider()
                    .background(Color.black.opacity(0.08))
                    .padding(.horizontal, 20)
                    .padding(.top, 4)

                // One comment
                commentRow

                Spacer(minLength: 100) // leave room for input bar
            }
            .padding(.bottom, 24)
        }
    }

    // MARK: - Comment row

    private var commentRow: some View {
        HStack(alignment: .top, spacing: 10) {
            AvatarView(
                name: post.author.name,
                colorHex: post.author.avatarColor,
                size: .small
            )

            // Grey message bubble
            Text(post.text)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.brandBlack)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.brandBgLight)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.black.opacity(0.05), lineWidth: 1)
                )
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Input bar

    private var inputBar: some View {
        HStack(spacing: 10) {
            InputField(placeholder: "Please enter...", text: $commentText)

            // Cyan paper-plane send button
            Button {
                // send tapped
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.brandPrimary)
                        .frame(width: 44, height: 44)
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.white)
                        .offset(x: -1)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Color.white
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: -2)
        )
    }

    // MARK: - Post gradient

    private var postGradient: [Color] {
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
        default:
            return [Color(red: 0.45, green: 0.75, blue: 0.85),
                    Color(red: 0.25, green: 0.55, blue: 0.70)]
        }
    }
}

// MARK: - Preview

#Preview("PostDetailView") {
    PostDetailView()
}

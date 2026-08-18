//
//  MessageListView.swift
//  HI - Emotion Social App
//
//  Messages list page. Light gray background with a scrollable list
//  of message items, each a white rounded card with avatar, name,
//  preview, and timestamp.
//

import SwiftUI

// MARK: - MessageListView

public struct MessageListView: View {

    // Use the first 3 users from SampleData.
    private let users: [User] = Array(SampleData.sampleUsers.prefix(3))

    public init() {}

    public var body: some View {
        ZStack {
            Color.brandBgLight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Message",
                    onBack: { /* tab root – no back action */ }
                )

                messagesList
            }
        }
    }

    // MARK: - Messages list

    private var messagesList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(users) { user in
                    MessageListItem(user: user)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - MessageListItem

private struct MessageListItem: View {
    let user: User

    var body: some View {
        HStack(spacing: 12) {
            // 64x64 circular avatar
            AvatarView(
                name: user.name,
                colorHex: user.avatarColor,
                size: .medium
            )

            // Middle: name + preview
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundColor(.brandBlack)
                    .lineLimit(1)

                Text("Let's talk about the feelings that are hard to say out loud.")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Right: time
            Text("12:00")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.gray)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview("MessageListView") {
    MessageListView()
}

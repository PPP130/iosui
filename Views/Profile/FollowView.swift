//
//  FollowView.swift
//  HI - Emotion Social App
//
//  Following list screen. A vertical list of users that the
//  current user is following. Each row shows a 64pt circular
//  avatar, the user's name in bold, and a small black "more" dot
//  icon (3 vertical dots) on the right. Rows are separated by
//  16pt of vertical space.
//

import SwiftUI

// MARK: - FollowView

public struct FollowView: View {

    // Sample data
    private let followings: [User] = SampleData.sampleFollowings

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Following",
                    onBack: { dismiss() }
                )

                if followings.isEmpty {
                    emptyState
                } else {
                    followingsList
                }
            }
        }
    }

    // MARK: - List

    private var followingsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(followings) { user in
                    FollowRow(user: user)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
    }

    // MARK: - Empty state

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "person.2")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(.brandBlack.opacity(0.3))

            Text("No followings yet")
                .font(.brandBody)
                .foregroundColor(.brandBlack.opacity(0.5))

            Text("Find people to follow from the community.")
                .font(.brandCaption)
                .foregroundColor(.brandBlack.opacity(0.4))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
        }
    }
}

// MARK: - FollowRow

private struct FollowRow: View {
    let user: User

    var body: some View {
        HStack(spacing: 14) {
            // 64pt circular avatar
            AvatarView(
                name: user.name,
                colorHex: user.avatarColor,
                size: .medium
            )

            // Name
            Text(user.name.lowercased())
                .font(.brandHeadline)
                .foregroundColor(.brandBlack)

            Spacer()

            // Small black "more" dot icon (3 vertical dots)
            Button(action: { /* show more options */ }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.brandBlack)
                    .frame(width: 32, height: 32)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Preview

#Preview("FollowView") {
    FollowView()
}

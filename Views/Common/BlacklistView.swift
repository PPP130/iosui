//
//  BlacklistView.swift
//  HI - Emotion Social App
//
//  Page listing the users that the current user has blocked. Each
//  row shows a 64pt circular avatar, a bold name, and a black trash
//  icon button on the right that removes the user from the list.
//

import SwiftUI

// MARK: - BlacklistView

public struct BlacklistView: View {

    // Public API
    public let onBack: () -> Void

    // State
    @State private var users: [User]
    @Environment(\.dismiss) private var dismiss

    public init(
        users: [User] = SampleData.sampleBlacklists,
        onBack: @escaping () -> Void = {}
    ) {
        self._users = State(initialValue: users)
        self.onBack = onBack
    }

    public var body: some View {
        ZStack {
            Color.brandBgLight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Blacklist",
                    onBack: {
                        onBack()
                        dismiss()
                    }
                )

                if users.isEmpty {
                    Spacer()
                    EmptyStateView(
                        title: "No blocked users",
                        message: "When you block someone, they show up here.",
                        refreshTitle: "Refresh"
                    )
                    Spacer()
                } else {
                    list
                }
            }
        }
    }

    // MARK: - List

    private var list: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(users) { user in
                    BlacklistRow(user: user) {
                        remove(user)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)

                    if user.id != users.last?.id {
                        Divider()
                            .background(Color.brandDivider)
                            .padding(.leading, 20 + 64 + 16)
                    }
                }
            }
            .padding(.top, 8)
        }
    }

    private func remove(_ user: User) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            users.removeAll { $0.id == user.id }
        }
    }
}

// MARK: - Blacklist row

private struct BlacklistRow: View {
    let user: User
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            AvatarView(
                name: user.name,
                colorHex: user.avatarColor,
                size: .medium // 64pt
            )

            Text(user.name)
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundColor(.brandBlack)

            Spacer()

            Button(action: onDelete) {
                Image(systemName: "trash.fill")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.brandBlack)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle().fill(Color.brandBlack.opacity(0.06))
                    )
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Remove \(user.name) from blacklist")
        }
    }
}

// MARK: - Preview

#Preview("BlacklistView") {
    BlacklistView(
        users: SampleData.sampleBlacklists,
        onBack: { print("Back tapped") }
    )
}

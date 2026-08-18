//
//  GroupDetailView.swift
//  HI - Emotion Social App
//
//  Group chat page for a single MoodGroup. Light gray background,
//  top bar with title and an alert button, one welcoming message
//  bubble from the group, and a rounded input bar with a cyan
//  paper-plane send button.
//

import SwiftUI

// MARK: - GroupDetailView

public struct GroupDetailView: View {

    // The group we're viewing
    public let group: MoodGroup

    // Local state
    @State private var inputText: String = ""

    // The single welcome message that ships with the view
    private let welcomeMessage: String =
        "Share the feelings you can't say out loud in a quiet space."

    public init(group: MoodGroup) {
        self.group = group
    }

    public var body: some View {
        ZStack {
            // Light gray background
            Color.brandBgLight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                TopBarView(
                    title: group.name,
                    onBack: { /* pop back to list */ },
                    onAlert: { /* show report / alert */ }
                )

                // Messages area
                messagesArea

                // Input bar
                inputBar
                    .padding(.horizontal, 12)
                    .padding(.bottom, 10)
                    .padding(.top, 4)
            }
        }
    }

    // MARK: - Messages area

    private var messagesArea: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                // Date / context strip
                HStack {
                    Spacer()
                    Text("Today")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(.brandBlack.opacity(0.45))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule().fill(Color.brandBlack.opacity(0.05))
                        )
                    Spacer()
                }
                .padding(.top, 6)

                // One left-aligned message bubble
                HStack(alignment: .top, spacing: 8) {
                    AvatarView(
                        name: group.name,
                        colorHex: group.memberAvatars.first ?? "#A0E8F0",
                        size: .small
                    )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(group.name)
                            .font(.system(size: 11, weight: .heavy, design: .rounded))
                            .foregroundColor(.brandBlack.opacity(0.55))

                        MessageBubble(
                            text: welcomeMessage,
                            isFromCurrentUser: false
                        )
                    }

                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 16)

                // Small hint under the welcome bubble
                HStack(spacing: 6) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.brandPrimary)
                    Text("Be kind. Be honest. Be you.")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(.brandBlack.opacity(0.45))
                }
                .padding(.leading, 56)
                .padding(.top, 2)
            }
            .padding(.bottom, 16)
        }
    }

    // MARK: - Input bar

    private var inputBar: some View {
        HStack(spacing: 10) {
            // Rounded input field
            HStack(spacing: 8) {
                TextField(
                    "",
                    text: $inputText,
                    prompt: Text("Please enter...")
                        .foregroundColor(.brandBlack.opacity(0.35))
                )
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.brandBlack)
            }
            .padding(.horizontal, 14)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 23, style: .continuous)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 23, style: .continuous)
                    .stroke(Color.brandBlack.opacity(0.06), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)

            // Cyan paper-plane send button
            Button(action: { /* send */ }) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.brandPrimary, Color.brandPrimary.opacity(0.85)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 46, height: 46)
                        .shadow(color: Color.brandPrimary.opacity(0.45),
                                radius: 6, x: 0, y: 3)

                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(.brandBlack)
                        .offset(x: -1) // visual centering for the angled plane
                }
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Preview

#Preview("GroupDetailView") {
    GroupDetailView(
        group: MoodGroup(
            name: "Quiet Thoughts",
            description: "A circle for the things you almost didn't say.",
            memberAvatars: ["#A0E8F0", "#C8B6FF", "#F5F5F5", "#B5E2C2"],
            category: "CIRCLE"
        )
    )
}

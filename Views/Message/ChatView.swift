//
//  ChatView.swift
//  HI - Emotion Social App
//
//  1-on-1 chat page. Light gray background, scrollable message
//  bubbles (white for the other user, cyan for the current user),
//  and a rounded input bar at the bottom.
//

import SwiftUI

// MARK: - ChatView

public struct ChatView: View {

    // Sample data
    private let otherUser: User = SampleData.lex
    private let initialMessages: [Message] = SampleData.sampleMessages

    // State
    @State private var messages: [Message]
    @State private var inputText: String = ""
    @Environment(\.dismiss) private var dismiss

    public init() {
        // Use the first 4 messages from sample data as a default
        _messages = State(initialValue: Array(SampleData.sampleMessages.prefix(4)))
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            Color.brandBgLight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                customTopBar
                messagesScroll
            }

            inputBar
        }
        .navigationBarHidden(true)
    }

    // MARK: - Top bar (custom – includes a pink video icon + alert)

    private var customTopBar: some View {
        HStack(spacing: 10) {
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

            // Title
            Text(otherUser.name)
                .font(.system(size: 17, weight: .heavy, design: .rounded))
                .foregroundColor(.brandBlack)
                .frame(maxWidth: .infinity)

            // Pink video icon
            Button {
                // video tapped
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.brandPink.opacity(0.15))
                        .frame(width: 32, height: 32)
                    Image(systemName: "video.fill")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(Color.brandPink)
                }
                .frame(width: 40, height: 40)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            // "!" alert button
            Button {
                // alert tapped
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

    // MARK: - Messages scroll

    private var messagesScroll: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(messages) { message in
                    MessageBubble(
                        text: message.text,
                        isFromCurrentUser: message.isFromCurrentUser
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
    }

    // MARK: - Input bar

    private var inputBar: some View {
        HStack(spacing: 10) {
            InputField(placeholder: "Please enter...", text: $inputText)

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
}

// MARK: - Preview

#Preview("ChatView") {
    ChatView()
}

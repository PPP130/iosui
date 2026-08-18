//
//  AIChatView.swift
//  HI - Emotion Social App
//
//  Chat with an AI character. Full-screen background gradient
//  (placeholder for the AI portrait) with chat bubbles floating
//  over it. Bubbles are semi-transparent white for the AI, cyan
//  for the current user.
//

import SwiftUI

// MARK: - AIChatView

public struct AIChatView: View {

    // Sample data
    private let character: AICharacter = SampleData.sampleAICharacters.first ?? SampleData.sampleAICharacters[0]

    // A small fixed sample conversation – alternating AI / user
    private let initialMessages: [AIChatMessage] = [
        AIChatMessage(text: "Hi, I am Selene. How is your night treating you?", isFromCurrentUser: false),
        AIChatMessage(text: "A little restless. I can't quite settle.", isFromCurrentUser: true),
        AIChatMessage(text: "That sounds heavy. Want to tell me what's been on your mind?", isFromCurrentUser: false),
        AIChatMessage(text: "I just keep replaying today in my head.", isFromCurrentUser: true),
        AIChatMessage(text: "Take a slow breath. We can sit with it together for a while.", isFromCurrentUser: false)
    ]

    @State private var messages: [AIChatMessage]
    @State private var inputText: String = ""

    public init() {
        _messages = State(initialValue: [
            AIChatMessage(text: "Hi, I am Selene. How is your night treating you?", isFromCurrentUser: false),
            AIChatMessage(text: "A little restless. I can't quite settle.", isFromCurrentUser: true),
            AIChatMessage(text: "That sounds heavy. Want to tell me what's been on your mind?", isFromCurrentUser: false),
            AIChatMessage(text: "I just keep replaying today in my head.", isFromCurrentUser: true),
            AIChatMessage(text: "Take a slow breath. We can sit with it together for a while.", isFromCurrentUser: false)
        ])
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Full-screen background "portrait" placeholder
            LinearGradient(
                colors: [
                    Color(red: 0.18, green: 0.45, blue: 0.40),
                    Color(red: 0.05, green: 0.18, blue: 0.20)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Subtle vignette to give a portrait feel
            RadialGradient(
                colors: [Color.white.opacity(0.10), Color.clear],
                center: .center,
                startRadius: 40,
                endRadius: 600
            )
            .ignoresSafeArea()
            .allowsHitTesting(false)

            VStack(spacing: 0) {
                topBar
                messagesScroll
            }

            inputBar
        }
        .navigationBarHidden(true)
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack(spacing: 0) {
            // Spacer mirror for centering
            Color.clear
                .frame(width: 40, height: 40)

            Text(character.name)
                .font(.system(size: 17, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

            Button {
                // alert tapped
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.20))
                        .frame(width: 32, height: 32)
                    Text("!")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(Color.clear)
    }

    // MARK: - Messages

    private var messagesScroll: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(messages) { message in
                    AIChatBubble(message: message)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
    }

    // MARK: - Input bar

    private var inputBar: some View {
        HStack(spacing: 10) {
            InputField(placeholder: "Please enter...", text: $inputText)

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
            Color.white.opacity(0.92)
                .shadow(color: .black.opacity(0.10), radius: 8, x: 0, y: -2)
        )
    }
}

// MARK: - AIChatMessage

private struct AIChatMessage: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let isFromCurrentUser: Bool
}

// MARK: - AIChatBubble

private struct AIChatBubble: View {
    let message: AIChatMessage

    var body: some View {
        HStack {
            if message.isFromCurrentUser { Spacer(minLength: 40) }

            Text(message.text)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(message.isFromCurrentUser ? .white : .brandBlack)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(bubbleColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(message.isFromCurrentUser ? 0.10 : 0.40), lineWidth: 1)
                )
                .frame(maxWidth: 280, alignment: message.isFromCurrentUser ? .trailing : .leading)

            if !message.isFromCurrentUser { Spacer(minLength: 40) }
        }
    }

    private var bubbleColor: Color {
        // AI messages: semi-transparent white
        // Current user messages: cyan
        if message.isFromCurrentUser {
            return Color.brandPrimary
        } else {
            return Color.white.opacity(0.88)
        }
    }
}

// MARK: - Preview

#Preview("AIChatView") {
    AIChatView()
}

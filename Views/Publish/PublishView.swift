//
//  PublishView.swift
//  HI - Emotion Social App
//
//  Post creation screen. Cyan gradient background with a big white
//  rounded card containing the add-image + trash controls, and a
//  black "Post" primary button with a yellow star decoration.
//

import SwiftUI

// MARK: - PublishView

public struct PublishView: View {

    // State
    @State private var postText: String = ""

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Cyan gradient background
            LinearGradient(
                colors: [
                    Color.brandPrimary.opacity(0.55),
                    Color.brandSecondary.opacity(0.35)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Post",
                    onBack: { /* tab root – no back action */ },
                    onAlert: { /* alert tapped */ }
                )

                whiteCard
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                Spacer(minLength: 16)
            }

            // Bottom Post button
            PrimaryButton(title: "Post", trailingIcon: "star.fill") {
                // post tapped
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
    }

    // MARK: - White card

    private var whiteCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Toolbar: + and trash icons
            HStack(spacing: 10) {
                Button {
                    // add image tapped
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.brandBlack.opacity(0.25), lineWidth: 1.5)
                            .frame(width: 36, height: 36)
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.brandBlack)
                    }
                }
                .buttonStyle(.plain)

                Button {
                    // trash tapped
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.brandBlack.opacity(0.6))
                        .frame(width: 36, height: 36)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                Spacer()
            }

            // Hint text
            Text("Add an image to your post")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.gray)

            // Optional caption input
            VStack(alignment: .leading, spacing: 8) {
                Text("Say how you feel")
                    .font(.system(size: 13, weight: .heavy, design: .rounded))
                    .foregroundColor(.brandBlack.opacity(0.6))

                ZStack(alignment: .topLeading) {
                    if postText.isEmpty {
                        Text("Please enter...")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(.brandBlack.opacity(0.35))
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $postText)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 120)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.brandBgLight)
                )
            }

            Spacer(minLength: 0)
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 520)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 6)
    }
}

// MARK: - Preview

#Preview("PublishView") {
    PublishView()
}

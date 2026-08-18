//
//  MoodMatchView.swift
//  HI - Emotion Social App
//
//  Mood-sharing input page. Background is the design asset
//  `mood_match.png` (pink 3D heart with wings, "SHARE YOUR MOOD"
//  headline, white text-input card). A transparent TextEditor floats
//  over the white card in the image so the user can type, a back
//  chevron sits at the top-left, and a black "Start" PrimaryButton
//  sits at the bottom.
//

import SwiftUI

public struct MoodMatchView: View {

    @State private var text: String = ""
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Bottom layer: full-bleed design asset
            ImageLoader.background(AppImages.moodMatch)

            // Top-left back chevron
            BackChevronButton(action: { dismiss() })
                .padding(.leading, 20)
                .padding(.top, 12)

            // Floating text input over the white card baked into the
            // design image. The card visuals come from the asset; the
            // TextEditor is transparent so the typing surface lines
            // up with the white area.
            VStack(spacing: 0) {
                Spacer()

                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text("Write down how you feel now...")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.brandBlack.opacity(0.35))
                            .padding(.horizontal, 24)
                            .padding(.top, 22)
                            .allowsHitTesting(false)
                    }
                    TextEditor(text: $text)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.brandBlack)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                }
                .frame(height: 200)
                .padding(.horizontal, 24)
                .padding(.bottom, 96) // leave room for the Start button
            }
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Start") {
                // TODO: route to MoodMatchingView
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .background(Color.clear)
        }
    }
}

// MARK: - Back chevron button (40x40 white circle + SF Symbol)

private struct BackChevronButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.brandBlack)
            }
        }
        .accessibilityLabel("Back")
    }
}

// MARK: - Preview

#Preview("MoodMatchView") {
    MoodMatchView()
}

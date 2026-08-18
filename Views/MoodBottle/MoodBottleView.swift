//
//  MoodBottleView.swift
//  HI - Emotion Social App
//
//  Mood bottle page. Background is the design asset `mood_bottle.png`
//  which already shows the prompt, the snow-globe bottle and the
//  text-input area. A back chevron sits at the top-left, and a black
//  "Post" PrimaryButton sits at the bottom.
//

import SwiftUI

public struct MoodBottleView: View {

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Bottom layer: full-bleed design asset
            ImageLoader.background(AppImages.moodBottle)

            // Top-left back chevron
            BackChevronButton(action: { dismiss() })
                .padding(.leading, 20)
                .padding(.top, 12)
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Post") {
                // TODO: submit bottle
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

#Preview("MoodBottleView") {
    MoodBottleView()
}

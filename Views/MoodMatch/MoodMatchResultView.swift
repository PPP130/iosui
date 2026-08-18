//
//  MoodMatchResultView.swift
//  HI - Emotion Social App
//
//  Match-results page. Background is the design asset
//  `mood_match_result.png` which already shows the "MATCHING
//  RESULTS" title and the three result cards. Only a back chevron
//  is overlaid.
//

import SwiftUI

public struct MoodMatchResultView: View {

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Bottom layer: full-bleed design asset
            ImageLoader.background(AppImages.moodMatchResult)

            // Top-left back chevron
            BackChevronButton(action: { dismiss() })
                .padding(.leading, 20)
                .padding(.top, 12)
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

#Preview("MoodMatchResultView") {
    MoodMatchResultView()
}

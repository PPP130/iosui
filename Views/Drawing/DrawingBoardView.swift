//
//  DrawingBoardView.swift
//  HI - Emotion Social App
//
//  Drawing board — entry screen for creating a custom emoji. The
//  design image (`AppImages.drawingEmoji`) already contains the
//  2x2 grid of 4 AI character cards with "+" buttons and the
//  emoji row at the bottom. This view only renders a back chevron
//  overlay on top of the image.
//

import SwiftUI

// MARK: - DrawingBoardView

public struct DrawingBoardView: View {

    // Dismiss
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Full-bleed design image
            ImageLoader.background(AppImages.drawingEmoji)

            // Back chevron (top-left)
            backButton
                .padding(.leading, 16)
                .padding(.top, 12)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Back button

    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)

                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.black)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Back")
    }
}

// MARK: - Preview

#Preview("DrawingBoardView") {
    DrawingBoardView()
}

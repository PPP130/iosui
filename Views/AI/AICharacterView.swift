//
//  AICharacterView.swift
//  HI - Emotion Social App
//
//  AI character selection grid. Built on top of the
//  `AppImages.aiCharacter` design PNG which already contains the
//  "AI CHARACTER" title, the 3D yellow robot decoration, and the
//  2x4 grid of 8 character cards. This view only renders a back
//  chevron overlay on top of the image and tracks the local
//  selection state.
//

import SwiftUI

// MARK: - AICharacterView

public struct AICharacterView: View {

    // State
    @State private var selectedId: UUID? = nil

    // Dismiss
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Full-bleed design image
            ImageLoader.background(AppImages.aiCharacter)

            // Back chevron (top-left)
            backButton
                .padding(.leading, 16)
                .padding(.top, 12)
        }
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

#Preview("AICharacterView") {
    AICharacterView()
}

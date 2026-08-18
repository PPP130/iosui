//
//  GroupListView.swift
//  HI - Emotion Social App
//
//  Discussion circles list. The design image
//  (`AppImages.groupList`) already contains the "WELCOME" title,
//  the 3D emoji / tag decorations, the overlapping
//  DISCUSSION / CIRCLE tags, and the 2-column grid of 10 group
//  cards. This view only renders a back chevron overlay anchored
//  at the top-left of the safe area.
//

import SwiftUI

// MARK: - GroupListView

public struct GroupListView: View {

    // Dismiss
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Full-bleed design image
            ImageLoader.background(AppImages.groupList)

            // Back chevron (top-left, inside safe area)
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

#Preview("GroupListView") {
    GroupListView()
}

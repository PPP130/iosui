//
//  UserProfileView.swift
//  HI - Emotion Social App
//
//  Other user's profile screen. Uses the real design PNG (which
//  contains the 96pt avatar, name "Lex", Follow button, post
//  cards, and pink Video Call button). Floating back chevron at
//  top-left and alert "!" button at top-right.
//

import SwiftUI

public struct UserProfileView: View {

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Bottom layer: the real design image
            ImageLoader.background(AppImages.userProfile)

            // Top-left back chevron
            backButton

            // Top-right alert "!" button
            alertButton
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
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
                    .foregroundColor(.brandBlack)
            }
        }
        .buttonStyle(.plain)
        .padding(.top, 12)
        .padding(.leading, 16)
    }

    // MARK: - Alert button

    private var alertButton: some View {
        Button {
            // report / block action
        } label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)

                Text("!")
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .foregroundColor(.brandBlack)
            }
        }
        .buttonStyle(.plain)
        .padding(.top, 12)
        .padding(.trailing, 16)
    }
}

// MARK: - Preview

#Preview("UserProfileView") {
    UserProfileView()
}

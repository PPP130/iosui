//
//  WalletView.swift
//  HI - Emotion Social App
//
//  Wallet / coins screen. Uses the real design PNG (which
//  contains the 3D decorations, "My Wallet" tag, Balance: 0, and
//  the 3x3 coin grid). Floating back chevron at top-left.
//

import SwiftUI

public struct WalletView: View {

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Bottom layer: the real design image
            ImageLoader.background(AppImages.wallet)

            // Top-left back chevron
            backButton
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
}

// MARK: - Preview

#Preview("WalletView") {
    WalletView()
}

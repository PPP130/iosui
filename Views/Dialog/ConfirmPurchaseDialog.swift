//
//  ConfirmPurchaseDialog.swift
//  HI - Emotion Social App
//
//  Confirm-purchase modal overlay used before spending gems. Sits on
//  top of a "mood bottle" page mock, with a pink headline, body text,
//  a 3D yellow star decoration, and a black "Get it" CTA button.
//
//  Use as a self-contained view that shows when its `isPresented`
//  binding is true, or apply via the `.confirmPurchaseDialog(...)`
//  view modifier.
//

import SwiftUI

// MARK: - ConfirmPurchaseDialog

public struct ConfirmPurchaseDialog: View {

    // Public API
    public let gemCost: Int
    public let onConfirm: () -> Void
    public let onCancel: () -> Void

    public init(
        gemCost: Int = 50,
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {}
    ) {
        self.gemCost = gemCost
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }

    public var body: some View {
        ZStack {
            // Scrim
            Color.black.opacity(0.35)
                .ignoresSafeArea()

            // The "mood bottle" page mock sitting underneath the card.
            mockUnderlyingPage

            // The centered card.
            card
                .padding(.horizontal, 20)
                .transition(.scale(scale: 0.92).combined(with: .opacity))
        }
    }

    // MARK: - Card

    private var card: some View {
        VStack(spacing: 0) {
            // Header (pink title + close)
            HStack {
                Spacer()
                Button(action: onCancel) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.brandBlack.opacity(0.45))
                        .frame(width: 28, height: 28)
                        .background(
                            Circle().fill(Color.brandBlack.opacity(0.06))
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 14)
            .padding(.trailing, 14)

            // Pink title
            Text("Confirm Purchase")
                .font(.system(size: 28, weight: .black, design: .rounded))
                .foregroundColor(Color.brandPink)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .padding(.horizontal, 12)

            // Body text
            Text("Proceed by spending \(gemCost) gems\nDo you agree to continue?")
                .font(.brandBody)
                .foregroundColor(.brandBlack)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.top, 14)
                .padding(.horizontal, 24)

            // 3D star decoration (bottom-right of card content area)
            ZStack(alignment: .bottomTrailing) {
                Color.clear.frame(height: 110)
                Star3D()
                    .frame(width: 86, height: 86)
                    .padding(.trailing, 18)
                    .padding(.bottom, 0)
            }

            // Get it button
            PrimaryButton(title: "Get it") {
                onConfirm()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.25), radius: 24, x: 0, y: 12)
    }

    // MARK: - Mock underlying page

    private var mockUnderlyingPage: some View {
        VStack(spacing: 0) {
            // Mock top bar
            HStack {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.brandBlack)
                Spacer()
                Text("Mood Bottle")
                    .font(.brandHeadline)
                    .foregroundColor(.brandBlack)
                Spacer()
                Color.clear.frame(width: 18, height: 18)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)

            // Mock mood bottle card
            VStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.brandPrimary, Color.brandSecondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay(
                        Image(systemName: "drop.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.white.opacity(0.8))
                    )

                Text("A bottle full of calm thoughts")
                    .font(.brandHeadline)
                    .foregroundColor(.brandBlack)

                Text("Open it to read what others have been feeling today.")
                    .font(.brandBody)
                    .foregroundColor(.brandGrayText)
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.white)
            )
            .padding(.horizontal, 20)
            .padding(.top, 8)

            Spacer()
        }
        .background(Color.brandBgLight.ignoresSafeArea())
    }
}

// MARK: - 3D yellow star decoration

private struct Star3D: View {
    var body: some View {
        ZStack {
            // Soft outer glow shadow
            Image(systemName: "star.fill")
                .font(.system(size: 56, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.95, blue: 0.4),
                            Color(red: 1.0, green: 0.78, blue: 0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.20), radius: 6, x: 0, y: 4)

            // Inner highlight for 3D feel
            Image(systemName: "star.fill")
                .font(.system(size: 56, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.85),
                            Color.white.opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .blendMode(.screen)
                .mask(
                    Image(systemName: "star.fill")
                        .font(.system(size: 56, weight: .black))
                )
        }
    }
}

// MARK: - View modifier

public extension View {
    /// Presents a `ConfirmPurchaseDialog` when `isPresented` is true.
    func confirmPurchaseDialog(
        isPresented: Binding<Bool>,
        gemCost: Int = 50,
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        ZStack {
            self

            if isPresented.wrappedValue {
                ConfirmPurchaseDialog(
                    gemCost: gemCost,
                    onConfirm: {
                        isPresented.wrappedValue = false
                        onConfirm()
                    },
                    onCancel: {
                        isPresented.wrappedValue = false
                        onCancel()
                    }
                )
                .zIndex(1)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isPresented.wrappedValue)
    }
}

// MARK: - Preview

#Preview("ConfirmPurchaseDialog") {
    struct PreviewWrapper: View {
        @State private var show = true

        var body: some View {
            Color.brandBgLight
                .ignoresSafeArea()
                .confirmPurchaseDialog(
                    isPresented: $show,
                    gemCost: 50,
                    onConfirm: { print("Get it tapped") },
                    onCancel: { print("Cancel tapped") }
                )
        }
    }

    return PreviewWrapper()
}

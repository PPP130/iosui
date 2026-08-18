//
//  EmptyStateView.swift
//  HI - Emotion Social App
//
//  Reusable empty-state placeholder. Used by any list view when its
//  data is empty. A large gray rounded square with a sad face icon,
//  a gray "No data yet" message, and an optional cyan "Refresh"
//  button below.
//

import SwiftUI

// MARK: - EmptyStateView

public struct EmptyStateView: View {

    // Public API
    public let title: String
    public let message: String
    public let refreshTitle: String
    public let onRefresh: (() -> Void)?

    // Internal
    @State private var isRefreshing: Bool = false

    public init(
        title: String = "No data yet",
        message: String = "When there is something new, it will appear here.",
        refreshTitle: String = "Refresh",
        onRefresh: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.refreshTitle = refreshTitle
        self.onRefresh = onRefresh
    }

    public var body: some View {
        VStack(spacing: 18) {
            iconBlock
            Text(title)
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundColor(.brandGrayText)
            if !message.isEmpty {
                Text(message)
                    .font(.brandCaption)
                    .foregroundColor(.brandGrayText.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            refreshButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Icon block

    private var iconBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.brandBgLight)
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.brandDivider, lineWidth: 1)
                )
                .frame(width: 140, height: 140)

            SadFaceIcon()
                .frame(width: 84, height: 84)
        }
    }

    // MARK: - Refresh button

    @ViewBuilder
    private var refreshButton: some View {
        if let onRefresh = onRefresh {
            Button(action: handleRefresh) {
                HStack(spacing: 6) {
                    if isRefreshing {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Text(refreshTitle)
                        .font(.system(size: 14, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 18)
                .frame(height: 38)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.brandPrimary)
                )
            }
            .buttonStyle(.plain)
            .disabled(isRefreshing)
            .opacity(isRefreshing ? 0.7 : 1.0)
        }
    }

    private func handleRefresh() {
        guard !isRefreshing else { return }
        isRefreshing = true
        // Briefly show the spinner so the action is visible, then call out.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            isRefreshing = false
            onRefresh?()
        }
    }
}

// MARK: - Sad face icon

private struct SadFaceIcon: View {
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let radius = min(size.width, size.height) * 0.40
            let stroke = GraphicsContext.Shading.color(Color.brandGrayText)

            // Face circle
            let faceRect = CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            )
            context.stroke(
                Path(ellipseIn: faceRect),
                with: stroke,
                style: StrokeStyle(lineWidth: 5, lineCap: .round)
            )

            // Eyes (X marks for a sad "stunned" look)
            let eyeRadius: CGFloat = 3.5
            let eyeOffsetX = radius * 0.32
            let eyeOffsetY = radius * 0.22
            drawXMark(
                at: CGPoint(x: center.x - eyeOffsetX, y: center.y - eyeOffsetY),
                size: eyeRadius,
                in: &context,
                shading: stroke
            )
            drawXMark(
                at: CGPoint(x: center.x + eyeOffsetX, y: center.y - eyeOffsetY),
                size: eyeRadius,
                in: &context,
                shading: stroke
            )

            // Frown
            var mouth = Path()
            let mouthY = center.y + radius * 0.30
            let mouthWidth = radius * 0.50
            mouth.move(to: CGPoint(x: center.x - mouthWidth, y: mouthY))
            mouth.addQuadCurve(
                to: CGPoint(x: center.x + mouthWidth, y: mouthY),
                control: CGPoint(x: center.x, y: mouthY + radius * 0.35)
            )
            context.stroke(
                mouth,
                with: stroke,
                style: StrokeStyle(lineWidth: 5, lineCap: .round)
            )
        }
    }

    private func drawXMark(
        at center: CGPoint,
        size: CGFloat,
        in context: inout GraphicsContext,
        shading: GraphicsContext.Shading
    ) {
        var path = Path()
        path.move(to: CGPoint(x: center.x - size, y: center.y - size))
        path.addLine(to: CGPoint(x: center.x + size, y: center.y + size))
        path.move(to: CGPoint(x: center.x + size, y: center.y - size))
        path.addLine(to: CGPoint(x: center.x - size, y: center.y + size))
        context.stroke(
            path,
            with: shading,
            style: StrokeStyle(lineWidth: 3, lineCap: .round)
        )
    }
}

// MARK: - Preview

#Preview("EmptyStateView") {
    VStack(spacing: 0) {
        TopBarView(title: "Inbox", onBack: { print("Back tapped") })
        EmptyStateView(
            title: "No data yet",
            message: "Tap refresh to check for new content.",
            refreshTitle: "Refresh",
            onRefresh: { print("Refresh tapped") }
        )
    }
    .background(Color.white)
}

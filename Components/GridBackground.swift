//
//  GridBackground.swift
//  HI - Emotion Social App
//
//  The signature "rounded square grid" background.
//  Renders a grid of rounded white squares (12pt radius, 50pt size, 12pt spacing)
//  with 0.25 white opacity over a cyan gradient using Canvas.
//

import SwiftUI

// MARK: - ViewModifier

/// A `ViewModifier` that draws the brand's signature rounded-square grid background
/// on top of a cyan-to-white vertical gradient. Use via `.gridBackground()`.
public struct GridBackgroundModifier: ViewModifier {

    // Grid configuration
    private let squareSize: CGFloat = 50
    private let spacing: CGFloat = 12
    private let cornerRadius: CGFloat = 12
    private let squareColor: Color = .white.opacity(0.25)

    public init() {}

    public func body(content: Content) -> some View {
        ZStack {
            // Base gradient
            LinearGradient(
                colors: [
                    Color(red: 0.69, green: 0.91, blue: 0.94),
                    .white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Rounded square grid
            GeometryReader { proxy in
                Canvas { context, size in
                    let totalStep = squareSize + spacing
                    let columns = Int(ceil(size.width / totalStep)) + 1
                    let rows = Int(ceil(size.height / totalStep)) + 1

                    // Center the grid horizontally and vertically
                    let xOffset = (size.width - CGFloat(columns) * totalStep) / 2
                    let yOffset = (size.height - CGFloat(rows) * totalStep) / 2

                    for row in 0..<rows {
                        for col in 0..<columns {
                            let x = xOffset + CGFloat(col) * totalStep
                            let y = yOffset + CGFloat(row) * totalStep
                            let rect = CGRect(
                                x: x,
                                y: y,
                                width: squareSize,
                                height: squareSize
                            )
                            let path = Path(roundedRect: rect, cornerRadius: cornerRadius)
                            context.fill(path, with: .color(squareColor))
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)

            // Foreground content
            content
        }
    }
}

// MARK: - View extension

public extension View {
    /// Applies the signature rounded-square grid background.
    func gridBackground() -> some View {
        modifier(GridBackgroundModifier())
    }
}

// MARK: - Preview

#Preview("Grid Background") {
    VStack(spacing: 20) {
        Text("HI")
            .font(.system(size: 60, weight: .heavy))
            .foregroundColor(.brandBlack)

        Text("rounded square grid")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.brandBlack.opacity(0.7))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .gridBackground()
}

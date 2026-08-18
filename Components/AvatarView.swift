//
//  AvatarView.swift
//  HI - Emotion Social App
//
//  Circular avatar with a colored gradient background and name initial.
//  Available in four sizes: small(40), medium(64), large(96), xlarge(140).
//

import SwiftUI

// MARK: - AvatarView

public struct AvatarView: View {

    public enum Size: CGFloat {
        case small = 40
        case medium = 64
        case large = 96
        case xlarge = 140
    }

    // Public API
    public let name: String
    public let colorHex: String
    public let size: Size

    public init(name: String, colorHex: String, size: Size = .medium) {
        self.name = name
        self.colorHex = colorHex
        self.size = size
    }

    // Initial character (uppercased)
    private var initial: String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let first = trimmed.first else { return "?" }
        return String(first).uppercased()
    }

    // Convert hex string to a lighter/darker pair for the gradient
    private var gradientColors: [Color] {
        let base = Color(hex: colorHex) ?? Color.brandPrimary
        let lighter = base.lighter(by: 0.18)
        let darker = base.darker(by: 0.18)
        return [lighter, darker]
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // Soft inner highlight for a subtle 3D feel
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.30), Color.white.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .center
                    )
                )

            Text(initial)
                .font(.system(size: size.fontSize, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
        }
        .frame(width: size.rawValue, height: size.rawValue)
        .overlay(
            Circle()
                .stroke(Color.white.opacity(0.6), lineWidth: max(1, size.rawValue * 0.015))
        )
    }
}

// MARK: - Size helpers

private extension AvatarView.Size {
    var fontSize: CGFloat {
        switch self {
        case .small:  return 16
        case .medium: return 26
        case .large:  return 40
        case .xlarge: return 58
        }
    }
}

// MARK: - Color utilities

extension Color {
    /// Initialize a Color from a hex string like "#FFAA00" or "FFAA00".
    init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") { hexString.removeFirst() }

        guard hexString.count == 6 || hexString.count == 8 else { return nil }
        if hexString.count == 8 { hexString.removeFirst() } // strip alpha if provided

        var rgb: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&rgb) else { return nil }

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }

    /// Returns a lighter color by mixing with white.
    func lighter(by amount: CGFloat) -> Color {
        mix(with: .white, amount: amount)
    }

    /// Returns a darker color by mixing with black.
    func darker(by amount: CGFloat) -> Color {
        mix(with: .black, amount: amount)
    }

    /// Mix this color with `other` by `amount` (0...1).
    func mix(with other: Color, amount: CGFloat) -> Color {
        let a = max(0, min(1, amount))
        let comps1 = self.rgbComponents()
        let comps2 = other.rgbComponents()
        return Color(
            red: comps1.r + (comps2.r - comps1.r) * Double(a),
            green: comps1.g + (comps2.g - comps1.g) * Double(a),
            blue: comps1.b + (comps2.b - comps1.b) * Double(a)
        )
    }

    /// Extracts RGB components in sRGB color space.
    func rgbComponents() -> (r: Double, g: Double, b: Double) {
        #if canImport(UIKit)
        let ui = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        ui.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b))
        #else
        return (0, 0, 0)
        #endif
    }
}

// MARK: - Preview

#Preview("AvatarView") {
    HStack(spacing: 16) {
        VStack(spacing: 12) {
            AvatarView(name: "Alice", colorHex: "#FF6B6B", size: .small)
            Text("small").font(.caption)
        }
        VStack(spacing: 12) {
            AvatarView(name: "Bob", colorHex: "#4ECDC4", size: .medium)
            Text("medium").font(.caption)
        }
        VStack(spacing: 12) {
            AvatarView(name: "Cathy", colorHex: "#556270", size: .large)
            Text("large").font(.caption)
        }
        VStack(spacing: 12) {
            AvatarView(name: "Dan", colorHex: "#C44569", size: .xlarge)
            Text("xlarge").font(.caption)
        }
    }
    .padding(20)
    .gradientBackground()
}

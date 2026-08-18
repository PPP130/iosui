//
//  SectionTitle.swift
//  HI - Emotion Social App
//
//  Big bold black rounded text used for section headings and titles.
//  Three styles: .title (40pt), .section (28pt), .headline (20pt).
//

import SwiftUI

// MARK: - SectionTitle

public struct SectionTitle: View {

    public enum Style {
        case title      // 40pt - hero
        case section    // 28pt - section
        case headline   // 20pt - small section
    }

    // Public API
    public let text: String
    public let style: Style

    public init(_ text: String, style: Style = .title) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .heavy, design: .rounded))
            .foregroundColor(.brandBlack)
            .lineLimit(lineLimit)
            .minimumScaleFactor(0.6)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: - Style helpers

    private var fontSize: CGFloat {
        switch style {
        case .title:    return 40
        case .section:  return 28
        case .headline: return 20
        }
    }

    private var lineLimit: Int {
        switch style {
        case .title:    return 3
        case .section:  return 3
        case .headline: return 2
        }
    }
}

// MARK: - Preview

#Preview("SectionTitle") {
    VStack(alignment: .leading, spacing: 24) {
        SectionTitle("Hello, how do you feel today?", style: .title)
        SectionTitle("Today's Mood", style: .section)
        SectionTitle("Recent", style: .headline)
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .gradientBackground()
}

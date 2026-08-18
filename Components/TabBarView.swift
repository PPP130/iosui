//
//  TabBarView.swift
//  HI - Emotion Social App
//
//  Custom 4-tab bottom bar:
//   - Home:      face.smiling
//   - AI:        flame
//   - Favorite:  star
//   - Me:        person
//
//  Selected state: filled cyan. Unselected: gray outline.
//  Custom implementation, NOT using SwiftUI's TabView.
//

import SwiftUI

// MARK: - TabBarItem

public enum TabBarItem: Int, CaseIterable, Identifiable {
    case home, ai, favorite, me

    public var id: Int { rawValue }

    public var title: String {
        switch self {
        case .home:     return "Home"
        case .ai:       return "AI"
        case .favorite: return "Favorite"
        case .me:       return "Me"
        }
    }

    public var icon: String {
        switch self {
        case .home:     return "face.smiling"
        case .ai:       return "flame"
        case .favorite: return "star"
        case .me:       return "person"
        }
    }
}

// MARK: - TabBarView

public struct TabBarView: View {

    // Public API
    @Binding public var selection: TabBarItem

    public init(selection: Binding<TabBarItem>) {
        self._selection = selection
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBarItem.allCases) { item in
                TabBarButton(
                    item: item,
                    isSelected: item == selection
                ) {
                    // Avoid redundant updates
                    if selection != item {
                        selection = item
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .padding(.bottom, 18)
        .background(
            ZStack {
                // White card background
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: -3)
            }
        )
        .overlay(
            // Top divider line
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
    }
}

// MARK: - TabBarButton

private struct TabBarButton: View {
    let item: TabBarItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        // Filled cyan background for selected
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.69, green: 0.91, blue: 0.94),
                                        Color.brandPrimary
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 48, height: 48)
                            .shadow(color: Color.brandPrimary.opacity(0.35), radius: 6, x: 0, y: 3)
                    }

                    Image(systemName: item.icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(iconColor)
                        .symbolRenderingMode(.hierarchical)
                }
                .frame(width: 48, height: 48)

                Text(item.title)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(TabBarButtonStyle())
    }

    private var iconColor: Color {
        isSelected ? .white : .gray
    }

    private var textColor: Color {
        isSelected ? Color.brandBlack : .gray
    }
}

// MARK: - Press feedback style

private struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview("TabBarView") {
    struct TabBarPreviewWrapper: View {
        @State private var selected: TabBarItem = .home

        var body: some View {
            VStack(spacing: 0) {
                Spacer()
                TabBarView(selection: $selected)
            }
            .gradientBackground()
            .ignoresSafeArea(edges: .bottom)
        }
    }

    return TabBarPreviewWrapper()
}

//
//  ReportBlockView.swift
//  HI - Emotion Social App
//
//  Block & Report screen. Top bar with back chevron only. A list of
//  report reasons (each with a bold label and a chevron right) sits
//  above a full-width coral red "Block" CTA at the bottom.
//

import SwiftUI

// MARK: - ReportReason

public enum ReportReason: String, CaseIterable, Identifiable {
    case pornographic   = "Pornographic content"
    case language       = "Language violence"
    case religion       = "Religious discrimination"
    case contentError   = "Content error"
    case gender         = "Gender discrimination"

    public var id: String { rawValue }

    public var label: String { rawValue }
}

// MARK: - ReportBlockView

public struct ReportBlockView: View {

    // Public API
    public let onBack: () -> Void
    public let onSelectReason: (ReportReason) -> Void
    public let onBlock: () -> Void

    // State
    @State private var selectedReason: ReportReason?

    public init(
        onBack: @escaping () -> Void = {},
        onSelectReason: @escaping (ReportReason) -> Void = { _ in },
        onBlock: @escaping () -> Void = {}
    ) {
        self.onBack = onBack
        self.onSelectReason = onSelectReason
        self.onBlock = onBlock
    }

    public var body: some View {
        ZStack {
            Color.brandBgLight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Block & Report",
                    onBack: onBack
                )

                reasonList

                Spacer()

                blockButton
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
            }
        }
    }

    // MARK: - Reason list

    private var reasonList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(ReportReason.allCases) { reason in
                    Button {
                        selectedReason = reason
                        onSelectReason(reason)
                    } label: {
                        HStack {
                            Text(reason.label)
                                .font(.system(size: 17, weight: .heavy, design: .rounded))
                                .foregroundColor(.brandBlack)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.brandBlack.opacity(0.35))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 18)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    if reason != ReportReason.allCases.last {
                        Divider()
                            .background(Color.brandDivider)
                            .padding(.leading, 20)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
            )
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }

    // MARK: - Block button

    private var blockButton: some View {
        Button(action: onBlock) {
            Text("Block")
                .font(.system(size: 17, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.brandRed)
                )
                .shadow(color: Color.brandRed.opacity(0.35), radius: 10, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview("ReportBlockView") {
    ReportBlockView(
        onBack: { print("Back tapped") },
        onSelectReason: { reason in
            print("Selected: \(reason.rawValue)")
        },
        onBlock: { print("Block tapped") }
    )
}

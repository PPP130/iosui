//
//  SettingView.swift
//  HI - Emotion Social App
//
//  Settings screen. Light gray background, a TopBarView with
//  only a back arrow and the title "Setting", and a vertical
//  list of settings items separated by 24pt of vertical space.
//  Each row has a bold label and a chevron right.
//

import SwiftUI

// MARK: - SettingsItem

private enum SettingsItem: String, CaseIterable, Identifiable {
    case following      = "Following"
    case privacy        = "Privacy agreement"
    case userAgreement  = "User agreement"
    case deletion       = "Deletion of account"
    case logOut         = "Log Out"

    var id: String { rawValue }

    var isDestructive: Bool {
        switch self {
        case .deletion, .logOut: return true
        default:                 return false
        }
    }
}

// MARK: - SettingView

public struct SettingView: View {

    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some View {
        ZStack {
            Color.brandBgLight
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TopBarView(
                    title: "Setting",
                    onBack: { dismiss() }
                )

                settingsList
            }
        }
    }

    // MARK: - Settings list

    private var settingsList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                ForEach(SettingsItem.allCases) { item in
                    SettingsRow(item: item) {
                        // Handle selection
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
    }
}

// MARK: - SettingsRow

private struct SettingsRow: View {
    let item: SettingsItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(item.rawValue)
                    .font(.brandHeadline)
                    .foregroundColor(item.isDestructive ? Color.brandRed : .brandBlack)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundColor(.brandBlack.opacity(0.45))
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 18)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.black.opacity(0.04), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview("SettingView") {
    SettingView()
}

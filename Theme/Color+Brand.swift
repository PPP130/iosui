//
//  Color+Brand.swift
//  HI - Emotion Social App
//
//  Convenience accessors that bridge the central `AppColors` palette
//  to the `Color.brandXxx` static API used throughout the component
//  and view layers. This keeps every SwiftUI call site readable
//  (`Color.brandPrimary`) while ensuring there is only one source of
//  truth (`AppColors`).
//

import SwiftUI

public extension Color {

    /// Primary cyan blue — main brand color, headlines, primary CTAs.
    static let brandPrimary     = AppColors.primary

    /// Light cyan — secondary accent and soft fills.
    static let brandSecondary   = AppColors.secondary

    /// Pink — heart/love emotion chip and related UI.
    static let brandPink        = AppColors.pink

    /// Yellow — happy/sunny emotion chip and 3D star decoration.
    static let brandYellow      = AppColors.yellow

    /// Purple — calm/dreamy emotion chip.
    static let brandPurple      = AppColors.purple

    /// Coral red — destructive actions such as "Block".
    static let brandRed         = AppColors.redCoral

    /// Pure black — primary text and filled action buttons.
    static let brandBlack       = AppColors.black

    /// Pure white — card surfaces and inverted text.
    static let brandWhite       = AppColors.white

    /// App-wide light blueish off-white background.
    static let brandBgLight     = AppColors.lightBackground

    /// Medium gray used for secondary body text and placeholders.
    static let brandGrayText    = AppColors.grayText

    /// Subtle divider / border gray.
    static let brandDivider     = AppColors.divider
}

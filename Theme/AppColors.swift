//
//  AppColors.swift
//  HI
//
//  Design system color palette extracted from the 44 design images.
//  Centralizes all color constants for the emotion-based social app.
//

import SwiftUI

/// Centralized color palette for the "HI" social app.
///
/// All hex values are taken from the 44 design images used to design
/// the app. Use these semantic tokens instead of hard-coded values
/// throughout the codebase.
public enum AppColors {

    // MARK: - Brand / Primary

    /// Primary cyan blue — used for the main brand color, large
    /// headlines, the logo word-mark, and primary CTAs.
    public static let primary = Color(red: 0x6F / 255.0,
                                      green: 0xE5 / 255.0,
                                      blue: 0xF0 / 255.0)

    /// Light cyan — used as a secondary accent, often as a soft fill
    /// behind icons or to complement the primary.
    public static let secondary = Color(red: 0xA0 / 255.0,
                                        green: 0xE8 / 255.0,
                                        blue: 0xF0 / 255.0)

    // MARK: - Emotion Accents

    /// Pink — used for the "heart" / love emotion chip and related UI.
    public static let pink = Color(red: 0xFF / 255.0,
                                  green: 0x3D / 255.0,
                                  blue: 0x9A / 255.0)

    /// Yellow — used for the "happy" / sunny emotion chip.
    public static let yellow = Color(red: 0xFF / 255.0,
                                     green: 0xD9 / 255.0,
                                     blue: 0x3D / 255.0)

    /// Purple — used for the "calm" / dreamy emotion chip.
    public static let purple = Color(red: 0xA0 / 255.0,
                                     green: 0xA8 / 255.0,
                                     blue: 0xFF / 255.0)

    /// Red coral — reserved for destructive actions such as the
    /// "Block" button.
    public static let redCoral = Color(red: 0xFF / 255.0,
                                       green: 0x6B / 255.0,
                                       blue: 0x6B / 255.0)

    // MARK: - Neutrals

    /// Pure black — used for primary text and filled action buttons.
    public static let black = Color.black

    /// Pure white — used for card surfaces and inverted text.
    public static let white = Color.white

    /// App-wide light background — the soft blueish off-white that
    /// sits behind all screens.
    public static let lightBackground = Color(red: 0xF4 / 255.0,
                                              green: 0xF8 / 255.0,
                                              blue: 0xFB / 255.0)

    /// Medium gray used for secondary body text and placeholders.
    public static let grayText = Color(red: 0x6B / 255.0,
                                       green: 0x73 / 255.0,
                                       blue: 0x80 / 255.0)

    /// Subtle divider / border gray.
    public static let divider = Color(red: 0xE3 / 255.0,
                                      green: 0xE8 / 255.0,
                                      blue: 0xEE / 255.0)
}

//
//  AppFonts.swift
//  HI
//
//  Centralized font tokens for the "HI" social app.
//  All type styles are rounded and use heavy weights, as required
//  by the design system extracted from the 44 design images.
//

import SwiftUI

/// Semantic font tokens used throughout the app.
///
/// Prefer these tokens (e.g. `.font(AppFonts.brandTitle)`) over
/// raw `Font.system(...)` calls so the typography can be tuned in
/// one place.
public enum AppFonts {

    // MARK: - Brand type scale

    /// 40pt black weight — used for the brand word-mark "HI" on the
    /// splash screen and the largest headers.
    public static let brandTitle: Font = .system(size: 40,
                                                 weight: .black,
                                                 design: .rounded)

    /// 28pt black weight — used for big section titles such as
    /// "How are you feeling today?".
    public static let brandSectionTitle: Font = .system(size: 28,
                                                       weight: .black,
                                                       design: .rounded)

    /// 20pt heavy weight — used for card titles, list headlines, and
    /// primary in-card headings.
    public static let brandHeadline: Font = .system(size: 20,
                                                    weight: .heavy,
                                                    design: .rounded)

    /// 16pt semibold — used for body copy, descriptions and the
    /// main on-screen text.
    public static let brandBody: Font = .system(size: 16,
                                                weight: .semibold,
                                                design: .rounded)

    /// 13pt medium — used for captions, helper text, labels under
    /// inputs, and tab-bar labels.
    public static let brandCaption: Font = .system(size: 13,
                                                   weight: .medium,
                                                   design: .rounded)

    // MARK: - Numeric / point values

    /// Numeric values such as post counts are rendered in a bold
    /// rounded style that matches the brand.
    public static let brandNumber: Font = .system(size: 18,
                                                  weight: .heavy,
                                                  design: .rounded)

    // MARK: - Button labels

    /// Used for the label inside the primary filled black button and
    /// other prominent CTAs.
    public static let brandButton: Font = .system(size: 17,
                                                  weight: .heavy,
                                                  design: .rounded)
}

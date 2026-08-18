//
//  Font+Brand.swift
//  HI - Emotion Social App
//
//  Convenience accessors that bridge the central `AppFonts` typography
//  to the `Font.brandXxx` static API used throughout the component
//  and view layers.
//

import SwiftUI

public extension Font {

    /// 40pt black rounded — large hero titles ("HI WELCOME").
    static let brandTitle         = AppFonts.brandTitle

    /// 28pt black rounded — section titles ("MATCHING RESULTS").
    static let brandSectionTitle  = AppFonts.brandSectionTitle

    /// 20pt heavy rounded — card / list headers.
    static let brandHeadline      = AppFonts.brandHeadline

    /// 16pt semibold — primary body text.
    static let brandBody          = AppFonts.brandBody

    /// 13pt medium — captions, timestamps, placeholders.
    static let brandCaption       = AppFonts.brandCaption

    /// 18pt heavy rounded — numeric balance displays.
    static let brandNumber        = AppFonts.brandNumber

    /// 17pt heavy rounded — primary action button labels.
    static let brandButton        = AppFonts.brandButton
}

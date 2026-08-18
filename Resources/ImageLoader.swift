//
//  ImageLoader.swift
//  HI - Emotion Social App
//
//  Single entry-point for loading the bundled UI images.
//
//  Usage:
//
//      ImageLoader.image(AppImages.home)
//
//  The loader looks up the asset in the main bundle via
//  `UIImage(named:)`. If the asset is not present (for example
//  because the user has not yet added `Resources/Images/` to the
//  Asset Catalog), it falls back to a soft placeholder so the
//  app still previews without crashing.
//

import SwiftUI
import UIKit

public enum ImageLoader {

    // MARK: - Resolved image

    /// Returns a SwiftUI `Image` for the given asset name.
    ///
    /// - Parameter name: Asset name. Usually one of the constants in
    ///   `AppImages`.
    /// - Parameter fallback: System symbol used when the asset is
    ///   not bundled. Defaults to "photo".
    @MainActor
    public static func image(
        _ name: String,
        fallback: String = "photo"
    ) -> Image {
        if let uiImage = UIImage(named: name) {
            return Image(uiImage: uiImage)
        }
        if let url = Bundle.main.url(forResource: name, withExtension: "png"),
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: fallback)
    }

    /// Same as `image(_:fallback:)` but already `.resizable()`.
    public static func resizable(
        _ name: String,
        fallback: String = "photo"
    ) -> Image {
        image(name, fallback: fallback).resizable()
    }

    /// Convenience: full-bleed background image filling the entire
    /// view, ignoring safe area. Use as the bottom layer of a
    /// `ZStack`.
    public static func background(_ name: String) -> some View {
        resizable(name)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }

    /// Returns true when the asset is resolvable. Useful in
    /// `#Preview` to swap in a placeholder when the asset catalog
    /// hasn't been configured yet.
    public static func isAvailable(_ name: String) -> Bool {
        UIImage(named: name) != nil
    }
}

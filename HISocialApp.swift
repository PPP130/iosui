//
//  HISocialApp.swift
//  HI
//
//  Application entry point for the "HI" emotion-based social app.
//
//  This file is the only `@main` in the project. It creates a single
//  `AppRouter` that is shared across the entire view hierarchy via
//  `ContentView`'s `@StateObject` and the `.environmentObject(...)`
//  modifier.
//
//  Required deployment target: iOS 16+ (uses SwiftUI 4.0 features
//  such as the modern `NavigationStack` API surface and `.task`).
//

import SwiftUI

@main
struct HISocialApp: App {

    // MARK: - Shared state

    /// The single source of truth for top-level navigation. Created
    /// here at app launch and injected into `ContentView` so it is
    /// available to every screen via `@EnvironmentObject`.
    @StateObject private var router: AppRouter = AppRouter()

    // MARK: - Scene

    var body: some Scene {
        WindowGroup {
            ContentView(router: router)
                .preferredColorScheme(.light)
                .tint(AppColors.primary)
        }
    }
}

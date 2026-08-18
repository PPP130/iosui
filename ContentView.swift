//
//  ContentView.swift
//  HI - Emotion Social App
//
//  Root view for the "HI" social app.
//
//  ContentView owns the top-level route state machine and switches
//  between the four high-level screens required by the design
//  specification:
//
//      Splash  →  Onboarding  →  Login  →  MainTabView
//
//  The current route lives on `AppRouter`, an `ObservableObject` that
//  is injected as an `@StateObject` from `HISocialApp`. Child screens
//  receive the same router via `@EnvironmentObject` so they can
//  request transitions (e.g. "tap Continue to advance from
//  Onboarding to Login") without owning the state themselves.
//

import SwiftUI

// MARK: - Route

/// Every high-level destination the user can be on.
public enum AppRoute: Equatable {
    case splash
    case onboarding
    case login
    case main
}

// MARK: - Router

/// ObservableObject that owns the current `AppRoute` and exposes
/// convenience methods for transitioning between routes.
public final class AppRouter: ObservableObject {

    @Published public private(set) var route: AppRoute = .splash

    public init() {}

    public func go(_ route: AppRoute) {
        self.route = route
    }

    public func splashFinished(hasSeenOnboarding: Bool) {
        go(hasSeenOnboarding ? .login : .onboarding)
    }

    public func onboardingFinished() {
        go(.login)
    }

    public func loginSucceeded() {
        go(.main)
    }

    public func loggedOut() {
        go(.login)
    }
}

// MARK: - ContentView

public struct ContentView: View {

    @StateObject private var router: AppRouter

    @State private var hasSeenOnboarding: Bool = false

    public init(router: AppRouter = AppRouter()) {
        _router = StateObject(wrappedValue: router)
    }

    public var body: some View {
        ZStack {
            AppColors.lightBackground
                .ignoresSafeArea()

            Group {
                switch router.route {
                case .splash:
                    SplashView {
                        router.splashFinished(hasSeenOnboarding: hasSeenOnboarding)
                    }
                    .transition(.opacity)
                case .onboarding:
                    OnboardingView {
                        router.onboardingFinished()
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                case .login:
                    LoginView {
                        router.loginSucceeded()
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                case .main:
                    MainTabView(router: router)
                        .transition(.opacity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .environmentObject(router)
        .animation(.easeInOut(duration: 0.35), value: router.route)
    }
}

// MARK: - Main Tab Bar (authenticated root)

/// The 4-tab bottom bar shown after login. The Home tab is the default
/// landing screen and reuses `HomeView`. The other tabs are
/// lightweight placeholders wired to the rest of the app's screens
/// so the navigation is observable end-to-end.
public struct MainTabView: View {

    @EnvironmentObject private var router: AppRouter

    public init(router: AppRouter? = nil) {}

    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "face.smiling.fill")
                    Text("Home")
                }

            NavigationStack {
                AICharacterView()
            }
            .tabItem {
                Image(systemName: "flame.fill")
                Text("AI")
            }

            NavigationStack {
                CommunityView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }

            NavigationStack {
                MyProfileView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Me")
            }
        }
        .tint(AppColors.primary)
    }
}

// MARK: - Previews

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

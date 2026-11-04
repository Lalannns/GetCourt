//
//  GetCourtApp.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

@main
struct GetCourtApp: App {
    @State private var appStore = AppStorageStore()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appStore.currentState {
                case .splash:
                    SplashView(store: appStore)
                case .unauthenticated:
                    AuthView(store: appStore)
                case .authenticated:
                    MainTabView(store: appStore)
                }
            }
            .preferredColorScheme(appStore.isDarkMode ? .dark : .light)
        }
    }
}

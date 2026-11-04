//
//  AppStorageStore.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public enum AppState {
    case splash
    case unauthenticated
    case authenticated
}

@Observable
public final class AppStorageStore {
    public var currentState: AppState = .splash
    public var isAuthenticated: Bool = false
    public var localization = LocalizationService()
    
    // Reactive Dark Mode State saved in UserDefaults
    public var isDarkMode: Bool = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    public init() {}
    
    public func transition(to state: AppState) {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentState = state
        }
    }
    
    public func login() {
        Haptics.notification(.success)
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            isAuthenticated = true
            currentState = .authenticated
        }
    }
    
    public func logout() {
        Haptics.notification(.warning)
        withAnimation(.easeInOut(duration: 0.3)) {
            isAuthenticated = false
            currentState = .unauthenticated
        }
    }
}

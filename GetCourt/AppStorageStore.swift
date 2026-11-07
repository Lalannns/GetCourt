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
    
    // Reactive Stored Property for Favorites backed by UserDefaults
    public var favoriteCourtIds: Set<String> = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(favoriteCourtIds) {
                UserDefaults.standard.set(encoded, forKey: "favoriteCourtIds")
            }
        }
    }
    
    public init() {
        if let data = UserDefaults.standard.data(forKey: "favoriteCourtIds"),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            self.favoriteCourtIds = decoded
        }
    }
    
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

    public func toggleFavorite(for courtId: String) {
        if favoriteCourtIds.contains(courtId) {
            favoriteCourtIds.remove(courtId)
        } else {
            favoriteCourtIds.insert(courtId)
        }
    }

    public func isFavorite(courtId: String) -> Bool {
        return favoriteCourtIds.contains(courtId)
    }
}

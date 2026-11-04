//
//  MainTabView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public enum TabItem: CaseIterable, Identifiable {
    case home, courts, radar, profile
    public var id: Self { self }
    
    func title(using localization: LocalizationService) -> String {
        switch self {
        case .home: return localization.localized("home")
        case .courts: return localization.localized("courts")
        case .radar: return localization.localized("radar")
        case .profile: return localization.localized("profile")
        }
    }
    
    var iconName: String {
        switch self {
        case .home: return "tennis.racket"
        case .courts: return "sportscourt.fill"
        case .radar: return "antenna.radiowaves.left.and.right"
        case .profile: return "person.crop.circle.fill"
        }
    }
}

public struct MainTabView: View {
    @Bindable var store: AppStorageStore
    @State private var selectedTab: TabItem = .home
    
    public init(store: AppStorageStore) {
        self.store = store
        UITabBar.appearance().isHidden = true
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            currentTabView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            customTabBar
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    @ViewBuilder
    private var currentTabView: some View {
        switch selectedTab {
        case .home:
            HomeDashboardView(store: store, selectedTab: $selectedTab)
        case .courts:
            CourtCatalogView(store: store)
        case .radar:
            MatchRadarView(store: store)
        case .profile:
            ProfileHubView(store: store)
        }
    }
    
    private var customTabBar: some View {
        HStack {
            ForEach(TabItem.allCases, id: \.self) { tab in
                Spacer()
                Button(action: {
                    Haptics.selection()
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 18, weight: .semibold))
                        Text(tab.title(using: store.localization))
                            .font(.system(size: 10, weight: .bold))
                    }
                    .foregroundColor(selectedTab == tab ? AppTheme.neonAccent : AppTheme.textSecondary)
                    .padding(.vertical, 8)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 24)
        .background(
            AppTheme.graphiteCard
                .overlay(
                    Rectangle()
                        .fill(AppTheme.graphiteBorder)
                        .frame(height: 1),
                    alignment: .top
                )
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

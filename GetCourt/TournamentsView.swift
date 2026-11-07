//
//  TournamentsView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 07.11.2026.
//

import SwiftUI

public struct TournamentsView: View {
    let store: AppStorageStore
    @State private var selectedCategory: TournamentCategory = .global
    
    private var filteredItems: [TournamentItem] {
        TournamentItem.sampleItems.filter { item in
            if selectedCategory == .news { return true }
            return item.category == selectedCategory
        }
    }
    
    public var body: some View {
        let isDark = store.isDarkMode
        
        NavigationStack {
            ZStack {
                AppTheme.bg(for: isDark).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        
                        // Header Title
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("GET COURT NEWS")
                                    .font(.system(size: 10, weight: .bold))
                                    .tracking(2)
                                    .foregroundColor(AppTheme.neonAccent)
                                
                                Text(store.localization.localized("tournaments_title"))
                                    .font(.system(size: 24, weight: .black))
                                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                            }
                            Spacer()
                        }
                        
                        // Filter Pills
                        categoryFilterPicker(isDark: isDark)
                        
                        // Tournament & News List
                        VStack(spacing: 14) {
                            ForEach(filteredItems) { item in
                                tournamentCard(item: item, isDark: isDark)
                            }
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 90)
                }
            }
        }
    }
    
    // MARK: - Category Filter Bar
    @ViewBuilder
    private func categoryFilterPicker(isDark: Bool) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TournamentCategory.allCases) { cat in
                    let isSelected = selectedCategory == cat
                    Button(action: {
                        Haptics.selection()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCategory = cat
                        }
                    }) {
                        Text(store.localization.localized(cat.rawValue))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(isSelected ? Color(hex: "0A0A0C") : AppTheme.textPrimary(for: isDark))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(isSelected ? AppTheme.neonAccent : AppTheme.card(for: isDark))
                            .cornerRadius(20)
                            .overlay(Capsule().stroke(isSelected ? Color.clear : AppTheme.border(for: isDark), lineWidth: 1))
                    }
                }
            }
        }
    }
    
    // MARK: - Tournament / News Card
    @ViewBuilder
    private func tournamentCard(item: TournamentItem, isDark: Bool) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Card Header Badges & Icon
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: item.imageName)
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.neonAccent)
                    
                    Text(item.categoryBadge)
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(AppTheme.neonAccent)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(AppTheme.darkCard(for: isDark))
                .cornerRadius(6)
                
                Spacer()
                
                Text(item.surface)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            
            // Tournament Title & News Snippet
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 18, weight: .black))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                Text(item.newsSnippet)
                    .font(.system(size: 12))
                    .lineSpacing(3)
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            
            Divider().background(AppTheme.border(for: isDark))
            
            // Details Grid (Dates, Location, Prize Money)
            VStack(spacing: 6) {
                detailRow(icon: "calendar", title: item.dates, isDark: isDark)
                detailRow(icon: "mappin.and.ellipse", title: item.location, isDark: isDark)
                
                if let prize = item.prizeMoney {
                    detailRow(icon: "banknote", title: "\(store.localization.localized("prize_pool")): \(prize)", isDark: isDark)
                }
            }
        }
        .padding(16)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func detailRow(icon: String, title: String, isDark: Bool) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(AppTheme.neonAccent)
                .frame(width: 16)
            
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(AppTheme.textPrimary(for: isDark))
            
            Spacer()
        }
    }
}

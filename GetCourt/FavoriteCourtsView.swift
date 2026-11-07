//
//  FavoriteCourtsView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 06.11.2026.
//

import SwiftUI

public struct FavoriteCourtsView: View {
    let store: AppStorageStore
    @Environment(\.dismiss) private var dismiss
    
    private var favoriteCourts: [Court] {
        Court.sampleCourts.filter { store.isFavorite(courtId: "\($0.id)") }
    }
    
    public var body: some View {
        let isDark = store.isDarkMode
        
        ZStack {
            AppTheme.bg(for: isDark).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    if favoriteCourts.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "heart.slash")
                                .font(.system(size: 40))
                                .foregroundColor(AppTheme.textSecondary(for: isDark))
                            Text("Нет избранных кортов")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary(for: isDark))
                            Text("Добавляйте корты в избранное в каталоге.")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.textSecondary(for: isDark))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)
                    } else {
                        ForEach(favoriteCourts) { court in
                            CourtCardView(store: store, court: court) {}
                        }
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle("Избранные корты")
        .navigationBarTitleDisplayMode(.inline)
    }
}

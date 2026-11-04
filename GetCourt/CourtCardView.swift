//
//  CourtCardView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

// CourtCardView.swift
import SwiftUI

public struct CourtCardView: View {
    @Bindable var store: AppStorageStore
    let court: Court
    let onBook: () -> Void
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(AppTheme.graphiteDark)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: court.imageName)
                        .font(.system(size: 24))
                        .foregroundColor(AppTheme.neonAccent)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(court.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text(court.location)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(AppTheme.neonAccent)
                    Text(String(format: "%.1f", court.rating))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(AppTheme.graphiteDark)
                .cornerRadius(8)
            }
            
            Divider()
                .background(AppTheme.graphiteBorder)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(court.surface)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                    
                    Text("€\(court.pricePerHour) / hr")
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(AppTheme.neonAccent)
                }
                
                Spacer()
                
                Button(action: {
                    Haptics.play(.light)
                    onBook()
                }) {
                    Text(store.localization.localized("book_court_btn"))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(AppTheme.graphiteBlack)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(AppTheme.neonAccent)
                        .cornerRadius(10)
                }
            }
        }
        .padding(16)
        .background(AppTheme.graphiteCard)
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius, style: .continuous)
                .stroke(AppTheme.graphiteBorder, lineWidth: 1)
        )
    }
}

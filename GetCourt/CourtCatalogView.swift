//
//  CourtCatalogView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct CourtCatalogView: View {
    @Bindable var store: AppStorageStore
    @State private var selectedDateIndex: Int = 0
    @State private var selectedSurface: String = "all"
    @State private var searchText: String = ""
    @State private var includeGearRental: Bool = true
    @State private var selectedCourtForDetail: Court? = nil
    
    private let surfaceKeys = [
        ("all", "filter_all"),
        ("clay", "filter_clay"),
        ("hard", "filter_hard"),
        ("indoor", "filter_indoor")
    ]
    
    public var body: some View {
        let isDark = store.isDarkMode
        
        NavigationStack {
            ZStack(alignment: .bottom) {
                AppTheme.bg(for: isDark).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // Top Header Search Bar & Filter icon
                        searchAndFilterHeader(isDark: isDark)
                        
                        // Date Picker Strip
                        datePickerStrip(isDark: isDark)
                        
                        // Surface Filters
                        surfaceFilterScroll(isDark: isDark)
                        
                        // Court Card Match Mockup
                        ForEach(Court.sampleCourts) { court in
                            mockupCourtCard(court: court, isDark: isDark)
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 100)
                }
            }
            .sheet(item: $selectedCourtForDetail) { court in
                CourtDetailView(store: store, court: court)
            }
        }
    }
    
    // MARK: - Search & Filter Header
    @ViewBuilder
    private func searchAndFilterHeader(isDark: Bool) -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                    .font(.system(size: 14))
                
                TextField(store.localization.localized("search_court_placeholder"), text: $searchText)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
            }
            .padding(12)
            .background(AppTheme.card(for: isDark))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.border(for: isDark), lineWidth: 1))
            
            Button(action: { Haptics.selection() }) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                    .frame(width: 44, height: 44)
                    .background(AppTheme.card(for: isDark))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.border(for: isDark), lineWidth: 1))
            }
        }
    }
    
    // MARK: - Date Picker Strip (Dynamic & Localized for Next 10 Days)
    @ViewBuilder
    private func datePickerStrip(isDark: Bool) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<10, id: \.self) { index in
                    let targetDate = Calendar.current.date(byAdding: .day, value: index, to: Date()) ?? Date()
                    let dayString = formattedDay(for: targetDate, index: index)
                    let dateNum = formattedDayNumber(for: targetDate)
                    let monthString = formattedMonth(for: targetDate)
                    
                    dateCard(
                        dayName: dayString,
                        dateNum: dateNum,
                        month: monthString,
                        isSelected: selectedDateIndex == index,
                        index: index,
                        isDark: isDark
                    )
                }
            }
        }
    }

    // Helper formatters respecting store.localization.currentLanguage.code
    private func formattedDay(for date: Date, index: Int) -> String {
        if index == 0 {
            switch store.localization.currentLanguage {
            case .russian: return "СЕГОДНЯ"
            case .kazakh: return "БҮГІН"
            case .english: return "TODAY"
            }
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: store.localization.currentLanguage.code)
        formatter.dateFormat = "EEE" // e.g. Пн, Жм, Mon
        return formatter.string(from: date).uppercased()
    }

    private func formattedDayNumber(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private func formattedMonth(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: store.localization.currentLanguage.code)
        formatter.dateFormat = "MMM" // e.g. Ноя, Қаз, Nov
        return formatter.string(from: date)
    }
    
    @ViewBuilder
    private func dateCard(dayName: String, dateNum: String, month: String, isSelected: Bool, index: Int, isDark: Bool) -> some View {
        Button(action: {
            Haptics.selection()
            selectedDateIndex = index
        }) {
            VStack(spacing: 2) {
                Text(dayName)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(isSelected ? Color(hex: "0A0A0C") : AppTheme.textSecondary(for: isDark))
                Text(dateNum)
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(isSelected ? Color(hex: "0A0A0C") : AppTheme.textPrimary(for: isDark))
                Text(month)
                    .font(.system(size: 8, weight: .medium))
                    .foregroundColor(isSelected ? Color(hex: "0A0A0C").opacity(0.8) : AppTheme.textSecondary(for: isDark))
            }
            .frame(width: 64, height: 68)
            .background(isSelected ? AppTheme.neonAccent : AppTheme.card(for: isDark))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.clear : AppTheme.border(for: isDark), lineWidth: 1))
        }
    }
    
    // MARK: - Surface Filter Scroll
    @ViewBuilder
    private func surfaceFilterScroll(isDark: Bool) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(surfaceKeys, id: \.0) { key, titleKey in
                    let isSelected = selectedSurface == key
                    Button(action: {
                        Haptics.selection()
                        selectedSurface = key
                    }) {
                        Text(store.localization.localized(titleKey))
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(isSelected ? Color(hex: "0A0A0C") : AppTheme.textPrimary(for: isDark))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(isSelected ? AppTheme.neonAccent : AppTheme.card(for: isDark))
                            .cornerRadius(20)
                            .overlay(Capsule().stroke(isSelected ? Color.clear : AppTheme.border(for: isDark), lineWidth: 1))
                    }
                }
            }
        }
    }
    
    // MARK: - Mockup Court Card
    @ViewBuilder
    private func mockupCourtCard(court: Court, isDark: Bool) -> some View {
        let isFav = store.isFavorite(courtId: court.id)
        
        VStack(alignment: .leading, spacing: 14) {
            
            // Image Banner with Badges & Favorite Heart Button
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(AppTheme.darkCard(for: isDark))
                    .frame(height: 150)
                    .overlay(
                        Image(systemName: court.imageName)
                            .font(.system(size: 48))
                            .foregroundColor(AppTheme.neonAccent.opacity(0.7))
                    )
                
                // Top Badges
                HStack {
                    Text("🟢 INDOOR HARD")
                        .font(.system(size: 9, weight: .black))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.graphiteBlack.opacity(0.8))
                        .foregroundColor(AppTheme.neonAccent)
                        .cornerRadius(6)
                    
                    Text("Court #3")
                        .font(.system(size: 9, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.graphiteBlack.opacity(0.8))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                        .cornerRadius(6)
                    
                    Spacer()
                    
                    // Working Favorite Button
                    Button(action: {
                        Haptics.play(.medium)
                        store.toggleFavorite(for: court.id)
                    }) {
                        Image(systemName: isFav ? "heart.fill" : "heart")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(isFav ? Color(hex: "FF5C5C") : Color.white)
                            .padding(10)
                            .background(AppTheme.graphiteBlack.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                .padding(12)
                
                // Academy Title Overlay
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 2) {
                        Text("ATP APPROVED ACADEMY")
                            .font(.system(size: 8, weight: .black))
                            .foregroundColor(AppTheme.neonAccent)
                        Text(court.name)
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.white)
                        Text(court.location)
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LinearGradient(colors: [.clear, AppTheme.graphiteBlack.opacity(0.9)], startPoint: .top, endPoint: .bottom))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
            
            // Ratings & Location
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(AppTheme.neonAccent)
                        .font(.system(size: 11))
                    Text(String(format: "%.1f", court.rating))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                    Text("• 128 reviews")
                        .font(.system(size: 10))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(AppTheme.neonAccent)
                        .font(.system(size: 11))
                    Text(court.location)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                }
            }
            
            // Amenities Pills
            HStack(spacing: 6) {
                amenityPill(title: store.localization.localized("amenity_shower"), icon: "shower.fill", isDark: isDark)
                amenityPill(title: store.localization.localized("amenity_parking"), icon: "p.square.fill", isDark: isDark)
                amenityPill(title: store.localization.localized("amenity_gear"), icon: "tennis.racket", isDark: isDark)
                amenityPill(title: store.localization.localized("amenity_led"), icon: "lightbulb.fill", isDark: isDark)
            }
            
            Divider().background(AppTheme.border(for: isDark))
            
            // Slots Picker Grid Header
            HStack {
                Text(store.localization.localized("select_time_slot"))
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Spacer()
                Text("60 min / slot")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.neonAccent)
            }
            
            // Time Slots Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                slotBox(time: "08:00", price: "5,000₸", status: .available, isDark: isDark)
                slotBox(time: "09:00", price: "Занято", status: .booked, isDark: isDark)
                slotBox(time: "10:00", price: "6,000₸", status: .available, isDark: isDark)
                slotBox(time: "11:00", price: "6,000₸", status: .selected, isDark: isDark)
                slotBox(time: "12:00", price: "Занято", status: .booked, isDark: isDark)
                slotBox(time: "18:00", price: "8,000₸", status: .availableWithGreenDot, isDark: isDark)
            }
            
            // Gear Rental Toggle
            HStack(spacing: 10) {
                Image(systemName: "tennis.racket")
                    .foregroundColor(AppTheme.neonAccent)
                    .font(.system(size: 16))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(store.localization.localized("gear_rental_title"))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                    Text(store.localization.localized("gear_rental_desc"))
                        .font(.system(size: 10))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                }
                
                Spacer()
                
                Toggle("", isOn: $includeGearRental)
                    .tint(AppTheme.neonAccent)
                    .labelsHidden()
            }
            .padding(12)
            .background(AppTheme.darkCard(for: isDark))
            .cornerRadius(10)
            
            Divider().background(AppTheme.border(for: isDark))
            
            // Summary Calculation Footer
            VStack(spacing: 8) {
                HStack {
                    Text(store.localization.localized("details_title"))
                        .font(.system(size: 13, weight: .black))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                    Spacer()
                    Text("Court #3 Hard")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.neonAccent)
                }
                
                summaryRow(title: store.localization.localized("court_rental_line"), price: "6,000₸", isDark: isDark)
                summaryRow(title: store.localization.localized("gear_rental_line"), price: includeGearRental ? "1,500₸" : "0₸", isDark: isDark)
                summaryRow(title: store.localization.localized("service_fee"), price: "0₸ (\(store.localization.localized("free")))", isDark: isDark)
                
                HStack {
                    Text(store.localization.localized("total_label"))
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                    Spacer()
                    Text(includeGearRental ? "7,500₸" : "6,000₸")
                        .font(.system(size: 22, weight: .black))
                        .foregroundColor(AppTheme.neonAccent)
                }
                .padding(.top, 4)
            }
            
            // Booking Button CTA
            Button(action: {
                Haptics.play(.heavy)
                selectedCourtForDetail = court
            }) {
                Text("\(store.localization.localized("book_cta")) • \(includeGearRental ? "7,500₸" : "6,000₸")")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "0A0A0C"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(AppTheme.neonAccent)
                    .cornerRadius(14)
            }
            .padding(.top, 4)
            
        }
        .padding(16)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    // MARK: - Subcomponents
    enum SlotStatus { case available, booked, selected, availableWithGreenDot }
    
    private func slotBox(time: String, price: String, status: SlotStatus, isDark: Bool) -> some View {
        let isSelected = status == .selected
        let isBooked = status == .booked
        
        return VStack(spacing: 2) {
            Text(time)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(isSelected ? Color(hex: "0A0A0C") : (isBooked ? AppTheme.textSecondary(for: isDark) : AppTheme.textPrimary(for: isDark)))
            Text(price)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(isSelected ? Color(hex: "0A0A0C").opacity(0.8) : AppTheme.textSecondary(for: isDark))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(isSelected ? AppTheme.neonAccent : AppTheme.darkCard(for: isDark))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.clear : AppTheme.border(for: isDark), lineWidth: 1)
        )
        .overlay(alignment: .topTrailing) {
            if status == .availableWithGreenDot {
                Circle()
                    .fill(AppTheme.neonAccent)
                    .frame(width: 6, height: 6)
                    .padding(6)
            }
        }
    }
    
    private func amenityPill(title: String, icon: String, isDark: Bool) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.neonAccent)
                .font(.system(size: 11))
            Text(title)
                .font(.system(size: 9, weight: .semibold))
                .foregroundColor(AppTheme.textPrimary(for: isDark))
                .lineLimit(2)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(AppTheme.darkCard(for: isDark))
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func summaryRow(title: String, price: String, isDark: Bool) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            Spacer()
            Text(price)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(AppTheme.textPrimary(for: isDark))
        }
    }
}

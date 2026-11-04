//
//  ProfileHubView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct ProfileHubView: View {
    @Bindable var store: AppStorageStore
    @State private var hapticsEnabled: Bool = true
    @State private var radarActive: Bool = true
    
    public var body: some View {
        let isDark = store.isDarkMode
        
        NavigationStack {
            ZStack {
                AppTheme.bg(for: isDark).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        topHeaderSection(isDark: isDark)
                        profileIdentityCard(isDark: isDark)
                        statsOverviewGrid(isDark: isDark)
                        languageSelectorSection(isDark: isDark)
                        accountManagementSection(isDark: isDark)
                        appPreferencesSection(isDark: isDark)
                        logOutAndFooterSection(isDark: isDark)
                    }
                    .padding(20)
                    .padding(.bottom, 90)
                }
            }
        }
    }
    
    @ViewBuilder
    private func topHeaderSection(isDark: Bool) -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("GET COURT")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                Text(store.localization.localized("profile_title"))
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(AppTheme.card(for: isDark))
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(AppTheme.border(for: isDark), lineWidth: 1))
                Image(systemName: "person.fill")
                    .foregroundColor(AppTheme.neonAccent)
            }
        }
    }
    
    @ViewBuilder
    private func profileIdentityCard(isDark: Bool) -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .fill(AppTheme.darkCard(for: isDark))
                        .frame(width: 72, height: 72)
                        .overlay(
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 64))
                                .foregroundColor(AppTheme.textSecondary(for: isDark))
                        )
                    
                    Circle()
                        .fill(AppTheme.neonAccent)
                        .frame(width: 22, height: 22)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 10, weight: .black))
                                .foregroundColor(Color(hex: "0A0A0C"))
                        )
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text("Allan Djokovic")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(AppTheme.textPrimary(for: isDark))
                        
                        Text("PRO")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(AppTheme.neonAccent)
                            .foregroundColor(Color(hex: "0A0A0C"))
                            .cornerRadius(4)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 10))
                            .foregroundColor(AppTheme.neonAccent)
                        Text("Almaty, Kazakhstan")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.textSecondary(for: isDark))
                    }
                }
                
                Spacer()
                
                Button(action: { Haptics.selection() }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                        .padding(10)
                        .background(AppTheme.darkCard(for: isDark))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(AppTheme.border(for: isDark), lineWidth: 1))
                }
            }
            
            HStack(spacing: 8) {
                Circle()
                    .fill(radarActive ? AppTheme.neonAccent : AppTheme.textSecondary(for: isDark))
                    .frame(width: 8, height: 8)
                
                Text(store.localization.localized("sparring_active"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                Spacer()
                
                Text(store.localization.localized("seeking_partner"))
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(AppTheme.neonAccent)
            }
            .padding(12)
            .background(AppTheme.darkCard(for: isDark))
            .cornerRadius(10)
        }
        .padding(16)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    @ViewBuilder
    private func statsOverviewGrid(isDark: Bool) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
            statBox(title: store.localization.localized("rating"), value: "4.5", sub: "NTRP", isDark: isDark)
            statBox(title: store.localization.localized("matches"), value: "38", sub: store.localization.localized("matches"), isDark: isDark)
            statBox(title: store.localization.localized("wins"), value: "74%", sub: store.localization.localized("wins"), isDark: isDark)
            statBox(title: store.localization.localized("court_time"), value: "142ч", sub: store.localization.localized("court_time"), isDark: isDark)
        }
    }
    
    @ViewBuilder
    private func languageSelectorSection(isDark: Bool) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(store.localization.localized("language_section"))
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                Spacer()
                Text(store.localization.localized("select_language"))
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.neonAccent)
            }
            
            HStack(spacing: 8) {
                ForEach(AppLanguage.allCases) { lang in
                    let isSelected = store.localization.currentLanguage == lang
                    Button(action: {
                        Haptics.selection()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            store.localization.currentLanguage = lang
                        }
                    }) {
                        VStack(spacing: 2) {
                            Text(lang.rawValue)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(isSelected ? Color(hex: "0A0A0C") : AppTheme.textPrimary(for: isDark))
                            Text(langSubtitle(for: lang))
                                .font(.system(size: 9, weight: .medium))
                                .foregroundColor(isSelected ? Color(hex: "0A0A0C").opacity(0.8) : AppTheme.textSecondary(for: isDark))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(isSelected ? AppTheme.neonAccent : AppTheme.card(for: isDark))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.clear : AppTheme.border(for: isDark), lineWidth: 1))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func accountManagementSection(isDark: Bool) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(store.localization.localized("account_management"))
                .font(.system(size: 10, weight: .bold))
                .tracking(1.5)
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            
            VStack(spacing: 8) {
                managementRow(icon: "tennis.racket", title: store.localization.localized("personal_data"), subtitle: store.localization.localized("personal_data_sub"), badge: nil, isDark: isDark)
                managementRow(icon: "ticket.fill", title: store.localization.localized("my_bookings"), subtitle: store.localization.localized("my_bookings_sub"), badge: "2", isDark: isDark)
                managementRow(icon: "chart.line.uptrend.xyaxis", title: store.localization.localized("match_history"), subtitle: store.localization.localized("match_history_sub"), badge: nil, isDark: isDark)
                managementRow(icon: "heart.fill", title: store.localization.localized("favorite_courts"), subtitle: store.localization.localized("favorite_courts_sub"), badge: nil, isDark: isDark)
                managementRow(icon: "antenna.radiowaves.left.and.right", title: store.localization.localized("radar_challenges"), subtitle: store.localization.localized("radar_challenges_sub"), badge: "•", isDark: isDark)
                managementRow(icon: "headphones", title: store.localization.localized("support_247"), subtitle: store.localization.localized("support_sub"), badge: nil, isDark: isDark)
            }
        }
    }
    
    @ViewBuilder
    private func appPreferencesSection(isDark: Bool) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(store.localization.localized("app_preferences"))
                .font(.system(size: 10, weight: .bold))
                .tracking(1.5)
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            
            VStack(spacing: 8) {
                toggleRow(icon: "iphone.gen3", title: store.localization.localized("ios_haptics"), subtitle: store.localization.localized("ios_haptics_sub"), isOn: $hapticsEnabled, isDark: isDark)
                
                toggleRow(icon: "moon.fill", title: store.localization.localized("dark_mode"), subtitle: store.localization.localized("dark_mode_sub"), isOn: Binding(
                    get: { store.isDarkMode },
                    set: { newValue in
                        Haptics.selection()
                        withAnimation(.easeInOut(duration: 0.25)) {
                            store.isDarkMode = newValue
                        }
                    }
                ), isDark: isDark)
            }
        }
    }
    
    @ViewBuilder
    private func logOutAndFooterSection(isDark: Bool) -> some View {
        VStack(spacing: 16) {
            Button(action: {
                Haptics.notification(.warning)
                store.logout()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 16, weight: .bold))
                    Text(store.localization.localized("logout"))
                        .font(.system(size: 16, weight: .bold))
                }
                .foregroundColor(Color(hex: "FF5C5C"))
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(AppTheme.card(for: isDark))
                .cornerRadius(AppTheme.buttonCornerRadius)
                .overlay(RoundedRectangle(cornerRadius: AppTheme.buttonCornerRadius).stroke(Color(hex: "FF5C5C").opacity(0.3), lineWidth: 1))
            }
            
            VStack(spacing: 4) {
                Text(store.localization.localized("version_info"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                Text("ID: GC-KZ-770182")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(AppTheme.textSecondary(for: isDark).opacity(0.7))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 10)
    }
    
    private func langSubtitle(for lang: AppLanguage) -> String {
        switch lang {
        case .russian: return "RU (Негізгі)"
        case .kazakh: return "KK (Белсенді)"
        case .english: return "EN (Global)"
        }
    }
    
    private func statBox(title: String, value: String, sub: String, isDark: Bool) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            Text(value)
                .font(.system(size: 20, weight: .black))
                .foregroundColor(AppTheme.neonAccent)
            Text(sub)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(AppTheme.textSecondary(for: isDark))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func managementRow(icon: String, title: String, subtitle: String, badge: String?, isDark: Bool) -> some View {
        Button(action: { Haptics.play(.light) }) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkCard(for: isDark))
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .foregroundColor(AppTheme.neonAccent)
                        .font(.system(size: 16))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                    Text(subtitle)
                        .font(.system(size: 11))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                }
                
                Spacer()
                
                if let badge {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(badge == "•" ? AppTheme.neonAccent : Color(hex: "0A0A0C"))
                        .padding(.horizontal, badge == "•" ? 6 : 8)
                        .padding(.vertical, badge == "•" ? 2 : 4)
                        .background(badge == "•" ? AppTheme.neonAccent.opacity(0.2) : AppTheme.neonAccent)
                        .clipShape(Circle())
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            .padding(12)
            .background(AppTheme.card(for: isDark))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.border(for: isDark), lineWidth: 1))
        }
    }
    
    private func toggleRow(icon: String, title: String, subtitle: String, isOn: Binding<Bool>, isDark: Bool) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppTheme.darkCard(for: isDark))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(AppTheme.neonAccent)
                    .font(.system(size: 16))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            
            Spacer()
            
            Toggle("", isOn: isOn)
                .tint(AppTheme.neonAccent)
                .labelsHidden()
        }
        .padding(12)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
}

//
//  HomeDashboardView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct HomeDashboardView: View {
    @Bindable var store: AppStorageStore
    @Binding var selectedTab: TabItem
    @State private var selectedCourtForBooking: Court? = nil
    @State private var showQRModal: Bool = false
    @State private var navigateToTournaments: Bool = false
    
    public var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.graphiteBlack.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        topHeaderSection
                        userStatusCard
                        activeGameCard
                        quickActionGrid
                        tournamentBanner
                        nearbyCourtsSection
                        opponentRadarSection
                    }
                    .padding(20)
                    .padding(.bottom, 90)
                }
            }
            .navigationDestination(isPresented: $navigateToTournaments) {
                TournamentsView(store: store)
            }
            .sheet(item: $selectedCourtForBooking) { court in
                CourtDetailView(store: store, court: court)
            }
            .sheet(isPresented: $showQRModal) {
                QrPassModalView(store: store)
            }
        }
    }
    
    @ViewBuilder
    private var topHeaderSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("GET COURT")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundColor(AppTheme.textSecondary)
                Text(store.localization.localized("home_court"))
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(AppTheme.textPrimary)
            }
            
            Spacer()
            
            Button(action: { selectedTab = .profile }) {
                ZStack {
                    Circle()
                        .fill(AppTheme.graphiteCard)
                        .frame(width: 40, height: 40)
                        .overlay(Circle().stroke(AppTheme.graphiteBorder, lineWidth: 1))
                    Image(systemName: "person.fill")
                        .foregroundColor(AppTheme.neonAccent)
                }
            }
        }
    }
    
    @ViewBuilder
    private var userStatusCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(AppTheme.neonAccent.opacity(0.2))
                    .frame(width: 48, height: 48)
                Image(systemName: "figure.tennis")
                    .foregroundColor(AppTheme.neonAccent)
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(store.localization.localized("hello_user"))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                
                HStack(spacing: 8) {
                    Text("NTRP 4.5")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(AppTheme.graphiteDark)
                        .foregroundColor(AppTheme.neonAccent)
                        .cornerRadius(4)
                    
                    Text(store.localization.localized("club_pro"))
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(AppTheme.neonAccent.opacity(0.2))
                        .foregroundColor(AppTheme.neonAccent)
                        .cornerRadius(4)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text(store.localization.localized("online_count"))
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(AppTheme.textSecondary)
            }
            .padding(8)
            .background(AppTheme.graphiteDark)
            .cornerRadius(8)
        }
        .padding(14)
        .background(AppTheme.graphiteCard)
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
    }
    
    @ViewBuilder
    private var activeGameCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Circle().fill(AppTheme.neonAccent).frame(width: 6, height: 6)
                Text(store.localization.localized("active_game"))
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(AppTheme.neonAccent)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                    Text(store.localization.localized("time_left"))
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundColor(AppTheme.textSecondary)
            }
            
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppTheme.graphiteDark)
                    .frame(width: 64, height: 64)
                    .overlay(
                        Image(systemName: "tennis.racket")
                            .foregroundColor(AppTheme.neonAccent)
                            .font(.system(size: 28))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Almaty Tennis Club")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 10))
                            .foregroundColor(AppTheme.neonAccent)
                        Text("Мкр. Самал-2, 11")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    
                    HStack(spacing: 8) {
                        Text("Hard Acrylic")
                            .font(.system(size: 10, weight: .semibold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(AppTheme.graphiteDark)
                            .foregroundColor(AppTheme.textSecondary)
                            .cornerRadius(4)
                        
                        Text("18:00 – 19:30")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(AppTheme.neonAccent)
                    }
                }
                
                Spacer()
            }
            
            Button(action: { showQRModal = true }) {
                HStack {
                    Image(systemName: "qrcode")
                        .font(.system(size: 16, weight: .bold))
                    Text(store.localization.localized("qr_pass"))
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundColor(AppTheme.graphiteBlack)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(AppTheme.neonAccent)
                .cornerRadius(12)
            }
        }
        .padding(16)
        .background(AppTheme.graphiteCard)
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
    }
    
    @ViewBuilder
    private var quickActionGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            quickActionButton(title: store.localization.localized("book_court_btn"), subtitle: store.localization.localized("book_subtitle"), icon: "sportscourt.fill") {
                selectedTab = .courts
            }
            quickActionButton(title: store.localization.localized("find_opponent"), subtitle: store.localization.localized("radar_subtitle"), icon: "person.2.fill") {
                selectedTab = .radar
            }
            quickActionButton(title: store.localization.localized("tournaments"), subtitle: store.localization.localized("tournaments_sub"), icon: "trophy.fill") {
                Haptics.selection()
                navigateToTournaments = true
            }
            quickActionButton(title: store.localization.localized("coaches"), subtitle: store.localization.localized("coaches_sub"), icon: "figure.walk.motion") {
                Haptics.selection()
            }
        }
    }
    
    @ViewBuilder
    private var tournamentBanner: some View {
        Button(action: {
            Haptics.selection()
            navigateToTournaments = true
        }) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius)
                    .fill(AppTheme.graphiteCard)
                    .frame(height: 140)
                    .overlay(
                        LinearGradient(colors: [.clear, AppTheme.graphiteBlack.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                            .cornerRadius(AppTheme.standardCornerRadius)
                    )
                    .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(store.localization.localized("registration"))
                        .font(.system(size: 9, weight: .black))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(AppTheme.neonAccent)
                        .foregroundColor(AppTheme.graphiteBlack)
                        .cornerRadius(4)
                    
                    Text(store.localization.localized("tournament_name"))
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text(store.localization.localized("tournament_desc"))
                        .font(.system(size: 11))
                        .foregroundColor(AppTheme.textSecondary)
                }
                .padding(16)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("1,500,000₸")
                            .font(.system(size: 13, weight: .black))
                            .foregroundColor(AppTheme.neonAccent)
                            .padding(10)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var nearbyCourtsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(store.localization.localized("nearby_courts"))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Spacer()
                
                Button(action: { selectedTab = .courts }) {
                    Text(store.localization.localized("more"))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppTheme.neonAccent)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(Court.sampleCourts) { court in
                        Button(action: { selectedCourtForBooking = court }) {
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(AppTheme.graphiteDark)
                                        .frame(width: 260, height: 130)
                                        .overlay(
                                            Image(systemName: court.imageName)
                                                .font(.system(size: 40))
                                                .foregroundColor(AppTheme.neonAccent.opacity(0.7))
                                        )
                                    
                                    Text(court.surface)
                                        .font(.system(size: 10, weight: .bold))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(AppTheme.graphiteBlack.opacity(0.8))
                                        .foregroundColor(AppTheme.neonAccent)
                                        .cornerRadius(6)
                                        .padding(10)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(court.name)
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(AppTheme.textPrimary)
                                        Spacer()
                                        HStack(spacing: 2) {
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 9))
                                                .foregroundColor(AppTheme.neonAccent)
                                            Text(String(format: "%.1f", court.rating))
                                                .font(.system(size: 11, weight: .bold))
                                                .foregroundColor(AppTheme.textPrimary)
                                        }
                                    }
                                    
                                    Text(court.location)
                                        .font(.system(size: 11))
                                        .foregroundColor(AppTheme.textSecondary)
                                    
                                    HStack {
                                        Text("6,500₸ / сағ")
                                            .font(.system(size: 14, weight: .black))
                                            .foregroundColor(AppTheme.neonAccent)
                                        Spacer()
                                        Text("Бронь")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(AppTheme.graphiteBlack)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(AppTheme.neonAccent)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal, 4)
                            }
                            .frame(width: 260)
                            .padding(12)
                            .background(AppTheme.graphiteCard)
                            .cornerRadius(AppTheme.standardCornerRadius)
                            .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var opponentRadarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(store.localization.localized("opponent_radar"))
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                    Text(store.localization.localized("opponent_radar_desc"))
                        .font(.system(size: 11))
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                Spacer()
                
                Button(action: { selectedTab = .radar }) {
                    Text(store.localization.localized("more"))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppTheme.neonAccent)
                }
            }
            
            VStack(spacing: 12) {
                ForEach(Player.samplePlayers.prefix(2)) { player in
                    HStack(spacing: 12) {
                        Image(systemName: player.avatarIcon)
                            .font(.system(size: 36))
                            .foregroundColor(AppTheme.textSecondary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Text(player.name)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Text(player.ntrpLevel.prefix(3))
                                    .font(.system(size: 10, weight: .bold))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(AppTheme.graphiteDark)
                                    .foregroundColor(AppTheme.neonAccent)
                                    .cornerRadius(4)
                            }
                            
                            Text("\(player.preferredSurface) • Сегодня 20:00")
                                .font(.system(size: 11))
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        
                        Spacer()
                        
                        Button(action: { Haptics.play(.medium) }) {
                            HStack(spacing: 4) {
                                Image(systemName: "figure.tennis")
                                Text(store.localization.localized("play"))
                            }
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppTheme.graphiteBlack)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(AppTheme.neonAccent)
                            .cornerRadius(8)
                        }
                    }
                    .padding(12)
                    .background(AppTheme.graphiteCard)
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.graphiteBorder, lineWidth: 1))
                }
            }
        }
    }
    
    private func quickActionButton(title: String, subtitle: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            Haptics.selection()
            action()
        }) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(AppTheme.graphiteDark)
                            .frame(width: 36, height: 36)
                        Image(systemName: icon)
                            .foregroundColor(AppTheme.neonAccent)
                            .font(.system(size: 16))
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                    Text(subtitle)
                        .font(.system(size: 10))
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            .padding(14)
            .background(AppTheme.graphiteCard)
            .cornerRadius(AppTheme.standardCornerRadius)
            .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
        }
    }
}

// MARK: - QR Pass Sheet Component (Outside HomeDashboardView)
struct QrPassModalView: View {
    @Bindable var store: AppStorageStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Capsule()
                .fill(AppTheme.graphiteBorder)
                .frame(width: 36, height: 4)
                .padding(.top, 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("QR PASS")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(1.5)
                        .foregroundColor(AppTheme.neonAccent)
                    Text("Almaty Tennis Club")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(AppTheme.textPrimary)
                }
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            .padding(.horizontal, 4)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.graphiteDark)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.graphiteBorder, lineWidth: 1)
                    )
                
                Image("club_qr_pass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(8)
                    .padding(24)
            }
            .frame(height: 250)
            
            VStack(spacing: 6) {
                Text("Court #3 • Hard Acrylic")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                Text("Present this code at the turnstile scanner.")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            Button(action: {
                Haptics.play(.medium)
                dismiss()
            }) {
                Text("Close Pass")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppTheme.graphiteBlack)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(AppTheme.neonAccent)
                    .cornerRadius(12)
            }
            .padding(.top, 8)
        }
        .padding(20)
        .background(AppTheme.graphiteCard)
        .presentationDetents([.fraction(0.6)])
        .presentationDragIndicator(.hidden)
    }
}

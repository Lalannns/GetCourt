//
//  MatchRadarView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct MatchRadarView: View {
    @Bindable var store: AppStorageStore
    @State private var isScanning: Bool = true
    @State private var discoveredPlayers: [Player] = []
    @State private var pulseScale: CGFloat = 1.0
    @State private var pulseOpacity: Double = 0.6
    
    public var body: some View {
        ZStack {
            AppTheme.graphiteBlack.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(store.localization.localized("player_matchmaker"))
                            .font(.system(size: 10, weight: .bold))
                            .tracking(2)
                            .foregroundColor(AppTheme.neonAccent)
                        Text(store.localization.localized("match_radar_title"))
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    Spacer()
                    
                    Button(action: { startScanning() }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(AppTheme.textSecondary)
                            .padding(12)
                            .background(AppTheme.graphiteCard)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.graphiteBorder, lineWidth: 1))
                    }
                }
                .padding(20)
                
                if isScanning {
                    radarScanningView
                } else {
                    playersListView
                }
            }
        }
        .onAppear {
            startScanning()
        }
    }
    
    private var radarScanningView: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(AppTheme.neonAccent.opacity(0.2), lineWidth: 1)
                    .frame(width: 240, height: 240)
                
                Circle()
                    .stroke(AppTheme.neonAccent.opacity(0.4), lineWidth: 1)
                    .frame(width: 160, height: 160)
                
                Circle()
                    .fill(AppTheme.neonAccent.opacity(0.15))
                    .frame(width: 100, height: 100)
                    .scaleEffect(pulseScale)
                    .opacity(pulseOpacity)
                
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(AppTheme.neonAccent)
            }
            
            VStack(spacing: 8) {
                Text(store.localization.localized("scanning_courts"))
                    .font(.system(size: 14, weight: .black))
                    .tracking(2)
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(store.localization.localized("finding_players"))
                    .font(.system(size: 12))
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            Spacer()
        }
    }
    
    private var playersListView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(store.localization.localized("nearby_opponents")) (\(discoveredPlayers.count))")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(AppTheme.textSecondary)
                
                ForEach(discoveredPlayers) { player in
                    HStack(spacing: 16) {
                        Image(systemName: player.avatarIcon)
                            .font(.system(size: 44))
                            .foregroundColor(AppTheme.textSecondary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(player.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text("NTRP \(player.ntrpLevel) • \(player.distance)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(AppTheme.textSecondary)
                            
                            HStack(spacing: 8) {
                                Text("\(player.matchesPlayed) Matches")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(AppTheme.neonAccent)
                                
                                Text("\(player.winRate)% Win Rate")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            Haptics.play(.medium)
                        }) {
                            Text(store.localization.localized("challenge"))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(AppTheme.graphiteBlack)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(AppTheme.neonAccent)
                                .cornerRadius(8)
                        }
                    }
                    .padding(16)
                    .background(AppTheme.graphiteCard)
                    .cornerRadius(AppTheme.standardCornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius)
                            .stroke(AppTheme.graphiteBorder, lineWidth: 1)
                    )
                }
            }
            .padding(20)
            .padding(.bottom, 80)
        }
    }
    
    private func startScanning() {
        isScanning = true
        withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            pulseScale = 1.4
            pulseOpacity = 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.4)) {
                discoveredPlayers = Player.samplePlayers
                isScanning = false
            }
        }
    }
}

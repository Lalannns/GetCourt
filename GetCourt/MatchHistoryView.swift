//
//  MatchHistoryView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 05.11.2026.
//

import SwiftUI

public struct MatchHistoryView: View {
    @Bindable var store: AppStorageStore
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFilter: MatchFilter = .all
    @State private var showRecordScoreSheet: Bool = false
    
    enum MatchFilter: String, CaseIterable, Identifiable {
        case all = "Все матчи (38)"
        case wins = "Жеңістер / Победы (28)"
        case losses = "Поражения (10)"
        
        var id: String { rawValue }
    }
    
    public var body: some View {
        let isDark = store.isDarkMode
        
        ZStack(alignment: .bottom) {
            AppTheme.bg(for: isDark).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    topHeaderSection(isDark: isDark)
                    analyticsOverviewCard(isDark: isDark)
                    filterSegmentPicker(isDark: isDark)
                    matchCardsList(isDark: isDark)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 100)
            }
            
            // Bottom Sticky CTA
            recordMatchButton
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Header Section
    @ViewBuilder
    private func topHeaderSection(isDark: Bool) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                        .padding(10)
                        .background(AppTheme.card(for: isDark))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(AppTheme.border(for: isDark), lineWidth: 1))
                }
                
                Spacer()
                
                HStack(spacing: 6) {
                    Text("NTRP 4.5 • СЕЗОН 2025")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.neonAccent)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(AppTheme.darkCard(for: isDark))
                        .cornerRadius(20)
                        .overlay(Capsule().stroke(AppTheme.neonAccent.opacity(0.4), lineWidth: 1))
                }
                
                Spacer()
                
                Button(action: { Haptics.selection() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 12, weight: .bold))
                        Text("Экспорт / PDF")
                            .font(.system(size: 11, weight: .bold))
                    }
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppTheme.card(for: isDark))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(AppTheme.border(for: isDark), lineWidth: 1))
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("История матчей")
                    .font(.system(size: 26, weight: .black))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                Text("Ойындар тарихы  •  Match Analytics & History")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
        }
    }
    
    // MARK: - Analytics Analytics Overview Card
    @ViewBuilder
    private func analyticsOverviewCard(isDark: Bool) -> some View {
        VStack(spacing: 16) {
            // Upper Row: Winrate + Ratio + Sparkline
            HStack(spacing: 16) {
                // Circular Winrate Progress
                ZStack {
                    Circle()
                        .stroke(AppTheme.darkCard(for: isDark), lineWidth: 8)
                        .frame(width: 72, height: 72)
                    
                    Circle()
                        .trim(from: 0, to: 0.74)
                        .stroke(AppTheme.neonAccent, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 72, height: 72)
                        .rotationEffect(.degrees(-90))
                    
                    VStack(spacing: 0) {
                        Text("74%")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(AppTheme.textPrimary(for: isDark))
                        Text("WIN RATE")
                            .font(.system(size: 7, weight: .bold))
                            .foregroundColor(AppTheme.textSecondary(for: isDark))
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("28W")
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(AppTheme.textPrimary(for: isDark))
                        Text("10L")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(AppTheme.textSecondary(for: isDark))
                        Text("/ 38 игр")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(AppTheme.textSecondary(for: isDark))
                    }
                    
                    HStack(spacing: 4) {
                        Text("🔥 4 победы подряд")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(AppTheme.textPrimary(for: isDark))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(AppTheme.darkCard(for: isDark))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Sparkline Chart & Delta
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(spacing: 2) {
                        Image(systemName: "line.diagonal.arrow.up.right")
                            .font(.system(size: 10, weight: .bold))
                        Text("+0.25")
                            .font(.system(size: 11, weight: .bold))
                    }
                    .foregroundColor(AppTheme.neonAccent)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(AppTheme.neonAccent.opacity(0.15))
                    .cornerRadius(6)
                    
                    Text("NTRP дельта (30д)")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                    
                    // Simple Sparkline vector
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 15))
                        path.addLine(to: CGPoint(x: 15, y: 12))
                        path.addLine(to: CGPoint(x: 30, y: 18))
                        path.addLine(to: CGPoint(x: 45, y: 8))
                        path.addLine(to: CGPoint(x: 60, y: 2))
                    }
                    .stroke(AppTheme.neonAccent, lineWidth: 2)
                    .frame(width: 60, height: 20)
                }
            }
            
            Divider().background(AppTheme.border(for: isDark))
            
            // Lower Row: Surface Breakdown
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("ПОКРЫТИЯ КОРТА • КОРТ ТҮРІ")
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1)
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                    Spacer()
                    Text("Талдау")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.neonAccent)
                }
                
                HStack(spacing: 8) {
                    surfaceStatBox(name: "Hard", percentage: "78%", record: "18W - 5L", isDark: isDark)
                    surfaceStatBox(name: "Clay", percentage: "66%", record: "8W - 4L", isDark: isDark)
                    surfaceStatBox(name: "Grass/Ind", percentage: "67%", record: "2W - 1L", isDark: isDark)
                }
            }
        }
        .padding(16)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func surfaceStatBox(name: String, percentage: String, record: String, isDark: Bool) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Spacer()
                Text(percentage)
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(AppTheme.neonAccent)
            }
            Text(record)
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(AppTheme.textSecondary(for: isDark))
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(AppTheme.darkCard(for: isDark))
        .cornerRadius(10)
    }
    
    // MARK: - Filter Segment Picker
    @ViewBuilder
    private func filterSegmentPicker(isDark: Bool) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(MatchFilter.allCases) { filter in
                    let isSelected = selectedFilter == filter
                    Button(action: {
                        Haptics.selection()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedFilter = filter
                        }
                    }) {
                        Text(filter.rawValue)
                            .font(.system(size: 12, weight: .bold))
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
    
    // MARK: - Match Cards List
    @ViewBuilder
    private func matchCardsList(isDark: Bool) -> some View {
        VStack(spacing: 14) {
            // Match 1: Win 1v1 Sparring
            sparringMatchCard(
                isWin: true,
                badgeText: "WIN • ЖЕҢІС",
                typeText: "Спарринг 1v1",
                duration: "1ч 45мин",
                courtName: "Almaty Tennis Club (Корт #3, Hard)",
                dateText: "Вчера, 19:30",
                p1Name: "Aliya Nurlan", p1Level: "4.5 (ВЫ)", p1Scores: ["6", "7"],
                p2Name: "Daniyar Kasymov", p2Level: "4.5", p2Scores: ["4", "5"],
                statsNote: "Эйсы: 6 • Брейк-поинты: 4/5",
                isDark: isDark
            )
            
            // Match 2: Tournament Win
            tournamentMatchCard(
                tournamentTag: "ÖZINŞE CUP • 1/4 ФИНАЛА",
                pointsEarned: "+45 pts",
                courtName: "Gorky Tennis Park (Clay • Топырақ)",
                dateText: "20 Қазан, 11:00",
                p1Name: "Aliya N.", p1Level: "4.5", p1Scores: ["4", "6", "10"],
                p2Name: "Мадина И.", p2Level: "4.0", p2Scores: ["6", "3", "8"],
                duration: "2ч 10мин",
                fairPlayBadge: "★ 5.0 Fair Play",
                isDark: isDark
            )
            
            // Match 3: Loss Sparring
            sparringLossCard(
                badgeText: "LOSS • ЖЕҢІЛІС",
                typeText: "Спарринг 1v1",
                duration: "1ч 35мин",
                courtName: "National Tennis Center (Indoor Hard)",
                dateText: "16 Қазан",
                p1Name: "Aliya N.", p1Level: "4.5", p1Scores: [("6", "5"), ("4", nil)],
                p2Name: "Арман Сериков", p2Level: "4.8", p2Scores: [("7", "7"), ("6", nil)],
                note: "Тай-брейк 1-сет • Спарринг-радар 50/50",
                isDark: isDark
            )
            
            // Match 4: Doubles 2x2 Win
            doublesMatchCard(
                tagText: "DOUBLES 2X2",
                duration: "1ч 20мин",
                courtName: "Daulet Tennis Center (Hard)",
                dateText: "12 Қазан",
                pair1Name: "Aliya N. & Ерлан С.", pair1Scores: ["6", "6"],
                pair2Name: "Тимур К. & Санжар Б.", pair2Scores: ["2", "4"],
                footerNote: "Парная игра 2v2 • Сыгранный дуэт",
                isDark: isDark
            )
        }
    }
    
    // MARK: - Match Card Components
    private func sparringMatchCard(
        isWin: Bool, badgeText: String, typeText: String, duration: String,
        courtName: String, dateText: String,
        p1Name: String, p1Level: String, p1Scores: [String],
        p2Name: String, p2Level: String, p2Scores: [String],
        statsNote: String, isDark: Bool
    ) -> some View {
        VStack(spacing: 12) {
            // Header Row
            HStack {
                Text(badgeText)
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(Color(hex: "0A0A0C"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppTheme.neonAccent)
                    .cornerRadius(6)
                
                Text(typeText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                    Text(duration)
                        .font(.system(size: 10, weight: .semibold))
                }
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            
            // Court venue
            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.neonAccent)
                Text(courtName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Text("•  \(dateText)")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Players Table
            VStack(spacing: 8) {
                playerScoreRow(name: p1Name, level: p1Level, scores: p1Scores, isWinner: true, isDark: isDark)
                playerScoreRow(name: p2Name, level: p2Level, scores: p2Scores, isWinner: false, isDark: isDark)
            }
            .padding(8)
            .background(AppTheme.darkCard(for: isDark))
            .cornerRadius(12)
            
            // Footer Action Row
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 10))
                        .foregroundColor(AppTheme.neonAccent)
                    Text(statsNote)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                }
                
                Spacer()
                
                HStack(spacing: 6) {
                    Button("Талдау / Аналитика") {}
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(AppTheme.darkCard(for: isDark))
                        .cornerRadius(6)
                    
                    Button("Реванш") {}
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary(for: isDark))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(AppTheme.darkCard(for: isDark))
                        .cornerRadius(6)
                }
            }
        }
        .padding(14)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func tournamentMatchCard(
        tournamentTag: String, pointsEarned: String,
        courtName: String, dateText: String,
        p1Name: String, p1Level: String, p1Scores: [String],
        p2Name: String, p2Level: String, p2Scores: [String],
        duration: String, fairPlayBadge: String, isDark: Bool
    ) -> some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 10))
                    Text(tournamentTag)
                        .font(.system(size: 10, weight: .black))
                }
                .foregroundColor(AppTheme.neonAccent)
                
                Spacer()
                
                Text("WIN")
                    .font(.system(size: 9, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(AppTheme.neonAccent)
                    .foregroundColor(Color(hex: "0A0A0C"))
                    .cornerRadius(4)
                
                Text(pointsEarned)
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(AppTheme.neonAccent)
            }
            
            HStack(spacing: 4) {
                Image(systemName: "sportscourt")
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                Text(courtName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Text("•  \(dateText)")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 8) {
                playerScoreRow(name: p1Name, level: p1Level, scores: p1Scores, isWinner: true, isDark: isDark)
                playerScoreRow(name: p2Name, level: p2Level, scores: p2Scores, isWinner: false, isDark: isDark)
            }
            .padding(8)
            .background(AppTheme.darkCard(for: isDark))
            .cornerRadius(12)
            
            HStack {
                HStack(spacing: 8) {
                    Label(duration, systemImage: "clock")
                        .font(.system(size: 10, weight: .semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.darkCard(for: isDark))
                        .cornerRadius(6)
                    
                    Text(fairPlayBadge)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.darkCard(for: isDark))
                        .cornerRadius(6)
                }
                .foregroundColor(AppTheme.textSecondary(for: isDark))
                
                Spacer()
                
                Button("Матч тарихы") {}
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppTheme.darkCard(for: isDark))
                    .cornerRadius(6)
            }
        }
        .padding(14)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func sparringLossCard(
        badgeText: String, typeText: String, duration: String,
        courtName: String, dateText: String,
        p1Name: String, p1Level: String, p1Scores: [(String, String?)],
        p2Name: String, p2Level: String, p2Scores: [(String, String?)],
        note: String, isDark: Bool
    ) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text(badgeText)
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(hex: "D32F2F"))
                    .cornerRadius(6)
                
                Text(typeText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                Spacer()
                
                Label(duration, systemImage: "clock")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            
            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                Text(courtName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Text("•  \(dateText)")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 8) {
                playerTiebreakRow(name: p1Name, level: p1Level, scores: p1Scores, isWinner: false, isDark: isDark)
                playerTiebreakRow(name: p2Name, level: p2Level, scores: p2Scores, isWinner: true, isDark: isDark)
            }
            .padding(8)
            .background(AppTheme.darkCard(for: isDark))
            .cornerRadius(12)
            
            HStack {
                Text(note)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                
                Spacer()
                
                Button("Реванш шақыру") {}
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(AppTheme.neonAccent)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppTheme.darkCard(for: isDark))
                    .cornerRadius(6)
            }
        }
        .padding(14)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    private func doublesMatchCard(
        tagText: String, duration: String, courtName: String, dateText: String,
        pair1Name: String, pair1Scores: [String],
        pair2Name: String, pair2Scores: [String],
        footerNote: String, isDark: Bool
    ) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text(tagText)
                    .font(.system(size: 10, weight: .black))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppTheme.darkCard(for: isDark))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                    .cornerRadius(6)
                
                Text("WIN")
                    .font(.system(size: 9, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(AppTheme.neonAccent)
                    .foregroundColor(Color(hex: "0A0A0C"))
                    .cornerRadius(4)
                
                Spacer()
                
                Label(duration, systemImage: "clock")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            
            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 10))
                    .foregroundColor(AppTheme.neonAccent)
                Text(courtName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                Text("•  \(dateText)")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 8) {
                playerScoreRow(name: pair1Name, level: nil, scores: pair1Scores, isWinner: true, isDark: isDark)
                playerScoreRow(name: pair2Name, level: nil, scores: pair2Scores, isWinner: false, isDark: isDark)
            }
            .padding(8)
            .background(AppTheme.darkCard(for: isDark))
            .cornerRadius(12)
            
            HStack {
                Text(footerNote)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(AppTheme.textSecondary(for: isDark))
                
                Spacer()
                
                Button("Матч хаттамасы") {}
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppTheme.darkCard(for: isDark))
                    .cornerRadius(6)
            }
        }
        .padding(14)
        .background(AppTheme.card(for: isDark))
        .cornerRadius(AppTheme.standardCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.border(for: isDark), lineWidth: 1))
    }
    
    // MARK: - Row Helpers
    private func playerScoreRow(name: String, level: String?, scores: [String], isWinner: Bool, isDark: Bool) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 24))
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            
            HStack(spacing: 6) {
                Text(name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                if let level {
                    Text(level)
                        .font(.system(size: 9, weight: .bold))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(isWinner ? AppTheme.neonAccent.opacity(0.2) : AppTheme.card(for: isDark))
                        .foregroundColor(isWinner ? AppTheme.neonAccent : AppTheme.textSecondary(for: isDark))
                        .cornerRadius(4)
                }
            }
            
            Spacer()
            
            HStack(spacing: 6) {
                ForEach(scores, id: \.self) { score in
                    Text(score)
                        .font(.system(size: 15, weight: .black))
                        .frame(width: 30, height: 30)
                        .background(isWinner ? AppTheme.neonAccent : AppTheme.card(for: isDark))
                        .foregroundColor(isWinner ? Color(hex: "0A0A0C") : AppTheme.textPrimary(for: isDark))
                        .cornerRadius(15)
                }
            }
        }
    }
    
    private func playerTiebreakRow(name: String, level: String?, scores: [(String, String?)], isWinner: Bool, isDark: Bool) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 24))
                .foregroundColor(AppTheme.textSecondary(for: isDark))
            
            HStack(spacing: 6) {
                Text(name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary(for: isDark))
                
                if let level {
                    Text(level)
                        .font(.system(size: 9, weight: .bold))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(AppTheme.card(for: isDark))
                        .foregroundColor(AppTheme.textSecondary(for: isDark))
                        .cornerRadius(4)
                }
            }
            
            Spacer()
            
            HStack(spacing: 6) {
                ForEach(0..<scores.count, id: \.self) { idx in
                    let score = scores[idx]
                    ZStack(alignment: .topTrailing) {
                        Text(score.0)
                            .font(.system(size: 15, weight: .black))
                            .frame(width: 30, height: 30)
                            .background(AppTheme.card(for: isDark))
                            .foregroundColor(AppTheme.textPrimary(for: isDark))
                            .cornerRadius(15)
                        
                        if let tie = score.1 {
                            Text(tie)
                                .font(.system(size: 8, weight: .bold))
                                .foregroundColor(AppTheme.neonAccent)
                                .offset(x: 2, y: -2)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Bottom Action Button
    private var recordMatchButton: some View {
        Button(action: {
            Haptics.play(.medium)
            showRecordScoreSheet = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 18, weight: .bold))
                Text("Жаңа матч қосу • Записать счет")
                    .font(.system(size: 14, weight: .bold))
            }
            .foregroundColor(Color(hex: "0A0A0C"))
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(AppTheme.neonAccent)
            .cornerRadius(26)
            .shadow(color: AppTheme.neonAccent.opacity(0.3), radius: 10, x: 0, y: 5)
        }
    }
}

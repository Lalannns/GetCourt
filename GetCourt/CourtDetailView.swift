//
//  CourtDetailView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct CourtDetailView: View {
    @Bindable var store: AppStorageStore
    let court: Court
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedDate: Date = Date()
    @State private var selectedSlots: Set<String> = ["18:00 - 19:00"]
    @State private var isBookingConfirmed: Bool = false
    
    private let availableSlots = [
        "08:00 - 09:00", "09:00 - 10:00", "10:00 - 11:00",
        "14:00 - 15:00", "15:00 - 16:00", "16:00 - 17:00",
        "18:00 - 19:00", "19:00 - 20:00", "20:00 - 21:00"
    ]
    
    private var totalPrice: Int {
        selectedSlots.count * court.pricePerHour
    }
    
    public var body: some View {
        ZStack {
            AppTheme.graphiteBlack.ignoresSafeArea()
            
            if isBookingConfirmed {
                successStateView
            } else {
                mainBookingView
            }
        }
    }
    
    private var mainBookingView: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppTheme.textPrimary)
                        .padding(12)
                        .background(AppTheme.graphiteCard)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(AppTheme.graphiteBorder, lineWidth: 1))
                }
                
                Spacer()
                
                Text(store.localization.localized("court_rental"))
                    .font(.system(size: 14, weight: .bold))
                    .tracking(2)
                    .foregroundColor(AppTheme.textSecondary)
                
                Spacer()
                
                Image(systemName: "bookmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.textSecondary)
                    .padding(12)
                    .background(AppTheme.graphiteCard)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(AppTheme.graphiteBorder, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius, style: .continuous)
                            .fill(AppTheme.graphiteCard)
                            .frame(height: 180)
                            .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
                        
                        VStack {
                            Image(systemName: court.imageName)
                                .font(.system(size: 64))
                                .foregroundColor(AppTheme.neonAccent.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        HStack {
                            Text(court.surface)
                                .font(.system(size: 11, weight: .bold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(AppTheme.graphiteDark)
                                .foregroundColor(AppTheme.neonAccent)
                                .cornerRadius(8)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(AppTheme.neonAccent)
                                Text(String(format: "%.1f", court.rating))
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(AppTheme.graphiteDark)
                            .cornerRadius(8)
                        }
                        .padding(16)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(court.name)
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(AppTheme.neonAccent)
                            Text("\(court.location) • \(court.distance)")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    }
                    
                    Divider().background(AppTheme.graphiteBorder)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(store.localization.localized("select_date"))
                            .font(.system(size: 11, weight: .bold))
                            .tracking(1.5)
                            .foregroundColor(AppTheme.textSecondary)
                        
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .tint(AppTheme.neonAccent)
                            .padding(12)
                            .background(AppTheme.graphiteCard)
                            .cornerRadius(AppTheme.standardCornerRadius)
                            .overlay(RoundedRectangle(cornerRadius: AppTheme.standardCornerRadius).stroke(AppTheme.graphiteBorder, lineWidth: 1))
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(store.localization.localized("available_slots"))
                                .font(.system(size: 11, weight: .bold))
                                .tracking(1.5)
                                .foregroundColor(AppTheme.textSecondary)
                            Spacer()
                            Text(store.localization.localized("select_multiple"))
                                .font(.system(size: 11))
                                .foregroundColor(AppTheme.neonAccent)
                        }
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(availableSlots, id: \.self) { slot in
                                let isSelected = selectedSlots.contains(slot)
                                Button(action: {
                                    Haptics.selection()
                                    if isSelected {
                                        if selectedSlots.count > 1 { selectedSlots.remove(slot) }
                                    } else {
                                        selectedSlots.insert(slot)
                                    }
                                }) {
                                    Text(slot)
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(isSelected ? AppTheme.graphiteBlack : AppTheme.textPrimary)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 42)
                                        .background(isSelected ? AppTheme.neonAccent : AppTheme.graphiteCard)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(isSelected ? Color.clear : AppTheme.graphiteBorder, lineWidth: 1)
                                        )
                                }
                            }
                        }
                    }
                }
                .padding(20)
                .padding(.bottom, 100)
            }
            
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(store.localization.localized("total_amount")) (\(selectedSlots.count) HRS)")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(1)
                            .foregroundColor(AppTheme.textSecondary)
                        
                        Text("€\(totalPrice)")
                            .font(.system(size: 26, weight: .black))
                            .foregroundColor(AppTheme.neonAccent)
                    }
                    
                    Spacer()
                    
                    KineticButton(title: store.localization.localized("confirm_booking"), icon: "checkmark.seal.fill") {
                        Haptics.notification(.success)
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            isBookingConfirmed = true
                        }
                    }
                    .frame(width: 200)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    AppTheme.graphiteCard
                        .overlay(Rectangle().fill(AppTheme.graphiteBorder).frame(height: 1), alignment: .top)
                        .ignoresSafeArea(edges: .bottom)
                )
            }
        }
    }
    
    private var successStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(AppTheme.neonAccent.opacity(0.15))
                    .frame(width: 120, height: 120)
                    .blur(radius: 20)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(AppTheme.neonAccent)
            }
            
            VStack(spacing: 8) {
                Text(store.localization.localized("court_reserved"))
                    .font(.system(size: 26, weight: .black))
                    .tracking(1)
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(store.localization.localized("reservation_confirmed"))
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(store.localization.localized("duration"))
                        .foregroundColor(AppTheme.textSecondary)
                    Spacer()
                    Text("\(selectedSlots.count) Hours")
                        .bold()
                        .foregroundColor(AppTheme.textPrimary)
                }
                HStack {
                    Text(store.localization.localized("total_paid"))
                        .foregroundColor(AppTheme.textSecondary)
                    Spacer()
                    Text("€\(totalPrice)")
                        .bold()
                        .foregroundColor(AppTheme.neonAccent)
                }
            }
            .font(.system(size: 14))
            .padding(16)
            .background(AppTheme.graphiteCard)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.graphiteBorder, lineWidth: 1))
            .padding(.horizontal, 32)
            
            Spacer()
            
            KineticButton(title: store.localization.localized("done"), icon: "arrow.right", isPrimary: true) {
                dismiss()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 24)
        }
    }
}

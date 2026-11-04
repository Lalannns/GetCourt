//
//  BookingSheetView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct BookingSheetView: View {
    let court: Court
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTime: String = "18:00 - 19:30"
    
    let timeSlots = ["09:00 - 10:30", "12:00 - 13:30", "15:00 - 16:30", "18:00 - 19:30"]
    
    public var body: some View {
        ZStack {
            AppTheme.graphiteBlack.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("RESERVE COURT")
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(AppTheme.textPrimary)
                        Text(court.name)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppTheme.neonAccent)
                    }
                    
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                
                // Time Slot Selection
                VStack(alignment: .leading, spacing: 12) {
                    Text("SELECT TIME SLOT")
                        .font(.system(size: 11, weight: .bold))
                        .tracking(1.5)
                        .foregroundColor(AppTheme.textSecondary)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(timeSlots, id: \.self) { slot in
                            Button(action: {
                                Haptics.selection()
                                selectedTime = slot
                            }) {
                                Text(slot)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(selectedTime == slot ? AppTheme.graphiteBlack : AppTheme.textPrimary)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(selectedTime == slot ? AppTheme.neonAccent : AppTheme.graphiteCard)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedTime == slot ? Color.clear : AppTheme.graphiteBorder, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
                
                Spacer()
                
                KineticButton(title: "CONFIRM RESERVATION", icon: "checkmark.shield.fill") {
                    Haptics.notification(.success)
                    dismiss()
                }
            }
            .padding(24)
        }
    }
}

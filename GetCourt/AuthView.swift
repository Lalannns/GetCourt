//
//  AuthView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct AuthView: View {
    @Bindable var store: AppStorageStore
    @State private var email: String = ""
    
    public var body: some View {
        ZStack {
            AppTheme.graphiteBlack
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("WELCOME TO\nGET COURT")
                        .font(.system(size: 34, weight: .black))
                        .tracking(1)
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text("Enter the grid. Book courts, find local players, and elevate your game.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(AppTheme.textSecondary)
                        .lineSpacing(4)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("EMAIL OR PLAYER ID")
                        .font(.system(size: 11, weight: .bold))
                        .tracking(1.5)
                        .foregroundColor(AppTheme.textSecondary)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(AppTheme.textSecondary)
                        
                        TextField("player@getcourt.app", text: $email)
                            .foregroundColor(AppTheme.textPrimary)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: AppTheme.buttonCornerRadius, style: .continuous)
                            .fill(AppTheme.graphiteCard)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.buttonCornerRadius, style: .continuous)
                            .stroke(AppTheme.graphiteBorder, lineWidth: 1)
                    )
                }
                .padding(.top, 12)
                
                Spacer()
                
                KineticButton(
                    title: "ACCESS PLATFORM",
                    icon: "arrow.right",
                    isPrimary: true
                ) {
                    store.login()
                }
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
    }
}

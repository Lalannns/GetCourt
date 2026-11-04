//
//  SplashView.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

public struct SplashView: View {
    @Bindable var store: AppStorageStore
    @State private var scaleEffect: CGFloat = 0.8
    @State private var opacityVal: Double = 0.0

    public var body: some View {
        ZStack {
            AppTheme.graphiteBlack
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(AppTheme.neonAccent.opacity(0.15))
                        .frame(width: 120, height: 120)
                        .blur(radius: 20)
                    
                    Image(systemName: "tennis.racket")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(AppTheme.neonAccent)
                }
                .scaleEffect(scaleEffect)
                
                Text("GET COURT")
                    .font(.system(size: 28, weight: .black))
                    .tracking(2)
                    .foregroundColor(AppTheme.textPrimary)
                
                Text("TENNIS • MATCHMAKING • RADAR")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(3)
                    .foregroundColor(AppTheme.textSecondary)
            }
            .opacity(opacityVal)
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                scaleEffect = 1.0
                opacityVal = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                store.transition(to: .unauthenticated)
            }
        }
    }
}

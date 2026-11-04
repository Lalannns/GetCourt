//
//  KineticButton.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import SwiftUI

/// A high-impact, kinetic call-to-action button with spring scaling and haptics.
public struct KineticButton: View {
    let title: String
    let icon: String?
    let isPrimary: Bool
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    public init(
        title: String,
        icon: String? = nil,
        isPrimary: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isPrimary = isPrimary
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            Haptics.play(.medium)
            action()
        }) {
            HStack(spacing: 10) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .bold))
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .tracking(0.5)
            }
            .foregroundColor(isPrimary ? AppTheme.graphiteBlack : AppTheme.textPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.buttonCornerRadius, style: .continuous)
                    .fill(isPrimary ? AppTheme.neonAccent : AppTheme.graphiteCard)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.buttonCornerRadius, style: .continuous)
                    .stroke(isPrimary ? Color.clear : AppTheme.graphiteBorder, lineWidth: 1)
            )
            .shadow(
                color: isPrimary ? AppTheme.neonAccent.opacity(0.25) : Color.black.opacity(0.3),
                radius: isPressed ? 4 : 12,
                x: 0,
                y: isPressed ? 2 : 6
            )
        }
        .buttonStyle(KineticButtonStyle(isPressed: $isPressed))
    }
}

// MARK: - Button Style for Press Physics
private struct KineticButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressed = newValue
            }
    }
}

//
//  Theme.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import Foundation
import SwiftUI

/// Central design tokens and color palette for GET COURT.
public struct AppTheme {
    // MARK: - Static Colors (Backward compatibility for AuthView, BookingSheetView, etc.)
    public static let neonAccent = Color(hex: "CCFF00")
    public static let graphiteBlack = Color(hex: "0A0A0C")
    public static let graphiteDark = Color(hex: "141416")
    public static let graphiteCard = Color(hex: "1C1C20")
    public static let graphiteBorder = Color(hex: "2E2E36")
    
    public static let textPrimary = Color.white
    public static let textSecondary = Color(hex: "9E9EA6")
    
    // MARK: - Dynamic Theme Methods
    public static func bg(for isDark: Bool) -> Color { isDark ? Color(hex: "0A0A0C") : Color(hex: "F4F4F6") }
    public static func card(for isDark: Bool) -> Color { isDark ? Color(hex: "1C1C20") : Color(hex: "FFFFFF") }
    public static func darkCard(for isDark: Bool) -> Color { isDark ? Color(hex: "141416") : Color(hex: "EAEAEF") }
    public static func border(for isDark: Bool) -> Color { isDark ? Color(hex: "2E2E36") : Color(hex: "D8D8E0") }
    public static func textPrimary(for isDark: Bool) -> Color { isDark ? Color.white : Color(hex: "111113") }
    public static func textSecondary(for isDark: Bool) -> Color { isDark ? Color(hex: "9E9EA6") : Color(hex: "66666E") }
    
    // MARK: - Layout Constants
    public static let standardCornerRadius: CGFloat = 16
    public static let buttonCornerRadius: CGFloat = 14
    public static let standardSpacing: CGFloat = 16
}

// MARK: - Color Hex Initializer
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}

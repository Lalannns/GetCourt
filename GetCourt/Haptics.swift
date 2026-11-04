//
//  Haptics.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import Foundation
import UIKit

/// Centralized haptic feedback generator for kinetic interactions.
public enum Haptics {
    public static func play(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    public static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}

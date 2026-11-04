//
//  Court.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import Foundation

public struct Court: Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let surface: String
    public let location: String
    public let distance: String
    public let pricePerHour: Int
    public let rating: Double
    public let imageName: String
    public let isAvailable: Bool
    
    public static let sampleCourts: [Court] = [
        .init(name: "Grand Central Arena", surface: "Hard Court (Indoor)", location: "Mitte District", distance: "0.8 km", pricePerHour: 35, rating: 4.9, imageName: "tennis.racket", isAvailable: true),
        .init(name: "Baseline Club & Courts", surface: "Clay (Outdoor)", location: "North Park", distance: "2.4 km", pricePerHour: 28, rating: 4.7, imageName: "figure.tennis", isAvailable: true),
        .init(name: "Metro Elite Tennis Hub", surface: "Synthetic Grass", location: "Westside", distance: "4.1 km", pricePerHour: 42, rating: 4.8, imageName: "sportscourt", isAvailable: false)
    ]
}

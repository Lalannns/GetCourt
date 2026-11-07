//
//  Court.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import Foundation

public struct Court: Identifiable, Hashable {
    public let id: String
    public let name: String
    public let surface: String
    public let location: String
    public let distance: String
    public let pricePerHour: Int
    public let rating: Double
    public let imageName: String
    public let isAvailable: Bool
    
    public init(id: String? = nil, name: String, surface: String, location: String, distance: String, pricePerHour: Int, rating: Double, imageName: String, isAvailable: Bool) {
        self.id = id ?? name.lowercased().replacingOccurrences(of: " ", with: "-")
        self.name = name
        self.surface = surface
        self.location = location
        self.distance = distance
        self.pricePerHour = pricePerHour
        self.rating = rating
        self.imageName = imageName
        self.isAvailable = isAvailable
    }
    
    public static let sampleCourts: [Court] = [
        .init(name: "Grand Central Arena", surface: "Hard Court (Indoor)", location: "Mitte District", distance: "0.8 km", pricePerHour: 35, rating: 4.9, imageName: "tennis.racket", isAvailable: true),
        .init(name: "Baseline Club & Courts", surface: "Clay (Outdoor)", location: "North Park", distance: "2.4 km", pricePerHour: 28, rating: 4.7, imageName: "figure.tennis", isAvailable: true),
        .init(name: "Metro Elite Tennis Hub", surface: "Synthetic Grass", location: "Westside", distance: "4.1 km", pricePerHour: 42, rating: 4.8, imageName: "sportscourt", isAvailable: false)
    ]
}

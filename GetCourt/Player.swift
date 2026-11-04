//
//  Player.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import Foundation

public struct Player: Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let ntrpLevel: String
    public let distance: String
    public let preferredSurface: String
    public let avatarIcon: String
    public let matchesPlayed: Int
    public let winRate: Int
    
    public static let samplePlayers: [Player] = [
        .init(name: "Marcus Vance", ntrpLevel: "4.5 (Advanced)", distance: "1.2 km away", preferredSurface: "Hard Court", avatarIcon: "person.crop.circle.fill", matchesPlayed: 48, winRate: 68),
        .init(name: "Elena Rostova", ntrpLevel: "4.0 (Intermediate)", distance: "2.8 km away", preferredSurface: "Clay", avatarIcon: "person.crop.circle.fill", matchesPlayed: 32, winRate: 62),
        .init(name: "David Chen", ntrpLevel: "5.0 (Semi-Pro)", distance: "3.5 km away", preferredSurface: "Indoor Hard", avatarIcon: "person.crop.circle.fill", matchesPlayed: 94, winRate: 75),
        .init(name: "Sarah Jenkins", ntrpLevel: "3.5 (Intermediate)", distance: "5.0 km away", preferredSurface: "Grass", avatarIcon: "person.crop.circle.fill", matchesPlayed: 21, winRate: 54)
    ]
}

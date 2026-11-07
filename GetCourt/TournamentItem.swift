//
//  TournamentItem.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 07.11.2026.
//

import Foundation

public enum TournamentCategory: String, CaseIterable, Identifiable {
    case global = "filter_global"
    case kazakhstan = "filter_kazakhstan"
    case news = "filter_news"
    
    public var id: String { rawValue }
}

public struct TournamentItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let category: TournamentCategory
    public let dates: String
    public let location: String
    public let surface: String
    public let categoryBadge: String
    public let prizeMoney: String?
    public let newsSnippet: String
    public let imageName: String
    
    public static let sampleItems: [TournamentItem] = [
        TournamentItem(
            title: "ATP 250 Almaty Open",
            category: .kazakhstan,
            dates: "19 - 25 Октября, 2026",
            location: "Almaty, Kazakhstan (Almaty Arena)",
            surface: "Indoor Hard",
            categoryBadge: "ATP 250",
            prizeMoney: "$1,050,000",
            newsSnippet: "Казахстан готовится принять главный мировой теннисный турнир осени. Топ-игроки мира соберутся на хардовых кортах Алматы Арены.",
            imageName: "trophy.fill"
        ),
        TournamentItem(
            title: "Almaty Open Cup 2027",
            category: .kazakhstan,
            dates: "18 - 20 Апреля, 2027",
            location: "Qazaq Tennis Center, Almaty",
            surface: "Hard Court",
            categoryBadge: "KTF Masters",
            prizeMoney: "3,500,000 ₸",
            newsSnippet: "Открыта регистрация на ежегодный кубок для игроков категорий Masters и PRO. Турнирные сетки формируются по NTRP рейтингу.",
            imageName: "sportscourt.fill"
        ),
        TournamentItem(
            title: "Nitto ATP Finals Turin",
            category: .global,
            dates: "15 - 22 Ноября, 2026",
            location: "Turin, Italy",
            surface: "Indoor Hard",
            categoryBadge: "ATP Finals",
            prizeMoney: "$15,000,000",
            newsSnippet: "Восьмерка лучших теннисистов планеты сразится за итоговый титул года в Турине.",
            imageName: "crown.fill"
        ),
        TournamentItem(
            title: "Australian Open 2027",
            category: .global,
            dates: "17 - 31 Января, 2027",
            location: "Melbourne Park, Australia",
            surface: "Hard Court",
            categoryBadge: "Grand Slam",
            prizeMoney: "86,500,000 AUD",
            newsSnippet: "Официально объявлено расписание первого турнира Большого Шлема 2027 года. Продажи билетов уже стартовали.",
            imageName: "sun.max.fill"
        ),
        TournamentItem(
            title: "KTF Junior Masters U14 & U12",
            category: .kazakhstan,
            dates: "10 - 16 Декабря, 2026",
            location: "Beeline Arena, Astana",
            surface: "Clay & Hard",
            categoryBadge: "KTF Youth",
            prizeMoney: "Гранты & Амуниция",
            newsSnippet: "Федерация тенниса Казахстана проводит итоговый юниорский турнир среди сильнейших ракеток страны.",
            imageName: "figure.tennis"
        )
    ]
}

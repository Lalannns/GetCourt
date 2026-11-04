//
//  LocalizationService.swift
//  GetCourt
//
//  Created by Allan Auezkhan on 04.11.2026.
//

import Foundation

public enum AppLanguage: String, CaseIterable, Identifiable {
    case russian = "Русский"
    case kazakh = "Қазақша"
    case english = "English"
    
    public var id: String { self.rawValue }
    
    public var code: String {
        switch self {
        case .russian: return "ru"
        case .kazakh: return "kk"
        case .english: return "en"
        }
    }
}

@Observable
public final class LocalizationService {
    public var currentLanguage: AppLanguage = .kazakh {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "SelectedAppLanguage")
        }
    }
    
    public init() {
        if let savedLang = UserDefaults.standard.string(forKey: "SelectedAppLanguage"),
           let lang = AppLanguage(rawValue: savedLang) {
            self.currentLanguage = lang
        }
    }
    
    public func localized(_ key: String) -> String {
        return localizedStrings[currentLanguage.code]?[key] ?? localizedStrings["en"]?[key] ?? key
    }
    
    private let localizedStrings: [String: [String: String]] = [
        "ru": [
            // Tabs
            "home": "Главная",
            "courts": "Корты",
            "radar": "Соперники",
            "profile": "Профиль",
            
            // Home Dashboard
            "home_court": "Домашний корт",
            "hello_user": "Привет, Аллан! 👋",
            "club_pro": "КЛУБ ПРО",
            "online_count": "ОНЛАЙН: 14",
            "active_game": "ИГРА СЕГОДНЯ",
            "time_left": "Через 2 ч 40 мин",
            "qr_pass": "Открыть пропуск • QR Билет",
            "book_court_btn": "Забронировать корт",
            "book_subtitle": "Свободные слоты",
            "find_opponent": "Найти соперника",
            "radar_subtitle": "Радар игроков",
            "tournaments": "Турниры",
            "tournaments_sub": "Сетки и матчи",
            "coaches": "Тренеры",
            "coaches_sub": "Топ тренеры PRO",
            "registration": "РЕГИСТРАЦИЯ",
            "tournament_name": "Almaty Open Cup 2027",
            "tournament_desc": "Категория: Masters, 18–20 Апреля\nЛокация: Qazaq Tennis Center",
            "nearby_courts": "Корты рядом",
            "more": "Больше >",
            "opponent_radar": "Радар соперников",
            "opponent_radar_desc": "Ищут спарринг в вашем уровне (4.0 – 4.5)",
            "play": "Играть",
            "qr_alert_title": "QR Пропуск",
            "qr_alert_msg": "Ваш клубный пропуск действителен для Almaty Tennis Club (Корт #3). Предъявите на турникет.",
            
            // Courts & Rental
            "court_catalog": "КАТАЛОГ КОРТОВ",
            "court_rental": "АРЕНДА КОРТА",
            "select_date": "ВЫБЕРИТЕ ДАТУ",
            "available_slots": "ДОСТУПНЫЕ СЛОТЫ",
            "select_multiple": "Несколько слотов",
            "total_amount": "ИТОГО К ОПЛАТЕ",
            "confirm_booking": "ПОДТВЕРДИТЬ БРОНЬ",
            "court_reserved": "КОРТ ЗАБРОНИРОВАН!",
            "reservation_confirmed": "Ваша бронь успешно подтверждена.",
            "duration": "Длительность",
            "total_paid": "Сумма",
            "done": "ГОТОВО",
            
            // Match Radar
            "player_matchmaker": "ПОИСК СОПЕРНИКОВ",
            "match_radar_title": "Матч Радар",
            "scanning_courts": "СКАНИРОВАНИЕ КОРТОВ...",
            "finding_players": "Ищем игроков вашего NTRP уровня",
            "nearby_opponents": "СОПЕРНИКИ РЯДОМ",
            "challenge": "ВЫЗОВ",
            
            // Profile
            "profile_title": "Профиль",
            "sparring_active": "Спарринг-радар активен",
            "seeking_partner": "ИЩЕТ ПАРУ 4.5+",
            "rating": "РЕЙТИНГ",
            "matches": "МАТЧИ",
            "wins": "ПОБЕДЫ",
            "court_time": "КОРТ",
            "language_section": "ТІЛ / ЯЗЫК ИНТЕРФЕЙСА / LANGUAGE",
            "select_language": "Тілді таңдаңыз",
            "account_management": "УПРАВЛЕНИЕ АККАУНТОМ",
            "personal_data": "Личные данные и NTRP",
            "personal_data_sub": "Правша • Wilson Pro Staff 97 • NTRP 4.5",
            "my_bookings": "Мои бронирования и билеты",
            "my_bookings_sub": "Мои брони • 2 активных слота",
            "match_history": "История матчей и статистика",
            "match_history_sub": "Последний матч: 6–4, 7–5 (W)",
            "favorite_courts": "Избранные корты",
            "favorite_courts_sub": "Almaty Tennis Club, Gorky Park Hard",
            "radar_challenges": "Спарринг-радар и вызовы",
            "radar_challenges_sub": "Уведомления • 3 новых запроса на игру",
            "support_247": "Служба заботы 24/7",
            "support_sub": "Поддержка • WhatsApp & In-App Chat",
            "app_preferences": "НАСТРОЙКИ ПРИЛОЖЕНИЯ",
            "ios_haptics": "Тактильный отклик iOS",
            "ios_haptics_sub": "Виброотклик при бронировании",
            "dark_mode": "Тёмная тема",
            "dark_mode_sub": "Энергоэффективный ночной корт",
            "logout": "Выйти из аккаунта",
            "version_info": "GET COURT v2.4.0 • Almaty Open 2027 Edition"
        ],
        "kk": [
            // Tabs
            "home": "Басты бет",
            "courts": "Корттар",
            "radar": "Қарсыластар",
            "profile": "Профиль",
            
            // Home Dashboard
            "home_court": "Үй корт",
            "hello_user": "Сәлем, Аллан! 👋",
            "club_pro": "КЛУБ ПРО",
            "online_count": "ОНЛАЙН: 14",
            "active_game": "БҮГІНГІ ОЙЫН",
            "time_left": "2 сағ 40 мин қалды",
            "qr_pass": "Өтпелі • QR Билет",
            "book_court_btn": "Кортты брондау",
            "book_subtitle": "Бос уақыт слоттары",
            "find_opponent": "Қарсылас табу",
            "radar_subtitle": "Ойыншылар радары",
            "tournaments": "Турнирлер",
            "tournaments_sub": "Торлар мен матчтар",
            "coaches": "Тренерлер",
            "coaches_sub": "Топ тренелер PRO",
            "registration": "ТІРКЕУ",
            "tournament_name": "Almaty Open Cup 2027",
            "tournament_desc": "Санат: Masters, 18–20 Сәуір\nОрын: Qazaq Tennis Center",
            "nearby_courts": "Жақын корттар",
            "more": "Көбірек >",
            "opponent_radar": "Қарсыластар радары",
            "opponent_radar_desc": "Сіздің деңгейіңізде спарринг іздеу (4.0 – 4.5)",
            "play": "Ойнау",
            "qr_alert_title": "QR Өткізу",
            "qr_alert_msg": "Сіздің клубтық билетіңіз Almaty Tennis Club (Корт #3) үшін жарамды. Турникетке көрсетіңіз.",
            
            // Courts & Rental
            "court_catalog": "КОРТТАР КАТАЛОГЫ",
            "court_rental": "КОРТТЫ ЖАЛҒА АЛУ",
            "select_date": "КҮНДІ ТАҢДAҢЫЗ",
            "available_slots": "БОС УАҚЫТ СЛОТТАРЫ",
            "select_multiple": "Бірнеше таңдау",
            "total_amount": "ЖАЛПЫ СОМАСЫ",
            "confirm_booking": "БРОНДАУДЫ РАСТАУ",
            "court_reserved": "КОРТ БРОНДАЛДЫ!",
            "reservation_confirmed": "Сіздің броныңыз сәтті расталды.",
            "duration": "Ұзақтығы",
            "total_paid": "Төленген сома",
            "done": "ДАЙЫН",
            
            // Match Radar
            "player_matchmaker": "ОЙЫНШЫНЫ ТАБУ",
            "match_radar_title": "Матч Радар",
            "scanning_courts": "КОРТТАРДЫ СКАНДАУ...",
            "finding_players": "Сіздің NTRP деңгейіңізге сай ойыншылар",
            "nearby_opponents": "ЖАҚЫНДАҒЫ ҚАРСЫЛАСТАР",
            "challenge": "ШАҚЫРУ",
            
            // Profile
            "profile_title": "Профиль",
            "sparring_active": "Спарринг-радар белсенді",
            "seeking_partner": "ЖҰП ІЗДЕУДЕ 4.5+",
            "rating": "РЕЙТИНГ",
            "matches": "МАТЧИ",
            "wins": "ЖЕҢІС",
            "court_time": "КОРТ",
            "language_section": "ТІЛ / ЯЗЫК ИНТЕРФЕЙСА / LANGUAGE",
            "select_language": "Тілді таңдаңыз",
            "account_management": "АККАУНТТЫ БАСҚАРУ",
            "personal_data": "Жеке деректер және NTRP",
            "personal_data_sub": "Оңқай • Wilson Pro Staff 97 • NTRP 4.5",
            "my_bookings": "Менің брондарым мен билеттерім",
            "my_bookings_sub": "Менің брондарым • 2 белсенді слот",
            "match_history": "Матчтар тарихы мен статистика",
            "match_history_sub": "Соңғы матч: 6–4, 7–5 (W)",
            "favorite_courts": "Таңдаулы корттар",
            "favorite_courts_sub": "Almaty Tennis Club, Gorky Park Hard",
            "radar_challenges": "Спарринг-радар және шақырулар",
            "radar_challenges_sub": "Хабарламалар • 3 жаңа ойын сұранысы",
            "support_247": "24/7 Қолдау қызметі",
            "support_sub": "Қолдау • WhatsApp & In-App Chat",
            "app_preferences": "ҚОСЫМША БАПТАУЛАРЫ",
            "ios_haptics": "iOS тактильді кері байланысы",
            "ios_haptics_sub": "Брондау кезіндегі вибро",
            "dark_mode": "Қараңғы режим",
            "dark_mode_sub": "Энергия үнемдейтін түнгі корт",
            "logout": "Аккаунттан шығу",
            "version_info": "GET COURT v2.4.0 • Almaty Open 2027 Edition"
        ],
        "en": [
            // Tabs
            "home": "Home",
            "courts": "Courts",
            "radar": "Radar",
            "profile": "Profile",
            
            // Home Dashboard
            "home_court": "Home Court",
            "hello_user": "Hello, Allan! 👋",
            "club_pro": "CLUB PRO",
            "online_count": "ONLINE: 14",
            "active_game": "TODAY'S MATCH",
            "time_left": "In 2h 40m",
            "qr_pass": "Open Pass • QR Ticket",
            "book_court_btn": "Book Court",
            "book_subtitle": "Available slots",
            "find_opponent": "Find Opponent",
            "radar_subtitle": "Player radar",
            "tournaments": "Tournaments",
            "tournaments_sub": "Brackets & matches",
            "coaches": "Coaches",
            "coaches_sub": "Top PRO coaches",
            "registration": "REGISTRATION",
            "tournament_name": "Almaty Open Cup 2027",
            "tournament_desc": "Category: Masters, April 18–20\nLocation: Qazaq Tennis Center",
            "nearby_courts": "Nearby Courts",
            "more": "More >",
            "opponent_radar": "Opponent Radar",
            "opponent_radar_desc": "Looking for sparring in your level (4.0 – 4.5)",
            "play": "Play",
            "qr_alert_title": "QR Pass",
            "qr_alert_msg": "Your club pass is valid for Almaty Tennis Club (Court #3). Present at turnstile.",
            
            // Courts & Rental
            "court_catalog": "COURT CATALOG",
            "court_rental": "COURT RENTAL",
            "select_date": "SELECT DATE",
            "available_slots": "AVAILABLE TIME SLOTS",
            "select_multiple": "Select multiple",
            "total_amount": "TOTAL AMOUNT",
            "confirm_booking": "CONFIRM BOOKING",
            "court_reserved": "COURT RESERVED!",
            "reservation_confirmed": "Your reservation is confirmed.",
            "duration": "Duration",
            "total_paid": "Total Paid",
            "done": "DONE",
            
            // Match Radar
            "player_matchmaker": "PLAYER MATCHMAKER",
            "match_radar_title": "Match Radar",
            "scanning_courts": "SCANNING NEARBY COURTS...",
            "finding_players": "Finding players matching your NTRP rating",
            "nearby_opponents": "NEARBY OPPONENTS",
            "challenge": "CHALLENGE",
            
            // Profile
            "profile_title": "Profile",
            "sparring_active": "Sparring radar active",
            "seeking_partner": "SEEKING PARTNER 4.5+",
            "rating": "RATING",
            "matches": "MATCHES",
            "wins": "WINS",
            "court_time": "COURT TIME",
            "language_section": "TІЛ / ЯЗЫК ИНТЕРФЕЙСА / LANGUAGE",
            "select_language": "Choose language",
            "account_management": "ACCOUNT MANAGEMENT",
            "personal_data": "Personal Data & NTRP",
            "personal_data_sub": "Right-handed • Wilson Pro Staff 97 • NTRP 4.5",
            "my_bookings": "My Bookings & Tickets",
            "my_bookings_sub": "My bookings • 2 active slots",
            "match_history": "Match History & Stats",
            "match_history_sub": "Last match: 6–4, 7–5 (W)",
            "favorite_courts": "Favorite Courts",
            "favorite_courts_sub": "Almaty Tennis Club, Gorky Park Hard",
            "radar_challenges": "Sparring Radar & Challenges",
            "radar_challenges_sub": "Notifications • 3 new game requests",
            "support_247": "24/7 Support Service",
            "support_sub": "Support • WhatsApp & In-App Chat",
            "app_preferences": "APP PREFERENCES",
            "ios_haptics": "iOS Haptic Feedback",
            "ios_haptics_sub": "Vibration on booking",
            "dark_mode": "Dark Theme",
            "dark_mode_sub": "Energy efficient night court",
            "logout": "Log Out",
            "version_info": "GET COURT v2.4.0 • Almaty Open 2027 Edition"
        ]
    ]
}

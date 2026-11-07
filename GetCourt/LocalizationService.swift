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
            
            // Courts & Catalog
            "court_catalog": "КАТАЛОГ КОРТОВ",
            "search_court_placeholder": "Поиск клуба, корта или района",
            "filter_all": "Все",
            "filter_clay": "Грунт",
            "filter_hard": "Хард",
            "filter_indoor": "Крытый",
            "select_time_slot": "Выберите слот",
            "amenity_shower": "Душ &\nСауна",
            "amenity_parking": "Паркинг",
            "amenity_gear": "Прокат\nинвентаря",
            "amenity_led": "LED\nПрожек",
            "gear_rental_title": "Мячи & Прокат ракеток",
            "gear_rental_desc": "2 ракетки Wilson + 3 мяча Babolat",
            "details_title": "Детализация",
            "court_rental_line": "Аренда корта (11:00 – 12:00, 1 час)",
            "gear_rental_line": "Инвентарь (2 ракетки + набор мячей)",
            "service_fee": "Сервисный сбор GET COURT",
            "free": "Бесплатно",
            "total_label": "Итого:",
            "book_cta": "Забронировать",
            "no_favorites": "Нет избранных кортов",
            "add_favorites_hint": "Добавляйте корты в избранное в каталоге.",
            "favorite_courts_title": "Избранные корты",
            
            // Profile
            "profile_title": "Профиль",
            "sparring_active": "Спарринг-радар активен",
            "seeking_partner": "ИЩЕТ ПАРУ 4.5+",
            "rating": "РЕЙТИНГ",
            "matches": "МАТЧИ",
            "wins": "ПОБЕДЫ",
            "court_time": "КОРТ",
            "language_section": "ЯЗЫК ИНТЕРФЕЙСА",
            "select_language": "Выберите язык",
            "account_management": "УПРАВЛЕНИЕ АККАУНТОМ",
            "personal_data": "Личные данные и NTRP",
            "personal_data_sub": "Правша • Wilson Pro Staff 97 • NTRP 4.5",
            "my_bookings": "Мои бронирования и билеты",
            "my_bookings_sub": "Мои брони • 2 активных слота",
            "match_history": "История матчей и статистика",
            "match_history_sub": "Последний матч: 6–4, 7–5 (W)",
            "favorite_courts": "Избранные корты",
            "favorite_courts_sub": "Ваши любимые клубы и корты",
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
            "version_info": "GET COURT v2.4.0 • Almaty Open 2027 Edition",
            
            // Tournaments
            "tournaments_title": "Турниры & Новости",
            "filter_global": "Всемирные (ATP/WTA)",
            "filter_kazakhstan": "Казахстан (KTF)",
            "filter_news": "Новости & Анонсы",
            "upcoming_events": "Предстоящие турниры",
            "latest_news": "Новости тенниса",
            "prize_pool": "Призовой фонд",
            "location": "Локация",
            
            // Match History & Analytics
            "match_history_title": "История матчей",
            "match_history_subtitle": "Аналитика и статистика матчей",
            "season_badge": "NTRP 4.5 • СЕЗОН 2025",
            "export_pdf": "Экспорт / PDF",
            "win_rate": "WIN RATE",
            "games_played": "игр",
            "winning_streak": "победы подряд",
            "ntrp_delta": "NTRP дельта (30д)",
            "surface_breakdown": "ПОКРЫТИЯ КОРТА",
            "analysis": "Анализ",
            "filter_all_matches": "Все матчи",
            "filter_wins": "Победы",
            "filter_losses": "Поражения",
            "sparring_1v1": "Спарринг 1v1",
            "doubles_tag": "ПАРНЫЙ МАТЧ 2X2",
            "analytics_btn": "Аналитика",
            "rematch_btn": "Реванш",
            "record_match_btn": "Записать счет матча",
            "match_protocol": "Протокол",
            "aces_breakpoints": "Эйсы: 6 • Брейк-поинты: 4/5"
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
            
            // Courts & Catalog
            "court_catalog": "КОРТТАР КАТАЛОГЫ",
            "search_court_placeholder": "Клубты, кортты немесе ауданды іздеу",
            "filter_all": "Барлығы",
            "filter_clay": "Топырақ",
            "filter_hard": "Хард",
            "filter_indoor": "Жабық",
            "select_time_slot": "Слотты таңдаңыз",
            "amenity_shower": "Душ &\nСауна",
            "amenity_parking": "Тұрақ",
            "amenity_gear": "Инвентарь\nжалға алу",
            "amenity_led": "LED\nЖарық",
            "gear_rental_title": "Доптар & Ракеткалар",
            "gear_rental_desc": "2 Wilson ракеткасы + 3 Babolat добы",
            "details_title": "Детальдар",
            "court_rental_line": "Кортты жалға алу (11:00 – 12:00, 1 сағ)",
            "gear_rental_line": "Инвентарь (2 ракетка + доп жиынтығы)",
            "service_fee": "GET COURT сервистік алымы",
            "free": "Тегін",
            "total_label": "Барлығы:",
            "book_cta": "Брондау",
            "no_favorites": "Таңдаулы корттар жоқ",
            "add_favorites_hint": "Каталогта корттарды таңдаулыларға қосыңыз.",
            "favorite_courts_title": "Таңдаулы корттар",
            
            // Profile
            "profile_title": "Профиль",
            "sparring_active": "Спарринг-радар белсенді",
            "seeking_partner": "ЖҰП ІЗДЕУДЕ 4.5+",
            "rating": "РЕЙТИНГ",
            "matches": "МАТЧТАР",
            "wins": "ЖЕҢІС",
            "court_time": "КОРТ",
            "language_section": "ІНТЕРФЕЙС ТІЛІ",
            "select_language": "Тілді таңдаңыз",
            "account_management": "АККАУНТТЫ БАСҚАРУ",
            "personal_data": "Жеке деректер және NTRP",
            "personal_data_sub": "Оңқай • Wilson Pro Staff 97 • NTRP 4.5",
            "my_bookings": "Менің брондарым мен билеттерім",
            "my_bookings_sub": "Менің брондарым • 2 белсенді слот",
            "match_history": "Матчтар тарихы мен статистика",
            "match_history_sub": "Соңғы матч: 6–4, 7–5 (W)",
            "favorite_courts": "Таңдаулы корттар",
            "favorite_courts_sub": "Сіздің сүйікті клубтарыңыз бен корттарыңыз",
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
            "version_info": "GET COURT v2.4.0 • Almaty Open 2027 Edition",
            
            // Tournaments
            "tournaments_title": "Турнирлер мен Жаңалықтар",
            "filter_global": "Әлемдік (ATP/WTA)",
            "filter_kazakhstan": "Қазақстан (KTF)",
            "filter_news": "Жаңалықтар & Анонстар",
            "upcoming_events": "Алдағы турнирлер",
            "latest_news": "Теннис жаңалықтары",
            "prize_pool": "Жүлде қоры",
            "location": "Орны",
            
            // Match History & Analytics
            "match_history_title": "Матчтар тарихы",
            "match_history_subtitle": "Матчтар аналитикасы мен статистикасы",
            "season_badge": "NTRP 4.5 • МАУСЫМ 2025",
            "export_pdf": "Экспорт / PDF",
            "win_rate": "ЖЕҢІС ПАЙЫЗЫ",
            "games_played": "ойын",
            "winning_streak": "қатарынан жеңіс",
            "ntrp_delta": "NTRP өсімі (30к)",
            "surface_breakdown": "КОРТ ЖАБЫҚТЫҒЫ",
            "analysis": "Талдау",
            "filter_all_matches": "Барлық матчтар",
            "filter_wins": "Жеңістер",
            "filter_losses": "Жеңілістер",
            "sparring_1v1": "Спарринг 1v1",
            "doubles_tag": "ЖҰПТЫҚ МАТЧ 2X2",
            "analytics_btn": "Аналитика",
            "rematch_btn": "Реванш",
            "record_match_btn": "Матч есебін жазу",
            "match_protocol": "Хаттама",
            "aces_breakpoints": "Эйстер: 6 • Брейк-поинттер: 4/5"
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
            
            // Courts & Catalog
            "court_catalog": "COURT CATALOG",
            "search_court_placeholder": "Search club, court or area",
            "filter_all": "All",
            "filter_clay": "Clay",
            "filter_hard": "Hard",
            "filter_indoor": "Indoor",
            "select_time_slot": "Select slot",
            "amenity_shower": "Shower &\nSauna",
            "amenity_parking": "Parking",
            "amenity_gear": "Gear\nRental",
            "amenity_led": "LED\nLights",
            "gear_rental_title": "Balls & Racket Rental",
            "gear_rental_desc": "2 Wilson rackets + 3 Babolat balls",
            "details_title": "Details",
            "court_rental_line": "Court Rental (11:00 – 12:00, 1 hr)",
            "gear_rental_line": "Equipment (2 rackets + balls)",
            "service_fee": "GET COURT Service Fee",
            "free": "Free",
            "total_label": "Total:",
            "book_cta": "Book",
            "no_favorites": "No Favorite Courts",
            "add_favorites_hint": "Add courts to your favorites in the catalog.",
            "favorite_courts_title": "Favorite Courts",
            
            // Profile
            "profile_title": "Profile",
            "sparring_active": "Sparring radar active",
            "seeking_partner": "SEEKING PARTNER 4.5+",
            "rating": "RATING",
            "matches": "MATCHES",
            "wins": "WINS",
            "court_time": "COURT TIME",
            "language_section": "INTERFACE LANGUAGE",
            "select_language": "Choose language",
            "account_management": "ACCOUNT MANAGEMENT",
            "personal_data": "Personal Data & NTRP",
            "personal_data_sub": "Right-handed • Wilson Pro Staff 97 • NTRP 4.5",
            "my_bookings": "My Bookings & Tickets",
            "my_bookings_sub": "My bookings • 2 active slots",
            "match_history": "Match History & Stats",
            "match_history_sub": "Last match: 6–4, 7–5 (W)",
            "favorite_courts": "Favorite Courts",
            "favorite_courts_sub": "Your favorite clubs and courts",
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
            "version_info": "GET COURT v2.4.0 • Almaty Open 2027 Edition",
            
            // Tournaments
            "tournaments_title": "Tournaments & News",
            "filter_global": "Global (ATP/WTA)",
            "filter_kazakhstan": "Kazakhstan (KTF)",
            "filter_news": "News & Announcements",
            "upcoming_events": "Upcoming Tournaments",
            "latest_news": "Tennis News",
            "prize_pool": "Prize Money",
            "location": "Location",
            
            // Match History & Analytics
            "match_history_title": "Match History",
            "match_history_subtitle": "Match Analytics & Statistics",
            "season_badge": "NTRP 4.5 • SEASON 2025",
            "export_pdf": "Export / PDF",
            "win_rate": "WIN RATE",
            "games_played": "games",
            "winning_streak": "win streak",
            "ntrp_delta": "NTRP Delta (30d)",
            "surface_breakdown": "COURT SURFACE BREAKDOWN",
            "analysis": "Analysis",
            "filter_all_matches": "All Matches",
            "filter_wins": "Wins",
            "filter_losses": "Losses",
            "sparring_1v1": "1v1 Sparring",
            "doubles_tag": "2v2 DOUBLES",
            "analytics_btn": "Analytics",
            "rematch_btn": "Rematch",
            "record_match_btn": "Record Match Score",
            "match_protocol": "Protocol",
            "aces_breakpoints": "Aces: 6 • Breakpoints: 4/5"
        ]
    ]
}

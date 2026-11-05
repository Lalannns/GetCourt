# 🎾 GET COURT — Premium Tennis Booking & Matchmaking (iOS)

**GET COURT** is a modern, high-fidelity iOS application built with **SwiftUI** designed for seamlessly searching tennis courts, booking dynamic time slots, and discovering nearby players through an interactive matchmaking radar.

---

## 🌟 Key Features & Highlights

- **Dynamic Theme Engine (`AppTheme`):** Real-time Light/Dark mode switching with backward-compatible static and dynamic color tokens.
- **Multi-Language Support (`LocalizationService`):** Dynamic runtime localization supporting **Kazakh (KK)**, **Russian (RU)**, and **English (EN)**.
- **Modern State Management:** Powered by `@Observable AppStorageStore` managing app state, authentication flow, theme preferences, and localized string bindings.
- **Compiler Optimized Layouts:** View hierarchies decoupled into lightweight `@ViewBuilder` subviews to eliminate Swift compiler type-checking bottlenecks.
- **Interactive Matchmaking Radar:** Real-time pulse animation for finding nearby tennis partners across customizable skill tiers.

---

## 📱 App Architecture & Tech Stack

- **Framework:** SwiftUI (iOS 17+)
- **Architecture:** MVVM + `@Observable` State Pattern
- **UI & Styling:** Custom Design System (`AppTheme`), `SnapKit` / Native SwiftUI Auto Layout, UIKit Haptic Integrations
- **Localization:** Dynamic `LocalizationService` (RU, KK, EN) with live environment triggers

---

## 🛠 Project Structure Overview

```text
GetCourt/
├── App/
│   ├── GetCourtApp.swift          # App Entry Point & Dynamic Color Scheme
│   └── SplashView.swift             # Brand Launch & Auth Routing
├── Core/
│   ├── State/
│   │   └── AppStorageStore.swift    # Global App State & User Preferences
│   ├── Theme/
│   │   └── AppTheme.swift           # Static & Dynamic Color Token Engine
│   └── Localization/
│       └── LocalizationService.swift# KK / RU / EN Dynamic Localizer
├── Features/
│   ├── Home/
│   │   └── HomeDashboardView.swift  # Court Pass, Radar Preview, Quick Actions
│   ├── Catalog/
│   │   ├── CourtCatalogView.swift   # Search, Filter & Date Pickers
│   │   ├── CourtCardView.swift      # Interactive Court Cards
│   │   ├── CourtDetailView.swift    # Amenities, Location & Surface Specs
│   │   └── BookingSheetView.swift   # Slot Selection & Dynamic Pricing Engine
│   ├── Match Radar/
│   │   └── MatchRadarView.swift     # Pulse Radar & Challenge Trigger
│   ├── Profile/
│   │   └── ProfileHubView.swift     # Stats Grid, PRO Badge, Theme/Lang Selectors
│   └── Auth/
│       └── AuthView.swift           # User Onboarding & Authentication Flow

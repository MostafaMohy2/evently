<div align="center">

  <img src="assets/images/logo.png" alt="Evently Logo" width="120" />

  # 🌟 Evently — Event Planning & Management App

  **Discover, organize, and manage events seamlessly with a modern, beautifully crafted Flutter experience.**

  [![Flutter](https://img.shields.io/badge/Flutter-v3.12%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-v3.0%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
  [![State Management](https://img.shields.io/badge/State%20Management-Provider-blue)](https://pub.dev/packages/provider)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)]()
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Screens & User Flow](#-screens--user-flow)
- [Architecture & Folder Structure](#-architecture--folder-structure)
- [Tech Stack & Dependencies](#-tech-stack--dependencies)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Configuration](#firebase-configuration)
  - [Run the App](#run-the-app)
- [Event Categories](#-event-categories)
- [Localization & Theming](#-localization--theming)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

**Evently** is an end-to-end mobile application designed to simplify how people discover, plan, and share events. Whether organizing a birthday party, hosting a book club, scheduling a corporate meeting, or tracking community exhibitions and sports matches, Evently provides an intuitive, responsive, and real-time synchronized platform.

Built with **Flutter** and powered by **Firebase** (Authentication & Cloud Firestore), Evently offers full offline-tolerant preferences, dual-theme styling (Light & Dark), and complete bilingual localization (English & Arabic with native RTL support).

---

## ✨ Key Features

### 🔐 Authentication & Security
- **Email & Password Authentication**: Secure sign-up and sign-in with client-side regex validations (name formatting, email structure, password complexity).
- **Google Sign-In**: Quick, one-tap authentication via OAuth 2.0 with Google credentials.
- **Password Recovery**: Self-service password reset flow directly connected to Firebase Auth.
- **Session Persistence**: Auto-login on app launch with session validation via the Splash screen.

### 📅 Event Management (CRUD)
- **Create Events**: Add new events with titles, detailed descriptions, event dates, times, and thematic categories.
- **Real-Time Feed**: Powered by Cloud Firestore streams for instantaneous updates across devices.
- **Edit & Update**: Update existing event details on the fly.
- **Delete Events**: Remove events with confirmation and instant Firestore synchronization.
- **Rich Event Cards**: Dynamic category badge, formatted date chips, and themed category artwork.

### 💖 Favorites & Search
- **Interactive Liking**: Like and bookmark events with real-time Firestore array updates.
- **Favorites Tab**: Dedicated screen aggregating all saved events.
- **Search & Filtering**: Search events by query or filter by category (All, Birthday, Book Club, Exhibition, Meeting, Sport).

### 🎨 Theming & Personalization
- **Light & Dark Themes**: Deeply customized color palettes tailored for both light and dark visual hierarchy.
- **First-Launch Setup**: Interactive personalized setup screen enabling users to configure theme and language before reaching onboarding.
- **Interactive Onboarding**: Engaging carousel with smooth indicators explaining app capabilities.

### 🌍 Internationalization (i18n)
- **Full Bilingual Support**: Native English (`en`) and Arabic (`ar`) translations.
- **Right-To-Left (RTL)**: Automatic RTL layout flipping when Arabic is selected.
- **Persistent Preferences**: Saves theme and language preferences locally with `shared_preferences`.

---

## 📱 Screens & User Flow

```
Splash Screen
   │
   ├─► Logged In  ──► Home Screen
   │                   ├── Home Tab (Category Filter, Event Cards)
   │                   ├── Favorite Tab (Search & Liked Events)
   │                   └── Profile Tab (Theme & Language Toggles, Sign Out)
   │
   └─► Logged Out ──► Setup Screen (Select Language & Theme)
                        │
                        ▼
                     Onboarding Screen (3-Step Feature Showcase)
                        │
                        ▼
                     Auth Screens (Login / Signup / Forgot Password)
                        │
                        ▼
                     Home Screen ◄──► Event Management (Add / Edit / Details)
```

---

## 🏗️ Architecture & Folder Structure

Evently follows a modular, feature-first structure with clean separation of core configurations, utilities, Firebase data layers, and presentation screens:

```
lib/
├── core/
│   ├── config/              # AppConfig provider (theme & locale state)
│   ├── l10n/                # Localization files & arb templates (app_en.arb, app_ar.arb)
│   ├── models/              # Domain models (Event, Category)
│   ├── theme/               # Theme definitions (AppColors, AppTheme)
│   └── utils/               # AppAssets, Extensions, Validators, DialogUtils
├── firebase/
│   ├── auth_service.dart     # Firebase Auth & Google Sign-In handling
│   └── firebase_database.dart # Cloud Firestore operations (CRUD & Stream subscriptions)
├── screens/
│   ├── auth/                # Login, Signup, Forget Password screens
│   ├── event_management/    # Event Details & Add/Edit Management screens
│   ├── home/                # Home shell with BottomNavigationBar
│   │   └── tabs/            # HomeTab, FavoriteTab, ProfileTab
│   ├── onboarding/          # Onboarding carousel & step models
│   ├── setup/               # Initial theme & language setup screen
│   ├── splahs/              # Splash screen with auto-routing
│   └── widgets/             # Reusable UI widgets (EventCard, CustomTabBar)
├── firebase_options.dart    # Firebase CLI generated platform configuration
└── main.dart                # Application entrypoint & Provider configuration
```

---

## 🛠️ Tech Stack & Dependencies

| Category | Technology | Purpose |
|:---|:---|:---|
| **Framework** | [Flutter](https://flutter.dev) (SDK `^3.12.2`) | Cross-platform UI toolkit |
| **Language** | [Dart](https://dart.dev) | Object-oriented client-optimized language |
| **Backend & Cloud** | [Cloud Firestore](https://pub.dev/packages/cloud_firestore) | NoSQL real-time document database |
| **Authentication** | [Firebase Auth](https://pub.dev/packages/firebase_auth) & [Google Sign-In](https://pub.dev/packages/google_sign_in) | Secure multi-provider authentication |
| **State Management** | [Provider](https://pub.dev/packages/provider) | Reactive dependency injection & state controller |
| **Storage** | [shared_preferences](https://pub.dev/packages/shared_preferences) | Key-value local persistence for settings |
| **Internationalization**| [intl](https://pub.dev/packages/intl) & `flutter_localizations` | Date formatting and multilingual support |
| **UI Enhancements** | [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator) | Animated indicators for onboarding |

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.12.2 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Git](https://git-scm.com/)
- An IDE with Flutter plugins: [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
- [Firebase CLI](https://firebase.google.com/docs/cli) and [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/evently.git
   cd evently
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate localization files:**
   ```bash
   flutter gen-l10n
   ```

### Firebase Configuration

Evently is configured using FlutterFire:

1. **Configure Firebase project:**
   ```bash
   firebase login
   flutterfire configure
   ```
2. Enable **Authentication** in your Firebase Console:
   - Enable **Email/Password** provider.
   - Enable **Google** sign-in provider (add your Android SHA-1 fingerprint if testing on Android).
3. Enable **Cloud Firestore Database** in test or production mode:
   - Add security rules suitable for authenticated users:
     ```javascript
     rules_version = '2';
     service cloud.firestore {
       match /databases/{database}/documents {
         match /events/{eventId} {
           allow read, write: if request.auth != null;
         }
       }
     }
     ```

### Run the App

Start the application on your connected simulator, emulator, or physical device:

```bash
flutter run
```

---

## 🏷️ Event Categories

Each event is classified into one of the curated categories, automatically rendering specialized vector artwork for both Light and Dark themes:

| Category | Arabic | Icon | Light Asset | Dark Asset |
|:---|:---|:---:|:---:|:---:|
| **Birthday** | عيد ميلاد | 🎂 | `Birthday-light.png` | `Birthday_dark.png` |
| **Book Club** | نادي الكتاب | 📖 | `Book Club_light.png` | `Book Club_dark.png` |
| **Exhibition**| معرض | 🏛️ | `Exhibition_light.png` | `Exhibition_dark.png` |
| **Meeting** | اجتماع | 💼 | `Meeting_light.png` | `Meeting_dark.png` |
| **Sport** | رياضة | ⚽ | `Sport_light.png` | `Sport_dakr.png` |

---

## 🌐 Localization & Theming

### Dynamic Theming
Theme preferences are governed by `AppConfig` via `ChangeNotifierProvider` and saved to `SharedPreferences`:
- **Light Theme**: Dominant navy blue accent (`#0E3A99`), soft ice background (`#F4F7FF`), and crisp elevated cards.
- **Dark Theme**: Electric royal blue accent (`#457AED`), deep midnight canvas (`#000F30`), and high-contrast inputs.

### Switching Language & Theme at Runtime
Users can change language and theme dynamically in:
1. **Initial Setup Screen** (upon first install)
2. **Profile Tab** (switch between English/Arabic and Light/Dark mode with instant reactive updates across the entire widget tree)

---

## 🤝 Contributing

Contributions make the open-source community an incredible place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📽️Video Sample


https://github.com/user-attachments/assets/9fa9dbb8-c653-46cd-9c24-c4bcd551d41b

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<div align="center">
  Made with ❤️ using <b>Flutter</b> & <b>Firebase</b>
</div>

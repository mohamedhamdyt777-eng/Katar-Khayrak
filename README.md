# Katar Khayrak — Charity Donation App

A Flutter mobile application that connects donors with trusted charitable organizations in Egypt. Users can browse campaigns, add them to a donation basket, and complete payments through multiple methods.

## Prerequisites

- **Flutter SDK** 3.10 or higher → [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Android Studio** or **VS Code** with the Flutter extension
- An Android emulator or a physical device connected via USB

## How to Run

1. **Clone the repository**
   ```
   git clone https://github.com/mohamedhamdyt777-eng/Katar-Khayrak.git
   cd Katar-Khayrak
   ```

2. **Install dependencies**
   ```
   flutter pub get
   ```

3. **Run the app**
   ```
   flutter run
   ```

## Demo Credentials

| Role         | Email                    | Password      |
|--------------|--------------------------|---------------|
| Donor        | demo@katarkhayrak.com    | Password123   |
| Organization | org@katarkhayrak.com     | Password123   |

## Tech Stack

| Layer              | Technology                          |
|--------------------|-------------------------------------|
| Framework          | Flutter (Dart)                      |
| State Management   | flutter_bloc / Cubit                |
| Navigation         | go_router                           |
| Forms              | reactive_forms                      |
| DI                 | get_it + injectable                 |
| Localization       | flutter_localizations (AR / EN)     |

## Project Structure

```
lib/
├── core/           # Theme, router, utilities, shared widgets
├── features/
│   ├── auth/       # Login, Register, OTP, Forget Password
│   ├── campaign/   # Campaign listing, details, add/edit
│   ├── cart/       # Donation basket
│   ├── donation/   # Payment flow
│   ├── dashboard/  # Donor home screen
│   ├── org_portal/ # Organization dashboard
│   ├── favorites/  # Saved campaigns
│   ├── notifications/
│   └── onboarding/ # Splash, intro, user type selection
```

## Notes

- The app currently runs on **mock data** (no backend required).
- Supports **Arabic and English** localization.
- Tested on Android. No additional setup or API keys needed.

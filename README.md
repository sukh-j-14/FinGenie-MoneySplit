# FinGenie

**FinGenie** is a modern money-splitting and group expense management application built with Flutter. It leverages AI-powered features, OCR for receipt scanning, and a beautiful, intuitive UI to make managing shared expenses effortless for friends, roommates, families, and colleagues.
---

## Features

- **Smart Expense Tracking:**  
  Track your personal and group expenses with ease. The app provides a clear overview of your balances and spending trends.

- **Hassle-free Group Expenses:**  
  Instantly split bills, add group members, and settle up smoothly. Create groups for trips, events, or shared living, and manage contributions transparently.

- **AI-Powered Insights:**  
  Get personalized financial insights and chat with FinGenie, your AI financial assistant, for tips and recommendations.

- **OCR Receipt Scanning:**  
  Snap a photo of your receipt and let the app extract and analyze expenses automatically using Google ML Kit and Gemini AI.

- **Secure & Private:**  
  Your data is encrypted and stored securely. Bank-grade security ensures your financial information is safe.

- **Gamified Personal Finance:**  
  Enjoy interactive, gamified experiences to help you master personal finance.

- **Onboarding & User Profiles:**  
  Smooth onboarding experience with introduction screens. Manage your profile, view your financial stats, and update your information.

---

## Screenshots

*(Add screenshots of the Home, Groups, Activity, Profile, and OCR screens here)*

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 3.5.3 or higher
- Android/iOS device or emulator

### Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd fingenie-main/app/fingenie
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables:**
   - Copy `.env.example` to `.env` and fill in your API keys (e.g., `GEMINI_API_KEY`, `API_URL`).

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## Project Structure

- `lib/main.dart` – App entry point and initialization
- `lib/presentation/` – UI screens (Home, Groups, Activity, Profile, OCR, Onboarding)
- `lib/data/` – Data repositories (authentication, groups, etc.)
- `lib/domain/` – Business logic and models
- `lib/core/` – App configuration, routing, and services
- `assets/` – Images, icons, Lottie animations, and onboarding assets

---

## Key Technologies

- **Flutter** for cross-platform UI
- **Bloc** for state management
- **Hive** for local storage
- **Dio** for networking
- **Google ML Kit** for OCR
- **Google Gemini** for AI-powered receipt analysis
- **Lottie** for engaging animations

---

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## License

MIT License

---

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Google ML Kit](https://developers.google.com/ml-kit)
- [Google Gemini](https://ai.google.dev/gemini-api/docs)
- [Lottie](https://lottiefiles.com/)

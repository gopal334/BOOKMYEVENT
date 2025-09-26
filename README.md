
# BookMyEvent

A brief description of what this project does and who it's for

BookMyEvent 🎟️

![App Screenshot](https://blogger.googleusercontent.com/img/a/AVvXsEje6LQwYaaoOkjXLjZSQEgt_Ex209jII5ErNhZaMm9koXgYfZR0TGtN1LZDJdpWFiUtm4IZGT7-GjT3PdaMuVC99HCVY5FoJgU4J9jA8sU1iz9mq6FvK6s_Pob883ySCqYkuRpKD1JKC9xGAtlGmcV3aaGUhjrl1CQLHgkMrsXCGniOAn4zP6MWoaGuyxKd)

Unlock the Future of Event Booking

Discover, book and experience unforgettable moments effortlessly!

Made with Flutter
Dart
Firebase
Stripe


📱 About BookMyEvent
BookMyEvent is a comprehensive event booking mobile application built with Flutter and Dart. The app provides a seamless experience for users to discover, book, and manage event tickets while offering powerful admin tools for event management.

![App Screenshot](https://blogger.googleusercontent.com/img/a/AVvXsEiOgZtBl68_5l9pt-9ItuD2GjbrsJM1xKofdNBkP0y5ooK3SKkBMw3mts320mL1v_WnCXwsUtSeM8eMJN-1BRo-CrJ_5R3LIA5TGmZ_PHqOv9ad697DfTEE-8FOsjw7kE6ys4mYw-fb5Ko116pYnik207fuQ9EvqKVtIcXiBX_LsVFFj9ci7uCoK63tP8Kv)

✨ Key Features

🎫 Event Discovery & Booking: Browse and book tickets for various events (Music, Festivals, etc.)

💳 Stripe Payment Integration: Secure payment processing with multiple payment methods

🌍 Location Services: GeoLocator integration for location-based event discovery

🔐 Google Sign-In: Easy authentication with Firebase and Google Sign-In

👤 User Profiles: Personalized booking history and profile management

🎭 Event Categories: Music, Clothing, Festival categories for easy browsing

📊 Admin Dashboard: Complete event management and ticket tracking

🏗️ Architecture & Tech Stack
Frontend

Flutter: Cross-platform mobile development framework

Dart: Programming language for Flutter applications

Provider: State management solution for Flutter

Backend & Services

Firebase: Authentication, real-time database, and cloud services

Stripe Payment Gateway: Secure payment processing

GeoLocator: Location services for event discovery

Google Sign-In: OAuth authentication

Key Integrations

🔥 Firebase Authentication

💰 Stripe Payment Gateway
![App Screenshot](https://blogger.googleusercontent.com/img/a/AVvXsEh-PHxOvS3TQkCO6DqYf_nyKIPIAGK35wb3CbXsP8lzK6bq4nIts-nqqnZZrIJEzm-r6ESC4DVCARV689yQs1B2sJSfhJgNjEUOcAx9KnINVDGN1QRyo3WsFr9h0rZ1VM5z8kkKqT3MoXjLSqIFak-0h7oTheqOn5kPSVODvVkuVOB_kZ0kJcxOt0chjMgP)

📍 GeoLocator API

🔑 Google Sign-In API

📸 App Screenshots
User Experience

Event Discovery: Beautiful home screen with event categories and location-based suggestions

Event Details: Comprehensive event information with booking interface

Ticket Booking: Seamless booking process with quantity selection

Payment Processing: Secure Stripe-powered payment with multiple options

Booking Management: Personal booking history and ticket management

Admin Features

Admin Dashboard: Centralized control panel for event management

Event Upload: Easy event creation and management interface

Ticket Analytics: Real-time ticket booking analytics and user management
![App Screenshot](https://blogger.googleusercontent.com/img/a/AVvXsEh_OAq6yX4NvUmR4HIBEkqgc_oVrdZ7I5Uv1vbE57UfpV-tmyEj0v7h1Na-grWowqaMv-eX2-2WaJxXN92NmkfDu4JlJsWvNE_ENzLmxinsA5IOnW38vg46AUXbbhUSyPpV9uDNJp76D6f421W749eo6Na-gu3ELl33OndRdRr3cQ5wK7Fjlw4EkOPZwNJF)

🚀 Getting Started
Prerequisites

Flutter SDK (Latest stable version)

Dart SDK

Android Studio / VS Code with Flutter extensions

Firebase project setup

Stripe account for payment processing

Installation

Clone the repository

bash
git clone https://github.com/gopal334/BookMyEvent.git
cd BookMyEvent
Install dependencies

bash
flutter pub get
Firebase Configuration

Create a new Firebase project

Add your Android/iOS app to the project

Download and add google-services.json (Android) or GoogleService-Info.plist (iOS)

Enable Authentication and Firestore Database

Stripe Configuration

Set up your Stripe account

Add your publishable and secret keys to the configuration

Run the application

bash
flutter run
🎯 App Features Breakdown
For Users

Event Discovery: Location-based event recommendations

Easy Booking: Intuitive booking flow with real-time availability

Secure Payments: Multiple payment options through Stripe

Ticket Management: Digital ticket storage and booking history

Profile Management: Google Sign-In integration for easy access

For Admins

Event Management: Create, edit, and manage events

Ticket Analytics: Track bookings and user engagement

User Management: Monitor user activities and booking patterns

Revenue Tracking: Financial insights and payment analytics

🏛️ App Structure
text
lib/
├── screens/
│   ├── home_screen.dart
│   ├── event_detail_screen.dart
│   ├── booking_screen.dart
│   ├── admin_dashboard.dart
│   └── profile_screen.dart
├── models/
│   ├── event_model.dart
│   ├── user_model.dart
│   └── booking_model.dart
├── services/
│   ├── firebase_service.dart
│   ├── stripe_service.dart
│   ├── location_service.dart
│   └── auth_service.dart
├── providers/
│   ├── event_provider.dart
│   ├── user_provider.dart
│   └── booking_provider.dart
└── widgets/
    ├── event_card.dart
    ├── booking_card.dart
    └── custom_components.dart
🎨 UI/UX Design
The app features a modern, intuitive design with:

Purple-themed UI: Consistent branding with purple gradients

Responsive Design: Optimized for various screen sizes

Smooth Animations: Flutter's animation capabilities for seamless transitions

Intuitive Navigation: Easy-to-use bottom navigation and flow

Accessibility: Design considerations for inclusive user experience

🔧 Configuration
Environment Setup

Create a .env file in the project root:

text
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
FIREBASE_API_KEY=your_firebase_api_key
📱 Supported Platforms
✅ Android (API level 21+)

✅ iOS (iOS 11.0+)

🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

Fork the Project

Create your Feature Branch (git checkout -b feature/AmazingFeature)

Commit your Changes (git commit -m 'Add some AmazingFeature')

Push to the Branch (git push origin feature/AmazingFeature)

Open a Pull Request

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

👨‍💻 Developer
Gopal Singh

GitHub: @gopal334

Instagram: @gopalsengarr

Email: sengargopal310@gmail.com

🙏 Acknowledgments
Flutter team for the amazing framework

Firebase for backend services

Stripe for payment processing

The open-source community for various packages and inspiration



Made with ❤️ using Flutter & Dart

If you found this project helpful, please consider giving it a ⭐


## 🔗 Links
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/gopal334)  
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://instagram.com/gopalsengarr)  
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:sengargopal310@gmail.com)



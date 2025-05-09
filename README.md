# Emergency App 🚨

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://golang.org)

A powerful, cross-platform emergency management app designed to keep you safe and connected in critical moments. With a sleek Flutter frontend and a robust Go backend, this app provides instant access to emergency numbers, personalized emergency contacts, and a one-tap SOS alert system that sends your location to trusted contacts.

## Main Features

### 1. Emergency Numbers Directory 📞
- View a searchable list of important emergency numbers from various countries.
- Tap to call any emergency number directly from the app.

### 2. Emergency Contacts Management 👥
- Add, view, and delete your own emergency contacts.
- Tap to call your saved emergency contacts.

### 3. SOS Alert 🆘
- Send an SOS message (with your current location) to any of your emergency contacts via SMS.
- Automatically fetches your location and includes a Google Maps link in the message.
- Requires SMS and location permissions.

### 4. User Management (Backend) 🔐
- User registration and authentication (including Google OAuth).
- Role-based access control for user data.
- Email verification and password management.

## Backend API Functions

- **/emergency-numbers/**: Get and search global emergency numbers.
- **/emergency-contacts/**: CRUD operations for user emergency contacts.
- **/users/**: User registration, authentication, and management.

## Getting Started

### Prerequisites
- Flutter SDK
- Go (for backend)
- MongoDB (for backend data storage)

### Running the App

1. **Clone the repository**
2. **Install Flutter dependencies**
   ```
   cd emergency_app
   flutter pub get
   ```
3. **Run the Flutter app**
   ```
   flutter run
   ```
4. **(Optional) Run the backend**
   ```
   cd emergency_app_backend
   go run Delivery/main.go
   ```

## Project Structure

- `emergency_app/` - Flutter frontend
  - `lib/screens/` - Main UI screens (Home, Emergency Numbers, Contacts, SOS)
  - `lib/models/` - Data models
  - `lib/utils/` - Utility functions
- `emergency_app_backend/` - Go backend API
  - `Delivery/Controllers/` - API endpoint controllers
  - `Domain/` - Data models and interfaces
  - `Usecases/` - Business logic
  - `Repositories/` - Database access

## Permissions

- Location (for SOS)
- SMS (for sending SOS messages)
- Internet (for API access)

## Future Enhancements

- Real-time emergency alerts and notifications.
- Integration with local emergency services.
- Offline mode for critical features.
- Voice-activated SOS commands.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

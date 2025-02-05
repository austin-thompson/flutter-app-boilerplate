# Flutter Navigation and Authentication Example

This project demonstrates a simple Flutter application with user authentication and navigation functionality. It includes a Flutter frontend, an Express backend, and a PostgreSQL database.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
  - [Frontend Setup](#frontend-setup)
  - [Backend Setup](#backend-setup)
  - [Database Setup](#database-setup)
- [File Structure](#file-structure)
- [Usage](#usage)
- [License](#license)

## Features

- User registration and login functionality.
- Password hashing for security using bcrypt.
- Navigation between Login, Home, and Profile screens.
- Bottom navigation bar with dynamic content.
- Express backend for user authentication.
- PostgreSQL database integration with user data management.

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Node.js and npm](https://js.org/en/download)
- [PostgreSQL](https://www.postgresql.org/download)

## Setup Instructions

### Frontend Setup

1. Navigate to the root project directory containing the Flutter code.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the Flutter app:
   ```bash
   flutter run
   ```

### Backend Setup

1. Navigate to the 'js' directory.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the server:
   ```bash
   node postgresServer.js
   ```
   The backend will run on `http://localhost:3000` by default.

### Database Setup

1. Open a PostgreSQL client (e.g., psql) and connect to your database.
2. Run the provided SQL script in the 'db/' directory to enable 'pgcrpyto', as well as create the required tables, triggers, and sample data.
   ```sql
   -- Execute the SQL script provided in `setup_db.sql` within 'db/' directory
   ```

## File Structure

```
project-root
|
|-- lib/
|   |-- main.dart                 # Entry point of the Flutter application
|   |-- screens/
|       |-- login_screen.dart     # Login and registration screen
|       |-- home_screen.dart      # Home screen with bottom navigation
|
|-- js
|       |-- postgresServer.js     # Express server for user authentication
|-- db
|       |-- setup_db.sql          # PostgreSQL schema and setup script
```

## Usage

1. **Run the Backend**:
   Start the backend server from within the 'js' directory to handle API requests for login and registration.

2. **Run the Frontend**:
   Launch the Flutter application from within the root directory on a connected device or emulator.

3. **Login/Register**:
   Use the app to register a new account and then attempt to log in with said account.

4. **Navigate**:
   After logging in, navigate between Home, Search, and Profile tabs using the bottom navigation bar.

## License

This project is open-source and available under the [MIT License](LICENSE).

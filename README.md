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

- Flutter SDK
- Dart SDK
- Node.js and npm
- PostgreSQL

## Setup Instructions

### Frontend Setup

1. Navigate to the project folder containing the Flutter code.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the Flutter app:
   ```bash
   flutter run
   ```

### Backend Setup

1. Navigate to the backend folder.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the server:
   ```bash
   node server.js
   ```
   The backend will run on `http://localhost:3000` by default.

### Database Setup

1. Open a PostgreSQL client (e.g., psql) and connect to your database.
2. Enable the `pgcrypto` extension for cryptographic functions:
   ```sql
   CREATE EXTENSION IF NOT EXISTS pgcrypto;
   ```
3. Run the provided SQL script to create the required tables, triggers, and sample data.
   ```sql
   -- Execute the SQL script provided in `database.sql`
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
|-- server.js                     # Express server for user authentication
|-- database.sql                  # PostgreSQL schema and setup script
```

## Usage

1. **Run the Backend**:
   Start the backend server to handle API requests for login and registration.

2. **Run the Frontend**:
   Launch the Flutter application on a connected device or emulator.

3. **Login/Register**:
   Use the app to register a new account or log in with existing credentials. Test accounts included in the database:

   - Username: `admin`, Password: `admin`
   - Username: `john_doe`, Password: `password123`
   - Username: `jane_doe`, Password: `qwerty456`

4. **Navigate**:
   After logging in, navigate between Home, Search, and Profile tabs using the bottom navigation bar.

## License

This project is open-source and available under the [MIT License](LICENSE).

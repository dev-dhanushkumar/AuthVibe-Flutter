# AuthVibe-Flutter

AuthVibe is a sleek and modern Flutter application designed for user authentication, featuring seamless sign-in, sign-up, and profile management functionalities. With a clean UI and robust backend integration, AuthVibe provides a secure and user-friendly experience for managing user accounts.

## Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Setup](#setup)
- [Usage](#usage)
- [API Integration](#api-integration)
- [Demo Video](#demo-video)

## Features
- **User Sign-Up**: Register new users with name, email, and password validation.
- **User Sign-In**: Secure login with email and password, retrieving a JWT token.
- **User Dashboard**: Displays user profile details (name, email, role, provider) fetched from a backend API.
- **Responsive UI**: Clean and modern design with SVG assets and Google Fonts.
- **Form Validation**: Client-side validation for email and password fields.
- **Navigation**: Smooth transitions between sign-in, sign-up, and dashboard screens.

## Project Structure
The project follows a modular structure for maintainability and scalability. Below is the key file structure:

```
lib/
├── dashboard.dart    # Dashboard screen displaying user profile
├── main.dart        # Entry point of the application
├── signin.dart      # Sign-in screen with form and API integration
├── signup.dart      # Sign-up screen with form and API integration
└── user.dart        # User model classes for sign-in and sign-up
```

### Key Files
- **`main.dart`**: Initializes the Flutter app and sets the `Signin` screen as the home page.
  ```dart
  void main() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signin(),
    ));
  }
  ```
- **`signin.dart`**: Handles user login with email and password, sending a POST request to the authentication API.
  ```dart
  Future save() async {
    var res = await http.post(
      Uri.parse("http://localhost:8000/api/auth/login"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'email': user.email, 'password': user.password}),
    );
    if (res.statusCode == 200 && res.body.contains("status\":\"success\"")) {
      final token = res.headers['set-cookie']!.split(';').first.split('token=').last;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(token: token)));
    }
  }
  ```
- **`signup.dart`**: Manages user registration with form validation and API integration.
- **`dashboard.dart`**: Fetches and displays user profile data using a GET request with a JWT token.
  ```dart
  Future<void> _fetchProfile() async {
    final res = await http.get(
      Uri.parse("http://localhost:8000/api/users/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $hardToken',
      },
    );
    if (res.statusCode == 200) {
      setState(() {
        userData = json.decode(res.body)['data']['user'];
      });
    }
  }
  ```
- **`user.dart`**: Defines `User` and `SignupUser` classes for data modeling.

## Setup
### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK
- An IDE (e.g., VS Code, Android Studio)
- Backend API running at `http://localhost:8000`

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/dev-dhanushkumar/AuthVibe-Flutter.git
   cd authvibe
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
   Ensure the following dependencies are in your `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     http: ^1.2.0
     flutter_svg: ^2.0.0
     google_fonts: ^6.0.0
   ```
3. **Run the App**:
   ```bash
   flutter run
   ```

### Backend Setup
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/dev-dhanushkumar/OAuth-2.0-Repository.git
   cd quickAuth-nodejs
   ```
2. **Install Dependencies**:
   ```bash
   yarn install
   ```
3. **Start Service**
    ```bash
    yarn start
    ```
**NOTE:** Refer this [`README.md`](https://github.com/dev-dhanushkumar/OAuth-2.0-Repository/blob/main/README.md) file for setup.

Ensure the backend API is running and accessible at `http://localhost:8000`. The app interacts with the following endpoints:
- `POST /api/auth/login`: For user sign-in.
- `POST /api/auth/register`: For user sign-up.
- `GET /api/users/me`: For fetching user profile data.

## Usage
1. **Sign-Up**:
   - Navigate to the sign-up screen.
   - Enter your name, email, password, and confirm password.
   - Submit the form to register and redirect to the sign-in screen.
2. **Sign-In**:
   - Enter your email and password.
   - On successful login, the app retrieves a JWT token and navigates to the dashboard.
3. **Dashboard**:
   - View your profile details, including name, email, role, and provider.
   - The dashboard fetches data using the JWT token (note: currently hardcoded in `dashboard.dart`).

### Example Flow
1. Launch the app to see the sign-in screen.
2. Click "SignUp" to register a new account.
3. After signing up, return to the sign-in screen and log in.
4. View your profile on the dashboard.

## API Integration
The app uses the `http` package to communicate with the backend. Key considerations:
- **Sign-In**: Sends a POST request with email and password, expecting a `set-cookie` header with a JWT token.
- **Sign-Up**: Sends a POST request with name, email, password, and password confirmation.
- **Profile Fetch**: Uses a GET request with the JWT token in the `Authorization` header.

**Note**: The `dashboard.dart` currently uses a hardcoded token. Update it to use the dynamic token passed from `signin.dart`:
```dart
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${widget.token}',
}
```

## Demo Video

https://github.com/user-attachments/assets/0ae871fb-f818-4788-9726-82bc864f3bb0


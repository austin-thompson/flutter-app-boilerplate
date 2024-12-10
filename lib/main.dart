import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Main app widget that sets up the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Start with the login screen.
    );
  }
}

// The login screen where users must log in to access the rest of the app.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Hardcoded credentials for login.
  final String correctUsername = 'test';
  final String correctPassword = 'test';

  // Controllers to capture user input.
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variable to toggle password visibility.
  bool _isPasswordHidden = true;

  // Function to handle the login logic.
  void _handleLogin() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username == correctUsername && password == correctPassword) {
      // If login is successful, navigate to the HomeScreen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(username: username)),
      );
    } else {
      // Show an error message if credentials are incorrect.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Username input field with autofocus enabled.
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              autofocus: true, // This pulls up the keyboard by default.
            ),
            // Password input field with toggleable visibility.
            TextField(
              controller: passwordController,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // Login button.
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// The main screen shown after a successful login.
class HomeScreen extends StatefulWidget {
  final String username; // Stores the logged-in user's username.

  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of widgets for each tab.
  List<Widget> get _widgetOptions => [
        Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
        Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
        _buildProfilePage(),
      ];

  // Handles navigation bar item taps.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Builds the Profile page with user info.
  Widget _buildProfilePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome, ${widget.username}!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account Settings'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Log out and navigate back to the login screen.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Bar Example'),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

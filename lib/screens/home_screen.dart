// home_screen.dart

// Importing necessary Flutter package and the LoginScreen widget.
import 'package:flutter/material.dart';
import 'login_screen.dart';

// StatefulWidget representing the HomeScreen after a successful login.
class HomeScreen extends StatefulWidget {
  // Username of the logged-in user, passed from the login screen.
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// State class for HomeScreen to handle dynamic content and user interactions.
class _HomeScreenState extends State<HomeScreen> {
  // Index of the currently selected tab in the BottomNavigationBar.
  int _selectedIndex = 0;

  // List of widgets displayed for each tab in the BottomNavigationBar.
  List<Widget> get _widgetOptions => [
        Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
        Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
        _buildProfilePage(),
      ];

  // Updates the selected tab index when a tab is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Builds the Profile page widget, including user information and actions.
  Widget _buildProfilePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds uniform padding.
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers content vertically.
        children: [
          // Displays a welcome message with the user's username.
          Text(
            'Welcome, ${widget.username}!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20), // Adds spacing between elements.

          // ListTile for account settings.
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account Settings'),
            onTap: () {
              // Handle tap on Account Settings.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account Settings tapped!')),
              );
            },
          ),

          // ListTile for notifications.
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle tap on Notifications.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications tapped!')),
              );
            },
          ),

          // ListTile for privacy settings.
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            onTap: () {
              // Handle tap on Privacy.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Privacy tapped!')),
              );
            },
          ),

          SizedBox(height: 20), // Adds spacing before the logout button.

          // ElevatedButton for logging out of the app.
          ElevatedButton(
            onPressed: () {
              // Navigates back to the LoginScreen and shows a logout confirmation.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully!'),
                  backgroundColor:
                      Colors.blue, // Blue background for info message.
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
      // AppBar with the title for the HomeScreen.
      appBar: AppBar(
        title: Text('Flutter App Boilerplate'),
      ),

      // Body displays the content of the selected tab.
      body: _widgetOptions[_selectedIndex],

      // BottomNavigationBar for navigating between tabs.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex, // Highlights the selected tab.
        selectedItemColor:
            Colors.blue, // Color for the selected tab icon and label.
        onTap: _onItemTapped, // Callback for handling tab selection.
      ),
    );
  }
}

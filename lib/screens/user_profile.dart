import 'package:flutter/material.dart';
import './first_page.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'User Profile',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Stack(children: [Text("")]),
            ],
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 210, 102, 186),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromARGB(255, 210, 102, 186),
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'sachin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            /*const Text(
              '@gmail.com',
              style: TextStyle(
                fontSize: 18,
              ),
            ),*/
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add functionality to navigate to settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: const Text('Settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add functionality to log out
                // For example:
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _receiveNotifications = true;

  void _showChangePasswordDialog() {
    TextEditingController newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: TextField(
            controller: newPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'New Password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newPassword = newPasswordController.text;
                print(newPassword);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Perform logout action (e.g., clear user session, navigate to login screen)
    // Example:
    // Clear user session (replace this with your actual implementation)
    clearUserSession();

    // Navigate to login screen (replace this with your actual implementation)
    navigateToLoginScreen();
  }

  void clearUserSession() {
    // Your code to clear user session (e.g., clear authentication tokens, clear local storage)
    // Example:
    // Clear authentication tokens
    // authService.clearTokens();
  }

  void navigateToLoginScreen() {
    // Your code to navigate to the login screen
    // Example:
    // Navigate to the login screen using Navigator
    // Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Receive Notifications'),
              value: _receiveNotifications,
              onChanged: (bool value) {
                setState(() {
                  _receiveNotifications = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Privacy Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Change Password'),
              onTap: _showChangePasswordDialog,
            ),
            ListTile(
              title: const Text('Delete Account'),
              onTap: _showDeleteAccountDialog,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Add logout functionality here
                // Example:
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstScreen()));

              },
            ),
          ],
        ),
      ),
    );
  }
}

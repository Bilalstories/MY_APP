// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:my_app/widgets/profile_picture_picker.dart';
import 'package:my_app/widgets/general_profile_form.dart';
import 'package:my_app/widgets/digital_profile_form.dart';
import 'package:my_app/data/states_districts.dart'; // New file

// Assuming you have a ThemeProvider to manage app themes
// If not, you'll need to create one.
// Example:
// class ThemeProvider with ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;
//   ThemeMode get themeMode => _themeMode;
//   void setThemeMode(ThemeMode mode) {
//     _themeMode = mode;
//     notifyListeners();
//   }
// }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // A function to get the current theme mode
    final ThemeMode currentThemeMode = Theme.of(context).brightness == Brightness.dark 
      ? ThemeMode.dark 
      : ThemeMode.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue.shade800,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image and Name
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.person, size: 60, color: Colors.blue.shade800),
                ),
                const SizedBox(height: 12),
                const Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'user.email@example.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Theme Options
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'App Theme',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildThemeButton(
                        context,
                        'Day',
                        Icons.wb_sunny_rounded,
                        ThemeMode.light,
                        currentThemeMode,
                      ),
                      _buildThemeButton(
                        context,
                        'Night',
                        Icons.nights_stay_rounded,
                        ThemeMode.dark,
                        currentThemeMode,
                      ),
                      _buildThemeButton(
                        context,
                        'System',
                        Icons.smartphone_rounded,
                        ThemeMode.system,
                        currentThemeMode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Form
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Handle form submission
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode mode,
    ThemeMode currentMode,
  ) {
    // A placeholder function to change the theme.
    // In a real app, you would use a state management solution like Provider.
    void changeTheme(ThemeMode newMode) {
      if (newMode != currentMode) {
        // Here you would call a method in your ThemeProvider
        // For example:
        // Provider.of<ThemeProvider>(context, listen: false).setThemeMode(newMode);
      }
    }

    final bool isSelected = mode == currentMode;
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => changeTheme(mode),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: isSelected ? Colors.blue.shade800 : Colors.grey.shade200,
            foregroundColor: isSelected ? Colors.white : Colors.blue.shade800,
            elevation: 0,
          ),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color)),
      ],
    );
  }
}
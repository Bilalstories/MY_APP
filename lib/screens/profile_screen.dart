import 'package:flutter/material.dart';
import 'package:my_app/widgets/profile_picture_picker.dart';
import 'package:my_app/widgets/general_profile_form.dart';
import 'package:my_app/widgets/digital_profile_form.dart';
import 'package:my_app/data/states_districts.dart'; // New file

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedProfileType = 'General';
  double _completionPercentage = 0.0;
  List<String> _pendingFields = [];

  void _updateCompletionStatus() {
    // This is a placeholder for real logic
    // You'll need to check the form fields and update this list and percentage
    setState(() {
      _pendingFields = [
        'State',
        'District',
        'PAN Number', // Example pending field
      ];
      _completionPercentage = 50.0; // Example
    });
  }

  void _showCompletionDetails() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Profile Completion Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your profile is ${_completionPercentage.toInt()}% complete.'),
            const SizedBox(height: 10),
            const Text(
              'Pending items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ..._pendingFields.map((field) => Text('• $field')).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ProfilePicturePicker(),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showCompletionDetails,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: _completionPercentage / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      strokeWidth: 6.0,
                    ),
                  ),
                  Text(
                    '${_completionPercentage.toInt()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedProfileType = 'General';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedProfileType == 'General' ? Theme.of(context).primaryColor : Colors.grey[200],
                    foregroundColor: _selectedProfileType == 'General' ? Colors.white : Colors.black,
                  ),
                  child: const Text('General'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedProfileType = 'Digital';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedProfileType == 'Digital' ? Theme.of(context).primaryColor : Colors.grey[200],
                    foregroundColor: _selectedProfileType == 'Digital' ? Colors.white : Colors.black,
                  ),
                  child: const Text('Digital'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedProfileType == 'General')
              GeneralProfileForm(onUpdate: _updateCompletionStatus)
            else
              DigitalProfileForm(onUpdate: _updateCompletionStatus),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet_outlined),
              title: const Text('Wallet'),
              onTap: () {
                // Navigate to Wallet screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change Password'),
              onTap: () {
                // Handle change password
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
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

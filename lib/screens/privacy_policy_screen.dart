import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'This app follows Google Play policies. Your data is safe and not shared with third parties. For more info, contact: 1gmscsc@gmail.com',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms & Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'By using this app, you agree to all terms and conditions. For any queries, contact: 1gmscsc@gmail.com',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

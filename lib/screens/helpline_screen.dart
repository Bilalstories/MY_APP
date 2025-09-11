import 'package:flutter/material.dart';

class HelplineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Helpline')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Helpline Number:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SelectableText('7276263372', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Email:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SelectableText('1gmscsc@gmail.com', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

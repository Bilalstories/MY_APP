// lib/screens/services_screen.dart

import 'package:flutter/material.dart';
import '../models/category.dart';
import 'service_form_screen.dart';

class ServicesScreen extends StatelessWidget {
  final Category category;

  const ServicesScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.blue.shade800,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: category.services.length,
        itemBuilder: (ctx, i) {
          final s = category.services[i];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                Icons.description,
                color: Colors.blue.shade800,
              ),
              title: Text(
                s.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Fee ₹${s.price.toStringAsFixed(0)}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              trailing: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => ServiceFormScreen(service: s),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ),
          );
        },
      ),
    );
  }
}
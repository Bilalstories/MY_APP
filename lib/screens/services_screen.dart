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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: category.services.length,
        itemBuilder: (ctx, i) {
          final s = category.services[i];
          return Card(
            child: ListTile(
              title: Text(s.name),
              subtitle: Text('Fee ₹${s.price.toStringAsFixed(0)}'),
              trailing: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => ServiceFormScreen(service: s),
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
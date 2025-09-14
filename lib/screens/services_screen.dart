// lib/screens/services_screen.dart

import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/screens/service_form_screen.dart';

class ServicesScreen extends StatelessWidget {
  final Category category;

  const ServicesScreen({Key? key, required this.category}) : super(key: key);

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
        itemCount: category.services.length,
        itemBuilder: (ctx, index) {
          final service = category.services[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(service.name),
              subtitle: Text('Price: ₹${service.price}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to the ServiceFormScreen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ServiceFormScreen(service: service),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import 'package:my_app/screens/service_form_screen.dart';
import 'package:my_app/screens/services_screen.dart';
import 'service_form_screen.dart';

class ServicesScreen extends StatelessWidget {
  final String category;
  final List<Service> services;

  const ServicesScreen({
    Key? key,
    required this.category,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ListTile(
            title: Text(service.name),
            trailing: Text('₹${service.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
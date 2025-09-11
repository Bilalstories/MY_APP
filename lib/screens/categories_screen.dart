import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/categories.dart';
import '../models/category.dart';
import 'package:my_app/data/categories.dart';
import 'package:my_app/screens/services_screen.dart';
import 'service_form_screen.dart';
import 'services_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ListTile(
            leading: Icon(Icons.category),
            title: Text(cat.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServicesScreen(
                    category: cat.name,
                    services: cat.services, // Fixed: List<Service> passed correctly
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

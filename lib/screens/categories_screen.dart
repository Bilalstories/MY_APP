import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/categories.dart';
import '../models/category.dart';
import 'package:my_app/data/categories.dart';
import 'service_form_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Categories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.95,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ServicesScreen(category: category),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (category.iconUrl.isEmpty)
                    const Icon(Icons.category, size: 48)
                  else if (category.iconUrl.startsWith('http'))
                    Image.network(
                      category.iconUrl,
                      height: 48,
                      width: 48,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.category, size: 48),
                    )
                  else
                    Image.asset(
                      'assets/${category.iconUrl}',
                      height: 48,
                      width: 48,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.category, size: 48),
                    ),
                  const SizedBox(height: 12),
                  Text(category.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

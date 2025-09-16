import 'package:my_app/screens/services_screen.dart';
import 'package:flutter/material.dart';
import '../data/categories.dart';
import 'services_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData getIconData(String name) {
      switch (name) {
        case 'fingerprint':
          return Icons.fingerprint;
        case 'credit_card':
          return Icons.credit_card;
        case 'local_grocery_store':
          return Icons.local_grocery_store;
        case 'map':
          return Icons.map;
        case 'how_to_vote':
          return Icons.how_to_vote;
        default:
          return Icons.category;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final category = categories[i];
          
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => ServicesScreen(category: category),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.category, size: 50, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
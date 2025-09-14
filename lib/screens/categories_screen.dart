import 'package:my_app/screens/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories;

  const CategoriesScreen({
    Key? key,
    required this.categories,
  }) : super(key: key);

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
      appBar: AppBar(
        title: const Text('All Services'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.9,
        ),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final category = categories[i];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) => ServicesScreen(category: category),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    getIconData(category.iconUrl),
                    size: 30,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
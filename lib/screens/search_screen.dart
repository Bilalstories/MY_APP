// lib/screens/search_screen.dart

import 'package:flutter/material.dart';
import 'package:my_app/data/app_data.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/screens/services_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Category> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = allCategories.where((category) {
        final categoryName = category.name.toLowerCase();
        return categoryName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for services...',
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
      ),
      body: _searchController.text.isEmpty
          ? const Center(
              child: Text("Start typing to search for services..."),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final category = _searchResults[index];
                return ListTile(
                  leading: Icon(category.iconData),
                  title: Text(category.name),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ServicesScreen(category: category),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:my_app/data/app_data.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:my_app/screens/categories_screen.dart';
import 'package:my_app/screens/services_screen.dart';
import 'package:my_app/screens/search_screen.dart';
import 'package:my_app/screens/tracking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatefulWidget {
  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SearchScreen()),
                );
              },
              child: IgnorePointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search for services...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildImageSlider(),
          const SizedBox(height: 20),
          _buildSectionHeader(context, "Quick Services"),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quickServices.length,
              itemBuilder: (ctx, index) {
                final category = quickServices[index];
                return _buildQuickServiceCard(context, category);
              },
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(context, "All Categories", isViewAllButton: true),
          const SizedBox(height: 20),
          _buildTrackSection(context),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: promotionImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                promotionImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {bool isViewAllButton = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isViewAllButton)
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CategoriesScreen(
                      categories: allCategories,
                      isGridView: true,
                    ),
                  ),
                );
              },
              child: const Text("View All"),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickServiceCard(BuildContext context, Category category) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ServicesScreen(category: category),
            ),
          );
        },
        child: Container(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.iconData,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TrackingScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: const [
                Icon(Icons.location_on, size: 50, color: Colors.blue),
                SizedBox(height: 10),
                Text(
                  "Track Your Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Track the status of your application (Aadhar, PAN, etc.)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
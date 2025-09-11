import 'package:flutter/material.dart';
import '../widgets/carousel_slider.dart';
import '../data/categories.dart';
import 'categories_screen.dart' show CategoriesScreen;
import 'banks_screen.dart';
import 'schemes_screen.dart';
import 'services_screen.dart' show ServicesScreen;
import 'profile_screen.dart';
import '../widgets/onboarding_tips.dart';
import 'tracking_screen.dart';

/// 🔍 Search Delegate
class AppSearchDelegate extends SearchDelegate<String> {
  final List<String> allItems = [
    'Categories',
    'Banks',
    'Schemes',
    ...categories.map((c) => c.name),
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            if (item == 'Categories') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CategoriesScreen()));
            } else if (item == 'Banks') {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const BanksScreen()));
            } else if (item == 'Schemes') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SchemesScreen()));
            } else {
              final cat = categories.firstWhere(
                  (c) => c.name.toLowerCase() == item.toLowerCase(),
                  orElse: () => categories.first);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ServicesScreen(category: cat)));
            }
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

/// 🏠 Home Screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeContent(), // main home content
    const CategoriesScreen(),
    const BanksScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category_rounded),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_outlined),
              activeIcon: Icon(Icons.account_balance_rounded),
              label: 'Banks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Home content (your original HomeScreen body)
class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Services App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AppSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => OnboardingTips(
                        onFinish: () => Navigator.pop(c)))),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => const TrackingScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            CarouselSlider(imagePaths: [
              'assets/sample_image.png',
              'assets/slide1.png',
              'assets/slide2.png',
              'assets/slide3.png',
            ]),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quick Actions',
                      style: Theme.of(context).textTheme.titleLarge),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const CategoriesScreen()));
                    },
                    child: const Text('All Categories'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Quick action cards row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _buildQuickCard(
                      context, Icons.category, "Categories", const CategoriesScreen()),
                  const SizedBox(width: 12),
                  _buildQuickCard(context, Icons.account_balance, "Banks",
                      const BanksScreen()),
                  const SizedBox(width: 12),
                  _buildQuickCard(
                      context, Icons.savings, "Schemes", const SchemesScreen()),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _buildQuickCard(
                      context,
                      Icons.tour,
                      "Take a tour",
                      OnboardingTips(onFinish: () => Navigator.pop(context))),
                  const SizedBox(width: 12),
                  _buildQuickCard(context, Icons.track_changes, "Track",
                      const TrackingScreen()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Popular Categories',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ServicesScreen(category: c))),
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (c.iconUrl.isEmpty)
                                const Icon(Icons.category, size: 48)
                              else if (c.iconUrl.startsWith('http'))
                                Image.network(c.iconUrl,
                                    height: 48,
                                    width: 48,
                                    errorBuilder: (a, b, c) =>
                                        const Icon(Icons.category))
                              else
                                Image.asset('assets/${c.iconUrl}',
                                    height: 48,
                                    width: 48,
                                    errorBuilder: (a, b, c) =>
                                        const Icon(Icons.category)),
                              const SizedBox(height: 8),
                              Text(c.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickCard(
      BuildContext context, IconData icon, String label, Widget page) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (c) => page)),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(icon, size: 36, color: Colors.deepPurple),
                const SizedBox(height: 8),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

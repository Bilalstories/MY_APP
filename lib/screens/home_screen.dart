// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/screens/services_screen.dart';
import 'package:my_app/models/category.dart';

class HomeScreen extends StatefulWidget {
  // We'll pass the logged-in user's name/number here
  final String userNameOrNumber;

  const HomeScreen({Key? key, required this.userNameOrNumber}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> adImages = [
    'https://via.placeholder.com/600x250/FF5733/FFFFFF?text=Ad+1',
    'https://via.placeholder.com/600x250/C70039/FFFFFF?text=Ad+2',
    'https://via.placeholder.com/600x250/900C3F/FFFFFF?text=Ad+3',
  ];

  final List<Category> allCategories = [
    Category(
      name: 'Aadhaar',
      iconUrl: 'fingerprint',
      services: [
        Service(name: 'Aadhaar Update', price: 200),
        Service(name: 'New Aadhaar Card', price: 500),
      ],
    ),
    Category(
      name: 'PAN',
      iconUrl: 'credit_card',
      services: [
        Service(name: 'New PAN Card', price: 150),
        Service(name: 'PAN Correction', price: 100),
      ],
    ),
    Category(
      name: 'Ration',
      iconUrl: 'local_grocery_store',
      services: [
        Service(name: 'Ration Card Application', price: 180),
      ],
    ),
    Category(
      name: 'Land',
      iconUrl: 'map',
      services: [
        Service(name: 'Land Record Check', price: 300),
      ],
    ),
  ];

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
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Government_of_India_logo.svg/1200px-Government_of_India_logo.svg.png',
          height: 30,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.blue.shade800),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.blue.shade800),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search Bar with Mic
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for "EPFO"',
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    suffixIcon: Icon(Icons.mic, color: Colors.blue.shade800),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
            
            // User Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Hey, ${widget.userNameOrNumber}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Carousel Slider with Ads
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
              ),
              items: adImages.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            
            // Quick Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Quick Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.9,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: allCategories.length,
              itemBuilder: (context, index) {
                final category = allCategories[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ServicesScreen(category: category),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1), // Placeholder color
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          getIconData(category.iconUrl),
                          size: 30,
                          color: Colors.blue.shade800, // Placeholder color
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        category.name,
                        style: TextStyle(
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
            
            // Biometric Section
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable Biometric Login\nfor Faster, Safer Access',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Log in securely with your fingerprint',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              // Implement biometric activation logic
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue.shade800),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Activate Biometrics',
                              style: TextStyle(color: Colors.blue.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://via.placeholder.com/150', // Replace with a relevant image
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
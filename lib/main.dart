// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/tracking_screen.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:my_app/theme_provider.dart'; // <-- यह लाइन ज़रूरी है

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(), // <-- MyApp को Provider से रैप किया गया है
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/track': (context) => const TrackingScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
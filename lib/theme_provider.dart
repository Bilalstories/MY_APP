import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enum for theme options
enum AppThemeMode { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.system;

  // Getter for AppThemeMode
  AppThemeMode get themeMode => _themeMode;

  // Convert to Material's ThemeMode
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  ThemeProvider() {
    _loadTheme();
  }

  // Change theme
  void setTheme(AppThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme_mode', mode.index);
  }

  // Load saved theme
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = AppThemeMode.values[prefs.getInt('theme_mode') ?? 2];
    notifyListeners();
  }
}

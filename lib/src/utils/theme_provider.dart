import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);

class ThemeViewModel extends StateNotifier<ThemeData> {
  ThemeViewModel() : super(_loadTheme());

  static ThemeData _loadTheme() {
    // Retrieve the theme from Hive
    final box = Hive.box('settings');
    final isDarkMode = box.get('isDarkMode', defaultValue: false);
    return isDarkMode ? darkTheme : lightTheme;
  }

  void toggleTheme() {
    final box = Hive.box('settings');
    if (state == lightTheme) {
      state = darkTheme;
      box.put('isDarkMode', true);
    } else {
      state = lightTheme;
      box.put('isDarkMode', false);
    }
  }
}

// Create a provider for the theme
final themeProvider = StateNotifierProvider<ThemeViewModel, ThemeData>(
      (ref) => ThemeViewModel(),
);

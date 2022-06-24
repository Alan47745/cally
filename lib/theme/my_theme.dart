import 'package:cally/model/cacheHelper.dart';
import 'package:cally/utils/constant.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = CacheHelper.getData(key: 'theme') == true
      ? ThemeMode.dark
      : ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    themeMode = isDark == true ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple[700],
    ),
    fontFamily: 'Poppins Regular',
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: const ColorScheme.dark(),
    primaryColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey[800],
    ),
    cardColor: Colors.grey[800],
  );
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaryPurple,
    ),
    fontFamily: 'Poppins Regular',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: Colors.grey[900],
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1.0,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
    ),
    cardColor: Colors.grey[200],
  );
}

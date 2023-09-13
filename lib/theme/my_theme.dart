import 'package:cally/model/cacheHelper.dart';
import 'package:cally/utils/constant.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = CacheHelper.getData(key: 'theme') == true
      ? ThemeMode.dark
      : ThemeMode.light;
  bool isDirectionRtl =
      CacheHelper.getData(key: 'languageCode') == 'ar' ? true : false;
  String font = CacheHelper.getData(key: 'languageCode') == 'ar'
      ? 'Tajawal'
      : 'Poppins Regular';

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    themeMode = isDark == true ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleDrawerDirection(bool isRtl) {
    isDirectionRtl = isRtl == true ? true : false;
    notifyListeners();
  }

  void toggleFontFamily(String fontFamily) {
    font = fontFamily == 'Tajawal' ? 'Tajawal' : 'Poppins Regular';
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryPurple,
    ),
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
      backgroundColor: Colors.deepPurple[700],
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: Colors.grey[900],
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1.0,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Colors.white,
    ),
    cardColor: Colors.grey[200],
  );
}

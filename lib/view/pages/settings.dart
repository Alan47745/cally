// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cally/localization/localization.dart';
import 'package:cally/main.dart';
import 'package:cally/utils/custom_icons_icons.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  String? languageCode;
  String? countryCode;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Helvetica New Bold',
          fontSize: 18.0,
        ),
        title: Row(
          children: [
            const Icon(
              CustomIcons.settings,
              size: 20.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              '${AppLocalization.of(context)?.getTranslatedValue('settings')}',
            ),
          ],
        ),
        backgroundColor: themeProvider.isDarkMode == true
            ? MyTheme.darkTheme.appBarTheme.backgroundColor
            : MyTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: themeProvider.isDarkMode == true
                          ? MyTheme.darkTheme.cardColor
                          : MyTheme.lightTheme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        // height: 150.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  MyApp.setLocale(
                                      context, const Locale('ar', 'SA'));

                                  languageCode = 'ar';
                                  countryCode = 'SA';
                                  CacheHelper.saveData(
                                      key: 'languageCode', value: languageCode);
                                  CacheHelper.saveData(
                                      key: 'countryCode', value: countryCode);
                                });
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                  '${AppLocalization.of(context)?.getTranslatedValue('arabic')}',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.primaryColor
                                        : MyTheme.lightTheme.primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/img/arabic_flag.svg',
                                  alignment: Alignment.center,
                                  height: 28.0,
                                  width: 28.0,
                                ),
                              ),
                            ),
                            Divider(
                              color: themeProvider.isDarkMode == true
                                  ? Colors.grey[600]
                                  : MyTheme.lightTheme.primaryColor,
                              indent: 30.0,
                              endIndent: 30.0,
                            ),
                            MaterialButton(
                              // shape: const RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.only(
                              //     bottomLeft: Radius.circular(20.0),
                              //     bottomRight: Radius.circular(20.0),
                              //   ),
                              // ),
                              onPressed: () {
                                setState(() {
                                  MyApp.setLocale(
                                      context, const Locale('en', 'US'));

                                  languageCode = 'en';
                                  countryCode = 'US';
                                  CacheHelper.saveData(
                                      key: 'languageCode', value: languageCode);
                                  CacheHelper.saveData(
                                      key: 'countryCode', value: countryCode);
                                });
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                  '${AppLocalization.of(context)?.getTranslatedValue('english')}',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.primaryColor
                                        : MyTheme.lightTheme.primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/img/english_flag.svg',
                                  alignment: Alignment.center,
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            Divider(
                              color: themeProvider.isDarkMode == true
                                  ? Colors.grey[600]
                                  : MyTheme.lightTheme.primaryColor,
                              indent: 30.0,
                              endIndent: 30.0,
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  MyApp.setLocale(
                                      context, const Locale('fr', 'FR'));

                                  languageCode = 'fr';
                                  countryCode = 'FR';
                                  CacheHelper.saveData(
                                      key: 'languageCode', value: languageCode);
                                  CacheHelper.saveData(
                                      key: 'countryCode', value: countryCode);
                                });
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                  '${AppLocalization.of(context)?.getTranslatedValue('french')}',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.primaryColor
                                        : MyTheme.lightTheme.primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/img/french_flag.svg',
                                  alignment: Alignment.center,
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                title: Text(
                  '${AppLocalization.of(context)?.getTranslatedValue('lang')}',
                  style: TextStyle(
                    color: themeProvider.isDarkMode == true
                        ? MyTheme.darkTheme.primaryColor
                        : MyTheme.lightTheme.primaryColor,
                    fontSize: 16.0,
                  ),
                ),
                leading: Icon(
                  Icons.language,
                  color: themeProvider.isDarkMode == true
                      ? MyTheme.darkTheme.primaryColor
                      : MyTheme.lightTheme.primaryColor,
                  size: 23.0,
                ),
              ),
            ),
            Divider(
              color: themeProvider.isDarkMode == true
                  ? MyTheme.darkTheme.cardColor
                  : MyTheme.lightTheme.cardColor,
              indent: 30.0,
              endIndent: 30.0,
            ),
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: themeProvider.isDarkMode == true
                          ? MyTheme.darkTheme.cardColor
                          : MyTheme.lightTheme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                themeProvider.toggleTheme(false);
                                CacheHelper.saveData(
                                    key: 'theme', value: false);
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                  '${AppLocalization.of(context)?.getTranslatedValue('lightMode')}',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.primaryColor
                                        : MyTheme.lightTheme.primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.sunny,
                                  color: Colors.amber,
                                  size: 23.0,
                                ),
                              ),
                            ),
                            Divider(
                              color: themeProvider.isDarkMode == true
                                  ? Colors.grey[600]
                                  : MyTheme.lightTheme.primaryColor,
                              indent: 30.0,
                              endIndent: 30.0,
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                themeProvider.toggleTheme(true);
                                CacheHelper.saveData(key: 'theme', value: true);
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                  '${AppLocalization.of(context)?.getTranslatedValue('darkMode')}',
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.primaryColor
                                        : MyTheme.lightTheme.primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.nightlight_round,
                                  color: themeProvider.isDarkMode == true
                                      ? MyTheme.darkTheme.primaryColor
                                      : MyTheme.lightTheme.primaryColor,
                                  size: 23.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                title: Text(
                  '${AppLocalization.of(context)?.getTranslatedValue('themeMode')}',
                  style: TextStyle(
                    color: themeProvider.isDarkMode == true
                        ? MyTheme.darkTheme.primaryColor
                        : MyTheme.lightTheme.primaryColor,
                    fontSize: 16.0,
                  ),
                ),
                leading: Icon(
                  Icons.brush,
                  color: themeProvider.isDarkMode == true
                      ? MyTheme.darkTheme.primaryColor
                      : MyTheme.lightTheme.primaryColor,
                  size: 23.0,
                ),
              ),
            ),
            // Divider(
            //   color: themeProvider.isDarkMode == true
            //       ? MyTheme.darkTheme.cardColor
            //       : MyTheme.lightTheme.cardColor,
            //   indent: 30.0,
            //   endIndent: 30.0,
            // ),
          ],
        ),
      ),
    );
  }
}

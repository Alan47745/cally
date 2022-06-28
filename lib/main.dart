// ignore_for_file: use_key_in_widget_constructors, unused_field, avoid_print, must_be_immutable, unnecessary_null_comparison

import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/view/pages/splash.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );

  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: CacheHelper.getData(key: 'theme') == null
              ? ThemeMode.light
              : themeProvider.themeMode,
          darkTheme: MyTheme.darkTheme,
          theme: MyTheme.lightTheme,
          home: const Splash(),
          locale: _locale,
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('ar', 'SA'),
            const Locale('fr', 'FR'),
            Locale(
              "${CacheHelper.getData(key: 'languageCode')}",
              "${CacheHelper.getData(key: 'countryCode')}",
            ),
          ],
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (CacheHelper.getData(key: 'languageCode') == null) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale?.languageCode &&
                    locale.countryCode == deviceLocale?.countryCode) {
                  return deviceLocale;
                }
              }
            } else {
              return supportedLocales.elementAt(3);
            }

            return supportedLocales.elementAt(0);
          },
        );
      },
    );
  }
}

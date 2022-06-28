import 'package:cally/main.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/model/language.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/view/pages/drawer.dart';
import 'package:cally/view/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static bool isRtl = false;

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final ZoomDrawerController z = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: ZoomDrawer(
        mainScreenOverlayColor: Colors.grey.withOpacity(0.3),
        menuBackgroundColor: themeProvider.isDarkMode == true
            ? MyTheme.darkTheme.appBarTheme.backgroundColor!
            : MyTheme.lightTheme.appBarTheme.backgroundColor!,
        mainScreenTapClose: true,
        isRtl: themeProvider.isDirectionRtl,
        controller: z,
        menuScreen: DrawerPage(),
        mainScreen: MainPage(),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.grey.shade300,
        slideWidth: MediaQuery.of(context).size.width * 0.70,
        closeCurve: Curves.fastOutSlowIn,
        openCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}

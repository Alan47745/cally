import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/utils/custom_icons_icons.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/contacts.dart';
import 'package:cally/view/pages/call.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/view/pages/recent.dart';
import 'package:cally/view/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      Recent(),
      Contacts(),
      Call(),
      Settings(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          contentPadding: 0.0,
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(CustomIcons.recent),
          ),
          title:
              ('${AppLocalization.of(context)?.getTranslatedValue('recent')}'),
          textStyle: TextStyle(
            fontFamily: themeProvider.font,
          ),
          activeColorPrimary: primaryPurple,
          inactiveColorPrimary: CupertinoColors.systemGrey4,
          iconSize: 22.0,
        ),
        PersistentBottomNavBarItem(
          contentPadding: 5.0,
          icon: const Icon(CustomIcons.person),
          title:
              ('${AppLocalization.of(context)?.getTranslatedValue('contacts')}'),
          textStyle: TextStyle(
            fontFamily: themeProvider.font,
          ),
          activeColorPrimary: primaryPurple,
          inactiveColorPrimary: CupertinoColors.systemGrey4,
          iconSize: 22.0,
        ),
        PersistentBottomNavBarItem(
          contentPadding: 0.0,
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(Icons.call_rounded),
          ),
          title: ('${AppLocalization.of(context)?.getTranslatedValue('call')}'),
          textStyle: TextStyle(
            fontFamily: themeProvider.font,
          ),
          activeColorPrimary: primaryPurple,
          inactiveColorPrimary: CupertinoColors.systemGrey4,
          iconSize: 25.0,
        ),
        PersistentBottomNavBarItem(
          contentPadding: 0.0,
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(CustomIcons.settings),
          ),
          title:
              ('${AppLocalization.of(context)?.getTranslatedValue('settings')}'),
          textStyle: TextStyle(
            fontFamily: themeProvider.font,
          ),
          activeColorPrimary: primaryPurple,
          inactiveColorPrimary: CupertinoColors.systemGrey4,
          iconSize: 22.0,
        ),
      ];
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryPurple,
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: themeProvider.isDarkMode == true
              ? MyTheme.darkTheme.bottomNavigationBarTheme.backgroundColor!
              : MyTheme.lightTheme.bottomNavigationBarTheme.backgroundColor!,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          onItemSelected: (i) {
            setState(() {
              if (CacheHelper.getData(key: 'languageCode') == 'ar') {
                setState(() {
                  Home.isRtl = true;
                });
              } else {
                setState(() {
                  Home.isRtl = false;
                });
              }
            });
          },
          navBarStyle: NavBarStyle.style9,
        ),
      ),
    );
  }
}

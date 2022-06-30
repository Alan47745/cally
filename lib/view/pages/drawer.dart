import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/custom_icons_icons.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/view/pages/contact_us.dart';
import 'package:cally/view/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() {
    return _DrawerPageState();
  }
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Image.asset('assets/img/cally_logo.png'),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(
                  child: Profile(),
                  direction: AxisDirection.left,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: ListTile(
              title: Text(
                '${AppLocalization.of(context)?.getTranslatedValue('profile')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: themeProvider.font,
                ),
              ),
              leading: const Icon(
                CustomIcons.person,
                color: Colors.white,
                size: 23.0,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            indent: 30.0,
            endIndent: 40.0,
          ),
          MaterialButton(
            onPressed: () {},
            child: ListTile(
              title: Text(
                '${AppLocalization.of(context)?.getTranslatedValue('aboutUs')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: themeProvider.font,
                ),
              ),
              leading: const Icon(
                Icons.list_alt_rounded,
                color: Colors.white,
                size: 23.0,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            indent: 30.0,
            endIndent: 40.0,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(
                  child: ContactUs(),
                  direction: AxisDirection.left,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: ListTile(
              title: Text(
                '${AppLocalization.of(context)?.getTranslatedValue('contactUs')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: themeProvider.font,
                ),
              ),
              leading: const Icon(
                Icons.contact_support,
                color: Colors.white,
                size: 23.0,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            indent: 30.0,
            endIndent: 40.0,
          ),
          MaterialButton(
            onPressed: () {},
            child: ListTile(
              title: Text(
                '${AppLocalization.of(context)?.getTranslatedValue('privacyPolicy')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: themeProvider.font,
                ),
              ),
              leading: const Icon(
                Icons.policy,
                color: Colors.white,
                size: 23.0,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            indent: 30.0,
            endIndent: 40.0,
          ),
          MaterialButton(
            onPressed: () {},
            child: ListTile(
              title: Text(
                '${AppLocalization.of(context)?.getTranslatedValue('rateUs')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: themeProvider.font,
                ),
              ),
              leading: const Icon(
                Icons.rate_review,
                color: Colors.white,
                size: 23.0,
              ),
            ),
          ),
          const Spacer(),
          MaterialButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: ListTile(
              title: Text(
                '${AppLocalization.of(context)?.getTranslatedValue('exit')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: themeProvider.font,
                ),
              ),
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 23.0,
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}

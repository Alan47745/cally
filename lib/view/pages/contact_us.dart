import 'package:cally/localization/localization.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() {
    return _ContactUsState();
  }
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode == true
          ? MyTheme.darkTheme.appBarTheme.backgroundColor
          : MyTheme.lightTheme.appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode == true
            ? MyTheme.darkTheme.appBarTheme.backgroundColor
            : MyTheme.lightTheme.appBarTheme.backgroundColor,
        title: Text(
          "${AppLocalization.of(context)?.getTranslatedValue('contactUs')}",
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Helvetica New Bold',
          fontSize: 16.0,
        ),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(
              CustomPageRoute(
                child: Home(),
                direction: AxisDirection.right,
                duration: const Duration(milliseconds: 300),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            // height: 500.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode == true
                  ? MyTheme.darkTheme.cardColor
                  : MyTheme.lightTheme.cardColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                contactItem(
                  title: '+963 981 573 299',
                  icon: Icons.call,
                  onTap: () {},
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                ),
                contactItem(
                  title: 'alanalhasan0@gmail.com',
                  icon: Icons.email,
                  onTap: () {},
                ),
                contactItem(
                  title: 'Syria, Tartous, Safita',
                  icon: Icons.location_on,
                  onTap: () {},
                ),
                contactItem(
                  title: '+963 969 028 987',
                  icon: Icons.whatsapp,
                  onTap: () {},
                ),
                contactItem(
                  title: 'Alan M Alhasan',
                  icon: Icons.facebook,
                  onTap: () {},
                ),
                contactItem(
                  title: '@alanalhasan',
                  icon: Icons.camera,
                  onTap: () {},
                ),
                contactItem(
                  title: '@alan_m_alhasan',
                  icon: Icons.flutter_dash,
                  onTap: () {},
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contactItem({
    required String title,
    required IconData icon,
    void Function()? onTap,
    BorderRadiusGeometry? borderRadius = BorderRadius.zero,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius!,
      ),
      color: themeProvider.isDarkMode == true
          ? MyTheme.darkTheme.cardColor
          : MyTheme.lightTheme.cardColor,
      child: ListTile(
        // onTap: onTap,
        title: Text(title),
        leading: Icon(icon),
      ),
    );
  }
}

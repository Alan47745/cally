import 'package:cally/localization/localization.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  Future<void> sendEmail({
    required String email,
  }) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: '',
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast(text: 'Could not launch $url');
    }
  }

  Future<void> socialMediaLauncher({
    required String host,
    required String path,
  }) async {
    final Uri params = Uri(
      scheme: 'https',
      host: host,
      path: path,
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      showToast(text: 'Something went wrong');
    }
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
        titleTextStyle: TextStyle(
          fontFamily: themeProvider.font,
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
        padding: const EdgeInsets.all(12.0),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            // height: 500.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode == true
                  ? MyTheme.darkTheme.cardColor.withOpacity(0.3)
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
                  onTap: () {
                    FlutterPhoneDirectCaller.callNumber('+963981573299');
                  },
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                ),
                contactItem(
                  title: 'alanalhasan0@gmail.com',
                  icon: Icons.email,
                  onTap: () {
                    sendEmail(
                      email: 'alanalhasan0@gmail.com',
                    );
                  },
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
                  onTap: () {
                    String facebookApp = "fb://profile/100010619418275";
                    canLaunchUrlString(facebookApp).then((canLaunch) {
                      if (canLaunch) {
                        launchUrlString(facebookApp);
                      } else {
                        // Do something else
                      }
                    });
                  },
                ),
                contactItem(
                  title: '@alanalhasan',
                  icon: Icons.camera,
                  onTap: () async {
                    const nativeUrl =
                        "instagram://user?alanalhasan=severities_app";
                    const webUrl = "https://www.instagram.com/severinas_app/";
                    if (await canLaunch(nativeUrl)) {
                      await launch(nativeUrl);
                    } else if (await canLaunch(webUrl)) {
                      await launch(webUrl);
                    } else {
                      print("can't open Instagram");
                    }

                    // var url = 'https://www.instagram.com/alanalhasan';
                    // if (await canLaunch(url)) {
                    //   await launch(
                    //     url,
                    //     universalLinksOnly: true,
                    //     forceSafariVC: true,
                    //     forceWebView: true,
                    //   );
                    // } else {
                    //   throw 'There was a problem to open the url: $url';
                    // }
                  },
                ),
                contactItem(
                  title: '@alan_m_alhasan',
                  icon: Icons.flutter_dash,
                  onTap: () {
                    socialMediaLauncher(
                      host: 'twitter.com',
                      path: 'alan_m_alhasan',
                    );
                  },
                  borderRadius: const BorderRadius.only(
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
          ? MyTheme.darkTheme.cardColor.withOpacity(0.3)
          : MyTheme.lightTheme.cardColor,
      child: ListTile(
        // onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins Regular',
          ),
        ),
        leading: Icon(icon),
      ),
    );
  }
}

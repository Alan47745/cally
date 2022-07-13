import 'package:cally/localization/localization.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  _launchWhatsapp({
    required String number,
  }) async {
    var whatsappUrl = "whatsapp://send?phone=$number" "&text=";
    try {
      launch(whatsappUrl);
    } catch (e) {
      showToast(text: e.toString());
    }
  }

  Future<void> _launchInstagram({
    required String username,
  }) async {
    var url = 'https://www.instagram.com/$username/';

    try {
      launch(
        url,
        universalLinksOnly: true,
      );
    } catch (e) {
      showToast(text: e.toString());
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
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            Image.asset(
              'assets/img/cally_logo.png',
              height: 200.0,
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
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
                    title: 'Call Me Direct',
                    icon: const Icon(Icons.call),
                    onTap: () {
                      FlutterPhoneDirectCaller.callNumber('+963981573299');
                    },
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                  ),
                  contactItem(
                    title: 'Email Me',
                    icon: const Icon(Icons.email),
                    onTap: () {
                      sendEmail(
                        email: 'alanalhasan0@gmail.com',
                      );
                    },
                  ),
                  contactItem(
                    title: 'Syria, Tartous, Safita',
                    icon: const Icon(Icons.location_on),
                    onTap: () {},
                  ),
                  contactItem(
                    title: 'WhatsApp',
                    icon: const Icon(Icons.whatsapp),
                    onTap: () {
                      _launchWhatsapp(number: '+963969028987');
                    },
                  ),
                  contactItem(
                    title: 'Facebook',
                    icon: const Icon(Icons.facebook),
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
                    title: 'Instagram',
                    icon: SvgPicture.asset(
                      'assets/img/instagram_icon.svg',
                      height: 25.0,
                      width: 25.0,
                      color: Colors.white,
                    ),
                    onTap: () {
                      _launchInstagram(username: 'alanalhasan');
                    },
                  ),
                  contactItem(
                    title: 'Twitter',
                    icon: SvgPicture.asset(
                      'assets/img/twitter_icon.svg',
                      height: 22.0,
                      width: 22.0,
                      color: Colors.white,
                    ),
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
          ],
        ),
      ),
    );
  }

  Widget contactItem({
    required String title,
    required Widget icon,
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
        leading: icon,
      ),
    );
  }
}

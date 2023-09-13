import 'package:cally/localization/localization.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PolicyPrivacy extends StatefulWidget {
  @override
  _PolicyPrivacyState createState() {
    return _PolicyPrivacyState();
  }
}

class _PolicyPrivacyState extends State<PolicyPrivacy> {
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
          "${AppLocalization.of(context)?.getTranslatedValue('privacyPolicy')}",
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
      body: Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: primaryPurple.withOpacity(0.2),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_privacyPolicy')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_privacyPolicy_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_informationCollectionUse')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_informationCollectionUse_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_logData')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_logData_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_cookies')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_cookies_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_serviceProviders')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_serviceProviders_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_security')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_security_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_linksOtherSites')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_linksOtherSites_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_childrenPrivacy')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_childrenPrivacy_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_changesThisPrivacyPolicy')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_changesThisPrivacyPolicy_text')}",
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_contactUs')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue('pP_contactUs_text')}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cally/localization/localization.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/home.dart';
import 'package:flutter/cupertino.dart';
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
                  'Privacy Policy\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Alan Majed Alhasan built the Cally app as a Free app.\nThis SERVICE is provided by Alan Majed Alhasan at no cost and is intended for use as is.\nThis page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Cally unless otherwise defined in this Privacy Policy.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Information Collection and Use\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Log Data\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Cookies\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Service Providers\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'I may employ third-party companies and individuals due to the following reasons:\n\n1. To facilitate our Service\n2. To provide the Service on our behalf\n3. To perform Service-related services\n4. To assist us in analyzing how our Service is used\n\nI want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Security\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Links to Other Sites\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Children\'s Privacy\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'I do not knowingly collect personally identifiable information from children. I encourage all children to never submit any personally identifiable information through the Application and/or Services. I encourage parents and legal guardians to monitor their children\'s Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to us through the Application and/or Services, please contact us. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf).',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Changes to This Privacy Policy\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\n\nThis policy is effective as of 2022-01-01',
                ),
                //
                const SizedBox(height: 20.0),
                Text(
                  'Contact Us\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at alanalhasan0@gmail.com',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

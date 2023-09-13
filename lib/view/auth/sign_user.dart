// ignore_for_file: use_key_in_widget_constructors, avoid_print, sized_box_for_whitespace

import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/auth/google_sign_in.dart';
import 'package:cally/widget/custom_text_field.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Gender { male, female, nothing }

class SignUser extends StatefulWidget {
  @override
  _SignUserState createState() {
    return _SignUserState();
  }
}

class _SignUserState extends State<SignUser> {
  // var nameCon = TextEditingController();
  var phoneCon = TextEditingController();
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  Gender? choice = Gender.nothing;
  bool isAgree = false;
  String? gender;
  IconData genderIcon = Icons.transgender;
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode == true
          ? MyTheme.darkTheme.appBarTheme.backgroundColor
          : MyTheme.lightTheme.appBarTheme.backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: Text(
                "${AppLocalization.of(context)?.getTranslatedValue('signWithUs')}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35.0,
                  fontFamily: themeProvider.font,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode == true
                    ? MyTheme.darkTheme.cardColor
                    : MyTheme.lightTheme.cardColor,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 3.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // CustomTextFormField(
                    //     fontFamily: themeProvider.font,
                    //     controller: nameCon,
                    //     hintText:
                    //         "${AppLocalization.of(context)?.getTranslatedValue('yourName')}",
                    //     hintColor: themeProvider.isDarkMode == true
                    //         ? MyTheme.darkTheme.primaryColor
                    //         : MyTheme.lightTheme.primaryColor,
                    //     keyboardType: TextInputType.name,
                    //     textInputAction: TextInputAction.next,
                    //     fillColor: themeProvider.isDarkMode == true
                    //         ? MyTheme.darkTheme.cardColor
                    //         : MyTheme.lightTheme.cardColor,
                    //     filled: true,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return '';
                    //       }
                    //       return null;
                    //     }),
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomTextFormField(
                        fontFamily: themeProvider.font,
                        controller: phoneCon,
                        hintText:
                            "${AppLocalization.of(context)?.getTranslatedValue('yourNumber')}",
                        hintColor: themeProvider.isDarkMode == true
                            ? MyTheme.darkTheme.primaryColor
                            : MyTheme.lightTheme.primaryColor,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        fillColor: themeProvider.isDarkMode == true
                            ? MyTheme.darkTheme.cardColor
                            : MyTheme.lightTheme.cardColor,
                        filled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        context: context,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode == true
                            ? MyTheme.darkTheme.cardColor
                            : MyTheme.lightTheme.cardColor,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: PopupMenuButton<Gender>(
                        offset: const Offset(1.0, 40.0),
                        tooltip: 'Choice Gender',
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onSelected: (Gender result) {
                          setState(() {
                            choice = result;
                          });
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              choice == Gender.male
                                  ? "${AppLocalization.of(context)?.getTranslatedValue('male')}"
                                  : choice == Gender.female
                                      ? "${AppLocalization.of(context)?.getTranslatedValue('female')}"
                                      : "${AppLocalization.of(context)?.getTranslatedValue('yourGender')}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: themeProvider.font,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              choice == Gender.male
                                  ? Icons.male
                                  : choice == Gender.female
                                      ? Icons.female
                                      : genderIcon,
                              size: 18.0,
                            ),
                          ],
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Gender>>[
                          PopupMenuItem<Gender>(
                            value: Gender.male,
                            onTap: () {
                              gender = 'Male';
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${AppLocalization.of(context)?.getTranslatedValue('male')}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: themeProvider.font,
                                  ),
                                ),
                                const Icon(
                                  Icons.male,
                                  size: 18.0,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<Gender>(
                            value: Gender.female,
                            onTap: () {
                              gender = 'Female';
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${AppLocalization.of(context)?.getTranslatedValue('female')}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: themeProvider.font,
                                  ),
                                ),
                                const Icon(
                                  Icons.female,
                                  size: 18.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return NotificationListener<
                                      OverscrollIndicatorNotification>(
                                    onNotification: (notification) {
                                      notification.disallowIndicator();
                                      return true;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30.0),
                                      child: Dialog(
                                        backgroundColor:
                                            themeProvider.isDarkMode == true
                                                ? MyTheme.darkTheme.appBarTheme
                                                    .backgroundColor
                                                : MyTheme.lightTheme.appBarTheme
                                                    .backgroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 20.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${AppLocalization.of(context)?.getTranslatedValue('tC_termsConditions')}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    fontFamily:
                                                        themeProvider.font,
                                                  ),
                                                ),
                                                Text(
                                                  "${AppLocalization.of(context)?.getTranslatedValue('tC_termsConditions_text')}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        themeProvider.font,
                                                  ),
                                                ),
                                                //
                                                const SizedBox(height: 20.0),
                                                Text(
                                                  "${AppLocalization.of(context)?.getTranslatedValue('tC_changesTermsConditions')}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    fontFamily:
                                                        themeProvider.font,
                                                  ),
                                                ),
                                                Text(
                                                  "${AppLocalization.of(context)?.getTranslatedValue('tC_changesTermsConditions_text')}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        themeProvider.font,
                                                  ),
                                                ),
                                                //
                                                const SizedBox(height: 20.0),
                                                Text(
                                                  "${AppLocalization.of(context)?.getTranslatedValue('tC_contactUs')}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    fontFamily:
                                                        themeProvider.font,
                                                  ),
                                                ),
                                                Text(
                                                  "${AppLocalization.of(context)?.getTranslatedValue('tC_contactUs_text')}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        themeProvider.font,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "${AppLocalization.of(context)?.getTranslatedValue('agreeTermsConditions')}",
                              style: TextStyle(
                                color: themeProvider.isDarkMode == true
                                    ? Colors.white
                                    : primaryPurple,
                                fontWeight: FontWeight.bold,
                                fontFamily: themeProvider.font,
                              ),
                            ),
                          ),
                          Checkbox(
                            activeColor: primaryPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            value: isAgree,
                            onChanged: (value) {
                              setState(() {
                                isAgree = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isLoading == true
                ? Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 150.0,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (choice != Gender.nothing) {
                            if (isAgree == true) {
                              setState(() {
                                isLoading = true;
                              });
                              await Future.delayed(
                                  const Duration(milliseconds: 1500));

                              CacheHelper.saveData(
                                  key: 'phone', value: phoneCon.text);
                              CacheHelper.saveData(
                                  key: 'gender', value: gender);
                              CacheHelper.saveData(
                                  key: 'introFinished', value: true);

                              Navigator.of(context).pushAndRemoveUntil(
                                CustomPageRoute(
                                  child: GoogleSignInPage(),
                                  direction: AxisDirection.right,
                                  duration: const Duration(milliseconds: 300),
                                ),
                                (route) => false,
                              );
                            } else {
                              showToast(
                                text:
                                    "${AppLocalization.of(context)?.getTranslatedValue('pleaseAgreeTermsConditions')}",
                              );
                            }
                          } else {
                            showToast(
                              text:
                                  "${AppLocalization.of(context)?.getTranslatedValue('plzChooseGender')}",
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(primaryPurple),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins Regular',
                          color: themeProvider.isDarkMode == true
                              ? MyTheme.darkTheme.appBarTheme.backgroundColor
                              : MyTheme.lightTheme.appBarTheme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
/*

*/

// ignore_for_file: use_key_in_widget_constructors, avoid_print, sized_box_for_whitespace

import 'package:cally/model/cacheHelper.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/widget/custom_text_field.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';

enum Gender { male, female, nothing }

class SignUser extends StatefulWidget {
  @override
  _SignUserState createState() {
    return _SignUserState();
  }
}

class _SignUserState extends State<SignUser> {
  var nameCon = TextEditingController();
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
    return Scaffold(
      backgroundColor: primaryPurple,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: const Text(
                'Sign With Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35.0,
                  fontFamily: 'Poppins Regular',
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
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
                    CustomTextFormField(
                        controller: nameCon,
                        hintText: 'Your Name',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                        controller: phoneCon,
                        hintText: 'Your Number',
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: BoxDecoration(
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
                                  ? 'Male'
                                  : choice == Gender.female
                                      ? 'Female'
                                      : 'Your Gender',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins Regular',
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
                              children: const [
                                Text(
                                  'Male',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins Regular',
                                  ),
                                ),
                                Icon(
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
                              children: const [
                                Text(
                                  'Female',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins Regular',
                                  ),
                                ),
                                Icon(
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
                      height: 20.0,
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
                                        backgroundColor: primaryPurple,
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
                                              children: const [
                                                Text(
                                                  'Terms & Conditions\n',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                Text(
                                                  'By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Alan Majed Alhasan.\nAlan Majed Alhasan is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\nThe Cally app stores and processes personal data that you have provided to us, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Cally app won’t work properly or at all.\nYou should be aware that there are certain things that Alan Majed Alhasan will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Alan Majed Alhasan cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.\nIf you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\nAlong the same lines, Alan Majed Alhasan cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Alan Majed Alhasan cannot accept responsibility.\nWith respect to Alan Majed Alhasan’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Alan Majed Alhasan accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\nAt some point, we may wish to update the app. The app is currently available on Android & iOS – the requirements for the both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Alan Majed Alhasan does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                //
                                                SizedBox(height: 20.0),
                                                Text(
                                                  'Changes to This Terms and Conditions\n',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                Text(
                                                  'I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.\nThese terms and conditions are effective as of 2022-01-01',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                //
                                                SizedBox(height: 20.0),
                                                Text(
                                                  'Contact Us\n',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                Text(
                                                  'If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at alanalhasan0@gmail.com.',
                                                  style: TextStyle(
                                                    color: Colors.white,
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
                            child: const Text(
                              'Agree Terms & Conditions',
                              style: TextStyle(
                                color: primaryPurple,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationThickness: 1.5,
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
                    // CheckboxListTile(
                    //   title: Text('Agree Terms & Conditions'),
                    //   activeColor: primaryPurple,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(50.0),
                    //   ),
                    //   checkboxShape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(50.0),
                    //   ),
                    //   value: isAgree,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       isAgree = value!;
                    //     });
                    //   },
                    // ),
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
                                  key: 'name', value: nameCon.text);
                              CacheHelper.saveData(
                                  key: 'phone', value: phoneCon.text);
                              CacheHelper.saveData(
                                  key: 'gender', value: gender);
                              CacheHelper.saveData(
                                  key: 'introFinished', value: true);
                              Navigator.of(context).pushAndRemoveUntil(
                                CustomPageRoute(
                                  child: Home(),
                                  direction: AxisDirection.right,
                                  duration: const Duration(milliseconds: 300),
                                ),
                                (route) => false,
                              );
                            } else {
                              showToast(
                                  text: 'Please Agree Terms & Conditions');
                            }
                          } else {
                            showToast(text: 'Please Choose Your Gender');
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
                      child: const Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins Regular',
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

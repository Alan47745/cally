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
            if (MediaQuery.of(context).viewInsets.bottom == 0.0)
              const Text(
                'Sign With Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35.0,
                ),
              ),
            Container(
              // height: 300.0,
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
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    // CustomTextFormField(
                    //     controller: emailCon,
                    //     hintText: 'Your Email',
                    //     keyboardType: TextInputType.emailAddress,
                    //     textInputAction: TextInputAction.next,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return '';
                    //       }
                    //       return null;
                    //     }),
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    // CustomTextFormField(
                    //     controller: passwordCon,
                    //     hintText: 'Your Password',
                    //     keyboardType: TextInputType.visiblePassword,
                    //     textInputAction: TextInputAction.done,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return '';
                    //       }
                    //       return null;
                    //     }),
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
                            setState(() {
                              isLoading = true;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 1500));

                            CacheHelper.saveData(
                                key: 'name', value: nameCon.text);
                            CacheHelper.saveData(
                                key: 'phone', value: phoneCon.text);
                            CacheHelper.saveData(key: 'gender', value: gender);
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

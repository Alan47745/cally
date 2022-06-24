import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/widget/custom_text_field.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

enum Gender { male, female, nothing }

enum ScreenState { loading, done }

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  var nameCon = TextEditingController(text: CacheHelper.getData(key: 'name'));
  var phoneCon = TextEditingController(text: CacheHelper.getData(key: 'phone'));
  bool isLoading = false;
  bool isEditing = false;
  var formKey = GlobalKey<FormState>();
  Icon edit = const Icon(Icons.edit);
  Icon save = const Icon(Icons.save_outlined);
  Gender? choice = Gender.nothing;
  ScreenState state = ScreenState.done;
  String? gender;
  IconData genderIcon = Icons.transgender;

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
          "${AppLocalization.of(context)?.getTranslatedValue('profile')}",
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
        actions: [
          if (isEditing == false)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                icon: isEditing ? save : edit,
              ),
            ),
          if (isEditing == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (choice != Gender.nothing) {
                      CacheHelper.replaceData(key: 'name', value: nameCon.text);
                      CacheHelper.replaceData(
                          key: 'phone', value: phoneCon.text);
                      CacheHelper.replaceData(key: 'gender', value: "$gender");
                      setState(() {
                        state = ScreenState.loading;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        isEditing = !isEditing;
                        state = ScreenState.done;
                      });
                    } else {
                      showToast(
                        text:
                            "${AppLocalization.of(context)?.getTranslatedValue('plzChooseGender')}",
                      );
                    }
                  }
                },
                icon: const Icon(Icons.save_outlined),
              ),
            ),
          if (isEditing == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if (state == ScreenState.loading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    CacheHelper.getData(key: 'gender') == "Male"
                        ? CircleAvatar(
                            backgroundColor: Colors.amber,
                            maxRadius: 78.0,
                            child: SvgPicture.asset(
                              'assets/img/Asset 11.svg',
                              height: 150.0,
                              width: 150.0,
                            ),
                          )
                        : CacheHelper.getData(key: 'gender') == 'Female'
                            ? CircleAvatar(
                                backgroundColor: Colors.amber,
                                maxRadius: 78.0,
                                child: SvgPicture.asset(
                                  'assets/img/Asset 10.svg',
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              )
                            : const SizedBox(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        isEditing == true
                            ? CustomTextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                controller: nameCon,
                                filled: true,
                                fillColor: themeProvider.isDarkMode == true
                                    ? MyTheme.darkTheme.cardColor
                                    : MyTheme.lightTheme.cardColor,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              )
                            : Container(
                                height: 50.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: themeProvider.isDarkMode == true
                                      ? MyTheme.darkTheme.cardColor
                                      : MyTheme.lightTheme.cardColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  CacheHelper.getData(key: 'name'),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        isEditing == true
                            ? Directionality(
                                textDirection: TextDirection.ltr,
                                child: CustomTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  controller: phoneCon,
                                  filled: true,
                                  fillColor: themeProvider.isDarkMode == true
                                      ? MyTheme.darkTheme.cardColor
                                      : MyTheme.lightTheme.cardColor,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                ),
                              )
                            : Directionality(
                                textDirection: TextDirection.ltr,
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.cardColor
                                        : MyTheme.lightTheme.cardColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    CacheHelper.getData(key: 'phone'),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        isEditing == true
                            ? Container(
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
                                  tooltip:
                                      "${AppLocalization.of(context)?.getTranslatedValue('choiceGender')}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalization.of(context)?.getTranslatedValue('male')}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalization.of(context)?.getTranslatedValue('female')}",
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
                              )
                            : Container(
                                height: 50.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: themeProvider.isDarkMode == true
                                      ? MyTheme.darkTheme.cardColor
                                      : MyTheme.lightTheme.cardColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      CacheHelper.getData(key: 'gender') ==
                                              'Male'
                                          ? "${AppLocalization.of(context)?.getTranslatedValue('male')}"
                                          : "${AppLocalization.of(context)?.getTranslatedValue('female')}",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Icon(
                                      CacheHelper.getData(key: 'gender') ==
                                              'Male'
                                          ? Icons.male
                                          : Icons.female,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

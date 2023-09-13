import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/model/google_sign_in_api.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/auth/sign_user.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/widget/custom_text_field.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Gender { male, female, nothing }

enum ScreenState { loading, done }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
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
  Future signOut() async {
    await GoogleSignInApi.logout();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode == true
            ? MyTheme.darkTheme.appBarTheme.backgroundColor
            : MyTheme.lightTheme.appBarTheme.backgroundColor,
        title: Text(
          "${AppLocalization.of(context)?.getTranslatedValue('profile')}",
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
        actions: [
          if (isEditing == false)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    icon: edit,
                  ),
                ),
                PopupMenuButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  offset: const Offset(0.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  color: themeProvider.isDarkMode == true
                      ? MyTheme.darkTheme.popupMenuTheme.color
                      : MyTheme.lightTheme.popupMenuTheme.color,
                  itemBuilder: (popContext) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () async {
                          await Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      themeProvider.isDarkMode == true
                                          ? MyTheme.darkTheme.cardColor
                                          : MyTheme.lightTheme.cardColor,
                                  behavior: SnackBarBehavior.floating,
                                  dismissDirection: DismissDirection.horizontal,
                                  duration: const Duration(seconds: 3),
                                  content: Text(
                                    "${AppLocalization.of(context)?.getTranslatedValue('statisticsIsSoon')}",
                                    style: TextStyle(
                                      color: themeProvider.isDarkMode == true
                                          ? MyTheme.darkTheme.primaryColor
                                          : MyTheme.lightTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${AppLocalization.of(context)?.getTranslatedValue('statistics')}",
                              style: TextStyle(
                                fontFamily: themeProvider.font,
                                color: themeProvider.isDarkMode == true
                                    ? MyTheme.darkTheme.primaryColor
                                    : MyTheme.lightTheme.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.analytics_outlined,
                              color: themeProvider.isDarkMode == true
                                  ? MyTheme.darkTheme.primaryColor
                                  : MyTheme.lightTheme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          signOut();
                          await Future.delayed(
                              const Duration(milliseconds: 500), () {
                            CacheHelper.removeData(key: 'phone');
                            CacheHelper.removeData(key: 'gender');
                            CacheHelper.removeData(key: 'isSigned');
                            CacheHelper.removeData(key: 'name');
                            CacheHelper.removeData(key: 'email');
                            CacheHelper.removeData(key: 'img');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUser(),
                              ),
                              (route) => false,
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${AppLocalization.of(context)?.getTranslatedValue('logout')}",
                              style: TextStyle(
                                fontFamily: themeProvider.font,
                                color: themeProvider.isDarkMode == true
                                    ? MyTheme.darkTheme.primaryColor
                                    : MyTheme.lightTheme.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.logout,
                              color: themeProvider.isDarkMode == true
                                  ? MyTheme.darkTheme.primaryColor
                                  : MyTheme.lightTheme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          if (isEditing == true)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (choice != Gender.nothing) {
                          CacheHelper.replaceData(
                              key: 'phone', value: phoneCon.text);
                          CacheHelper.replaceData(
                              key: 'gender', value: "$gender");

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
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView(
              children: [
                if (state == ScreenState.loading)
                  Container(
                    height: MediaQuery.of(context).size.height - 70,
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: themeProvider.isDarkMode == true
                            ? Colors.deepPurple[700]
                            : primaryPurple,
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width,
                            // color: primaryGrey,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkMode == true
                                    ? MyTheme
                                        .darkTheme.appBarTheme.backgroundColor
                                    : MyTheme
                                        .lightTheme.appBarTheme.backgroundColor,
                              ),
                              child: Image.asset(
                                'assets/img/background_profile.png',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.3,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.amber[700],
                              maxRadius: 67.0,
                              child: CircleAvatar(
                                maxRadius: 66.0,
                                backgroundColor:
                                    themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.appBarTheme
                                            .backgroundColor
                                        : MyTheme.lightTheme.appBarTheme
                                            .backgroundColor,
                                child: CacheHelper.getData(key: 'img') == null
                                    ? const CircularProgressIndicator()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(66.0),
                                        child: Image.network(
                                          CacheHelper.getData(key: 'img'),
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: LinearProgressIndicator(
                                                color: Colors.grey,
                                                backgroundColor:
                                                    Colors.transparent,
                                                minHeight: 132.0,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Container(
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.error_outline,
                                                    color: Colors.red,
                                                    size: 30.0,
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    'حدث خطأ أثناء تحميل الصورة',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  "${AppLocalization.of(context)?.getTranslatedValue('name')}",
                                  style: TextStyle(
                                    fontFamily: themeProvider.font,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
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
                                  fontFamily: 'Poppins Regular',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: themeProvider.font,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkMode == true
                                    ? MyTheme.darkTheme.cardColor
                                    : MyTheme.lightTheme.cardColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                CacheHelper.getData(key: 'email'),
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins Regular',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  "${AppLocalization.of(context)?.getTranslatedValue('phone')}",
                                  style: TextStyle(
                                    fontFamily: themeProvider.font,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
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
                                      fillColor:
                                          themeProvider.isDarkMode == true
                                              ? MyTheme.darkTheme.cardColor
                                              : MyTheme.lightTheme.cardColor,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.done,
                                      context: context,
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        CacheHelper.getData(key: 'phone'),
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Poppins Regular',
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.transgender,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  "${AppLocalization.of(context)?.getTranslatedValue('gender')}",
                                  style: TextStyle(
                                    fontFamily: themeProvider.font,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      onSelected: (Gender result) {
                                        setState(() {
                                          choice = result;
                                        });
                                      },
                                      icon: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${AppLocalization.of(context)?.getTranslatedValue('male')}",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily:
                                                      themeProvider.font,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${AppLocalization.of(context)?.getTranslatedValue('female')}",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily:
                                                      themeProvider.font,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          CacheHelper.getData(key: 'gender') ==
                                                  'Male'
                                              ? "${AppLocalization.of(context)?.getTranslatedValue('male')}"
                                              : "${AppLocalization.of(context)?.getTranslatedValue('female')}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: themeProvider.font,
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
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

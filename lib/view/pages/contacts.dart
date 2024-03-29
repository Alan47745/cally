// ignore_for_file: unnecessary_string_interpolations, null_check_always_fails, unnecessary_null_comparison, non_constant_identifier_names, deprecated_member_use

import 'dart:io';

import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/utils/custom_icons_icons.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:typed_data';

enum SearchOptions { open, close }

class MyContacts extends StatefulWidget {
  const MyContacts({super.key});

  @override
  _MyContactsState createState() {
    return _MyContactsState();
  }
}

class _MyContactsState extends State<MyContacts> with WidgetsBindingObserver {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];

  var searchController = TextEditingController();
  bool contactsLoaded = true;

  @override
  void initState() {
    super.initState();
    FlutterContacts.addListener(() {
      getAllContacts();
    });
    WidgetsBinding.instance.addObserver(this);
    getAllContacts().then((value) {
      if (mounted) {
        setState(() {
          contactsLoaded = false;
        });
      }
    }).catchError((error) {
      debugPrint(error);
    });

    searchController.addListener(() {
      filterContacts();
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // Future<void> getPermissions() async {
  //   if (await Permission.contacts.request().isGranted) {
  //     getAllContacts().then((value) {
  //       if (mounted) {
  //         setState(() {
  //           contactsLoaded = false;
  //         });
  //       }
  //     }).catchError((error) {
  //       debugPrint(error);
  //     });

  //     searchController.addListener(() {
  //       filterContacts();
  //     });
  //   } else {
  //     await Permission.contacts.request();
  //   }
  // }

  Future<void> getAllContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
        withThumbnail: true,
        withAccounts: true,
      );
      setState(() {});
    }
  }

  SearchOptions option = SearchOptions.close;

  sendMassage({
    required String number,
    required String massage,
  }) async {
    String uri = 'sms:$number?body=$massage';
    if (Platform.isAndroid) {
      await launch(uri);
    } else if (Platform.isIOS) {
      await launch(uri);
    } else {
      showToast(text: 'Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      floatingActionButton: option == SearchOptions.open
          ? const SizedBox()
          : contactsLoaded
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    backgroundColor: themeProvider.isDarkMode == true
                        ? MyTheme.darkTheme.appBarTheme.backgroundColor
                        : MyTheme.lightTheme.appBarTheme.backgroundColor,
                    spacing: 20.0,
                    foregroundColor: Colors.white,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.4,
                    children: [
                      SpeedDialChild(
                        child: const Icon(Icons.person_add),
                        onTap: () => FlutterContacts.openExternalInsert(),
                      ),
                      if (contacts.isNotEmpty)
                        SpeedDialChild(
                          child: const Icon(CustomIcons.search),
                          onTap: () => setState(() {
                            option = SearchOptions.open;
                          }),
                        ),
                    ],
                  ),
                ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (option == SearchOptions.close) {
            await Future.delayed(
              const Duration(milliseconds: 1500),
              () {
                setState(() {
                  // isExpanded = false;
                  contactsLoaded = true;
                });
              },
            ).then((value) {
              setState(() {
                getAllContacts().then((value) {
                  if (mounted) {
                    setState(() {
                      contactsLoaded = false;
                    });
                  }
                });
              });
            });
          }
        },
        color: primaryPurple,
        child: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSwatch(accentColor: primaryPurple),
          ),
          child: contactsLoaded == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryPurple,
                  ),
                )
              : contacts.isEmpty
                  ? ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: Text(
                            "${AppLocalization.of(context)?.getTranslatedValue('noContacts')}",
                            style: TextStyle(
                              color: themeProvider.isDarkMode == true
                                  ? MyTheme.darkTheme.primaryColor
                                  : MyTheme.lightTheme.primaryColor,
                              fontFamily: themeProvider.font,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      children: [
                        AnimatedCrossFade(
                          firstChild: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.cardColor
                                        : MyTheme.lightTheme.cardColor,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(0.0, 3.0),
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/img/Group 2666-min.svg',
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                0.30) -
                                            30.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0.0,
                                    bottom: 0.0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      right: 12.0,
                                      left: 18.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode == true
                                          ? MyTheme.darkTheme.appBarTheme
                                              .backgroundColor
                                          : MyTheme.lightTheme.appBarTheme
                                              .backgroundColor,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Text(
                                      '${contacts.length} ${AppLocalization.of(context)?.getTranslatedValue('contacts')}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondChild: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: searchController,
                                cursorWidth: 0.5,
                                cursorColor: primaryPurple,
                                textInputAction: TextInputAction.search,
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                  height: 1.0,
                                  fontSize: 15.0,
                                  fontFamily: themeProvider.isDirectionRtl
                                      ? 'Tajawal'
                                      : 'Poppins Regular',
                                  color: themeProvider.isDarkMode == true
                                      ? MyTheme.darkTheme.primaryColor
                                      : MyTheme.lightTheme.primaryColor,
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: primaryPurple,
                                    onPressed: () {
                                      setState(() {
                                        option = SearchOptions.close;
                                        setState(() {
                                          searchController.clear();
                                        });
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                  filled: true,
                                  fillColor: themeProvider.isDarkMode == true
                                      ? MyTheme.darkTheme.cardColor
                                      : MyTheme.lightTheme.cardColor,
                                  errorStyle: const TextStyle(
                                    fontSize: 0.0,
                                    height: 0.0,
                                  ),
                                  hintText:
                                      '${AppLocalization.of(context)?.getTranslatedValue('search')}',
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: themeProvider.isDirectionRtl
                                        ? 'Tajawal'
                                        : 'Poppins Regular',
                                    color: themeProvider.isDarkMode == true
                                        ? MyTheme.darkTheme.primaryColor
                                        : MyTheme.lightTheme.primaryColor,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: themeProvider.isDarkMode == true
                                          ? MyTheme.darkTheme.cardColor
                                          : MyTheme.lightTheme.cardColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: themeProvider.isDarkMode == true
                                          ? MyTheme.darkTheme.cardColor
                                          : MyTheme.lightTheme.cardColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: primaryPurple,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: themeProvider.isDarkMode == true
                                          ? MyTheme.darkTheme.cardColor
                                          : MyTheme.lightTheme.cardColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          crossFadeState: option == SearchOptions.open
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          cacheExtent: 50,
                          itemCount: isSearching == true
                              ? contactsFiltered.length
                              : contacts.length,
                          itemBuilder: (context, i) {
                            Uint8List? img = contacts[i].photo;
                            Contact contact = isSearching == true
                                ? contactsFiltered[i]
                                : contacts[i];
                            String customAvatar =
                                '${contact.displayName.trim().split(' ').map((l) => l[0]).take(1).join().replaceAll(RegExp('[^A-Za-z-ا-ي-آ-أ-إ]'), '').toUpperCase()}';
                            return ContactItem(
                              onCallPressed: () {
                                FlutterPhoneDirectCaller.callNumber(
                                    '${contact.phones.first.number}');
                              },
                              onMassagePressed: () {
                                sendMassage(
                                    number: '${contact.phones.first.number}',
                                    massage: '');
                              },
                              onTap: () {},
                              delete: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext dialogContext) {
                                    final themeProvider =
                                        Provider.of<ThemeProvider>(
                                            dialogContext);
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor:
                                          themeProvider.isDarkMode == true
                                              ? MyTheme.darkTheme.appBarTheme
                                                  .backgroundColor
                                              : MyTheme.lightTheme.appBarTheme
                                                  .backgroundColor,
                                      actionsAlignment: MainAxisAlignment.end,
                                      alignment: Alignment.center,
                                      titleTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: themeProvider.font,
                                        fontSize: 20.0,
                                      ),
                                      title: Text(
                                        '${AppLocalization.of(context)?.getTranslatedValue('delete')}',
                                      ),
                                      contentTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: themeProvider.font,
                                      ),
                                      content: Text(
                                          '${AppLocalization.of(context)?.getTranslatedValue('areYouSure')}\n${contact.displayName} ?'),
                                      actions: <Widget>[
                                        TextButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.grey),
                                          ),
                                          child: Text(
                                            '${AppLocalization.of(context)?.getTranslatedValue('delete')}',
                                            style: TextStyle(
                                              color: Colors.yellow,
                                              fontFamily: themeProvider.font,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(dialogContext);
                                            FlutterContacts.deleteContact(
                                                    contact)
                                                .then((value) {
                                              setState(() {
                                                contactsLoaded = true;
                                              });
                                            }).then((value) {
                                              setState(() {
                                                getAllContacts().then((value) {
                                                  if (mounted) {
                                                    setState(() {
                                                      contactsLoaded = false;
                                                    });
                                                  }
                                                });
                                              });
                                            });
                                          },
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.grey),
                                          ),
                                          child: Text(
                                            '${AppLocalization.of(context)?.getTranslatedValue('cancel')}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: themeProvider.font,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              edit: () {
                                FlutterContacts.openExternalEdit(contact.id);
                              },
                              share: () {},
                              name: '${contact.displayName}',
                              nickname: contact.phones.isNotEmpty
                                  ? '${contact.phones.first.number}'
                                  : '',
                              avatar: img != null
                                  ? CircleAvatar(
                                      foregroundColor: primaryPurple,
                                      maxRadius: 40.0,
                                      backgroundImage: MemoryImage(
                                        img,
                                      ),
                                    )
                                  : customAvatar == ''
                                      ? CircleAvatar(
                                          backgroundColor:
                                              themeProvider.isDarkMode == true
                                                  ? MyTheme.darkTheme.cardColor
                                                  : MyTheme
                                                      .lightTheme.cardColor,
                                          foregroundColor: primaryPurple,
                                          maxRadius: 40.0,
                                          child: const Icon(
                                              CupertinoIcons.person_alt),
                                        )
                                      : CircleAvatar(
                                          backgroundColor:
                                              themeProvider.isDarkMode == true
                                                  ? MyTheme.darkTheme.cardColor
                                                  : MyTheme
                                                      .lightTheme.cardColor,
                                          foregroundColor: primaryPurple,
                                          maxRadius: 40.0,
                                          child: Text(
                                            customAvatar,
                                            style: const TextStyle(
                                              fontSize: 30.0,
                                              fontFamily: 'Helvetica New Bold',
                                            ),
                                          ),
                                        ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.number);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () {
          return null!;
        });

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  Widget ContactItem({
    required String name,
    required String nickname,
    required Widget avatar,
    required VoidCallback? delete,
    required VoidCallback? edit,
    required VoidCallback? share,
    void Function()? onTap,
    required void Function()? onCallPressed,
    required void Function()? onMassagePressed,
    // required Color color,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: ExpansionTile(
            title: ListTile(
              title: Text(
                name,
                style: TextStyle(
                  fontFamily: themeProvider.font,
                  color: themeProvider.isDarkMode == true
                      ? MyTheme.darkTheme.primaryColor
                      : MyTheme.lightTheme.primaryColor,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                nickname,
                textDirection: TextDirection.ltr,
                textAlign: CacheHelper.getData(key: 'languageCode') == 'ar'
                    ? TextAlign.end
                    : TextAlign.start,
                style: TextStyle(
                  color: themeProvider.isDarkMode == true
                      ? MyTheme.darkTheme.primaryColor
                      : MyTheme.lightTheme.primaryColor,
                  fontFamily: 'Poppins Regular',
                ),
              ),
              leading: avatar,
              contentPadding: EdgeInsets.zero,
              trailing: PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                icon: Icon(
                  Icons.more_vert,
                  color: themeProvider.isDarkMode == true
                      ? MyTheme.darkTheme.primaryColor
                      : MyTheme.lightTheme.primaryColor,
                ),
                color: themeProvider.isDarkMode == true
                    ? MyTheme.darkTheme.popupMenuTheme.color
                    : MyTheme.lightTheme.popupMenuTheme.color,
                itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: edit,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalization.of(context)?.getTranslatedValue('edit')}',
                            style: TextStyle(
                              fontFamily: themeProvider.font,
                              color: themeProvider.isDarkMode == true
                                  ? MyTheme.darkTheme.primaryColor
                                  : MyTheme.lightTheme.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: themeProvider.isDarkMode == true
                                ? MyTheme.darkTheme.primaryColor
                                : MyTheme.lightTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: delete,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalization.of(context)?.getTranslatedValue('delete')}',
                            style: TextStyle(
                              fontFamily: themeProvider.font,
                              color: themeProvider.isDarkMode == true
                                  ? MyTheme.darkTheme.primaryColor
                                  : MyTheme.lightTheme.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.delete_forever,
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
            ),
            onExpansionChanged: (bool isExpand) {},
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            iconColor: Colors.transparent,
            backgroundColor: themeProvider.isDarkMode == true
                ? MyTheme.darkTheme.cardColor
                : MyTheme.lightTheme.cardColor,
            collapsedIconColor: Colors.transparent,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        hoverElevation: 0.0,
                        focusElevation: 0.0,
                        disabledElevation: 0.0,
                        onPressed: onCallPressed,
                        padding: EdgeInsets.zero,
                        color: CupertinoColors.systemGreen,
                        child: const Icon(
                          Icons.call,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        hoverElevation: 0.0,
                        focusElevation: 0.0,
                        disabledElevation: 0.0,
                        onPressed: onMassagePressed,
                        padding: EdgeInsets.zero,
                        color: CupertinoColors.systemBlue,
                        child: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

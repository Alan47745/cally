import 'package:audioplayers/audioplayers.dart';
import 'package:cally/localization/localization.dart';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/theme/my_theme.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/widget/addContact.dart';
import 'package:cally/widget/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class Call extends StatefulWidget {
  @override
  _CallState createState() {
    return _CallState();
  }
}

class _CallState extends State<Call> {
  String display = '';
  bool isAddContactsVisible = false;
  late final AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    _audioCache = AudioCache(
      prefix: 'assets/sounds/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
  }

  Phone? phone;
  Contact? contact;
  @override
  Widget build(BuildContext context) {
    var numCon = TextEditingController(text: display);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              textDirection: TextDirection.ltr,
              cursorColor: primaryPurple,
              cursorWidth: 1.0,
              cursorHeight: 40.0,
              onTap: () {},
              style: const TextStyle(
                fontSize: 28.0,
                letterSpacing: 3.0,
                fontFamily: 'Helvetica New Bold',
              ),
              controller: numCon,
              readOnly: true,
              showCursor: false,
              textAlign: TextAlign.center,
              onChanged: (value) {
                phone = Phone(value);
                contact = Contact(
                  displayName: 'alan',
                  phones: [phone!],
                  id: 'un',
                );
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberNumPad(number: '1'),
                      numberNumPad(
                          number: '2', hasCapital: true, capital: 'ABC'),
                      numberNumPad(
                          number: '3', hasCapital: true, capital: 'DEF'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberNumPad(
                          number: '4', hasCapital: true, capital: 'GHI'),
                      numberNumPad(
                          number: '5', hasCapital: true, capital: 'JKL'),
                      numberNumPad(
                          number: '6', hasCapital: true, capital: 'MNO'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberNumPad(
                          number: '7', hasCapital: true, capital: 'PQRS'),
                      numberNumPad(
                          number: '8', hasCapital: true, capital: 'TUV'),
                      numberNumPad(
                          number: '9', hasCapital: true, capital: 'WXYZ'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numberNumPad(number: '*'),
                      numberNumPad(
                          number: '0', hasCapital: true, capital: 'DEF'),
                      numberNumPad(number: '#'),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 30.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (display.isEmpty)
                          const Expanded(child: SizedBox())
                        else
                          Expanded(
                            child: SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: InkWell(
                                // color: primaryPurple,
                                borderRadius: BorderRadius.circular(50.0),
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  navigateTo(
                                    context,
                                    const AddContact(),
                                  );
                                  // FlutterContacts.insertContact(
                                  //   Contact(
                                  //     displayName: 'Alan',
                                  //     phones: [
                                  //       Phone('0933222111'),
                                  //     ],
                                  //     name: Name(
                                  //       first: 'Alan',
                                  //       last: 'Hassan',
                                  //     ),
                                  //   ),
                                  // ).whenComplete(() {
                                  //   showToast(text: 'Done');
                                  // });
                                },
                                child: Icon(
                                  Icons.person_add,
                                  color: themeProvider.isDarkMode == true
                                      ? MyTheme
                                          .darkTheme.appBarTheme.backgroundColor
                                      : MyTheme.lightTheme.appBarTheme
                                          .backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: FloatingActionButton(
                            heroTag: 'CallNow',
                            backgroundColor: themeProvider.isDarkMode == true
                                ? MyTheme.darkTheme.appBarTheme.backgroundColor
                                : MyTheme
                                    .lightTheme.appBarTheme.backgroundColor,
                            foregroundColor: Colors.white,
                            onPressed: () async {
                              if (display.isNotEmpty) {
                                CacheHelper.saveData(
                                    key: 'recentNumber', value: display);
                                FlutterPhoneDirectCaller.callNumber(display);
                                setState(() {
                                  display = display.substring(
                                      0, display.length - display.length);
                                });
                              } else {
                                if (CacheHelper.getData(key: 'recentNumber') !=
                                    null) {
                                  setState(() {
                                    display = CacheHelper.getData(
                                        key: 'recentNumber');
                                  });
                                } else {
                                  showToast(
                                    text:
                                        '${AppLocalization.of(context)?.getTranslatedValue('enterPhoneNum')}',
                                  );
                                }
                              }
                            },
                            child: const Icon(Icons.call_rounded),
                          ),
                        ),
                        if (display.isEmpty)
                          const Expanded(child: SizedBox())
                        else
                          Expanded(
                            child: SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: InkWell(
                                // color: primaryPurple,
                                borderRadius: BorderRadius.circular(50.0),
                                customBorder: const CircleBorder(),
                                onLongPress: () {
                                  if (CacheHelper.getData(
                                          key: 'isVibrationEnabled') ==
                                      true) {
                                    Vibration.vibrate(
                                      duration: 50,
                                    );
                                  }
                                  if (display.isNotEmpty) {
                                    setState(() {
                                      display = display.substring(
                                          0, display.length - display.length);
                                    });
                                  }
                                },
                                onTap: () {
                                  if (CacheHelper.getData(
                                          key: 'isVibrationEnabled') ==
                                      true) {
                                    Vibration.vibrate(
                                      duration: 50,
                                    );
                                  }
                                  if (display.isNotEmpty) {
                                    setState(() {
                                      display = display.substring(
                                          0, display.length - 1);
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.backspace,
                                  color: themeProvider.isDarkMode == true
                                      ? MyTheme
                                          .darkTheme.appBarTheme.backgroundColor
                                      : MyTheme.lightTheme.appBarTheme
                                          .backgroundColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget numberNumPad({
    required String number,
    String capital = '',
    bool hasCapital = false,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height: 80.0,
      width: 80.0,
      child: MaterialButton(
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        disabledElevation: 0.0,
        hoverElevation: 0.0,
        color: themeProvider.isDarkMode == true
            ? MyTheme.darkTheme.cardColor
            : MyTheme.lightTheme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          // side: BorderSide(
          //   color: primaryPurple,
          // ),
        ),
        onPressed: () async {
          if (CacheHelper.getData(key: 'isSoundEnabled') == true) {
            await _audioCache.play('key_pad_effect.mp3');
          }
          if (CacheHelper.getData(key: 'isVibrationEnabled') == true) {
            Vibration.vibrate(
              duration: 50,
            );
          }
          setState(() {
            display = display + number;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Helvetica New Medium',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hasCapital)
              Text(
                capital,
                style: const TextStyle(
                  fontFamily: 'Helvetica New Medium',
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

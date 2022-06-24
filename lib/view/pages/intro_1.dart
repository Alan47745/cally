import 'package:cally/localization/localization.dart';
import 'package:cally/model/custom_page_route.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/intro_2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FirstIntro extends StatefulWidget {
  @override
  _FirstIntroState createState() {
    return _FirstIntroState();
  }
}

class _FirstIntroState extends State<FirstIntro> {
  Future<void> confirmPermission() async {
    if (await Permission.contacts.request().isGranted &&
        await Permission.phone.request().isGranted) {
      return;
    } else {
      Permission.contacts.request().then((value) {
        Permission.phone.request();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    confirmPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/img/Group 2640.png'),
              Column(
                children: [
                  Text(
                    "${AppLocalization.of(context)?.getTranslatedValue('callAndReceive')}",
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "${AppLocalization.of(context)?.getTranslatedValue('callAndReceiveText')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomPageRoute(
                        child: SecondIntro(),
                        direction: AxisDirection.left,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryPurple),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "${AppLocalization.of(context)?.getTranslatedValue('start')}",
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

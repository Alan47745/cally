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
        await Permission.phone.request().isGranted &&
        await Permission.sms.isGranted) {
      return;
    } else {
      await Permission.contacts.request();
      await Permission.phone.request();
      await Permission.sms.request();
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
                children: const [
                  Text(
                    "Call And Receive",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Poppins Regular',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Call and Receive to your personal\nfriends/neighbors anonymously",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: 'Poppins Regular',
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
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Poppins Regular',
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

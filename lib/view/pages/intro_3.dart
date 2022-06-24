import 'package:cally/utils/constant.dart';
import 'package:cally/view/auth/sign_user.dart';
import 'package:flutter/material.dart';
import 'package:cally/model/custom_page_route.dart';

class ThirdIntro extends StatefulWidget {
  @override
  _ThirdIntroState createState() {
    return _ThirdIntroState();
  }
}

class _ThirdIntroState extends State<ThirdIntro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/img/Group 2663.png'),
            Column(
              children: const [
                Text(
                  'Personal Privacy',
                  style: TextStyle(
                    fontSize: 28.0,
                  ),
                ),
                // nothing
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Improve your personal privacy\nand security',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                  Navigator.of(context).pushAndRemoveUntil(
                    CustomPageRoute(
                      child: SignUser(),
                      direction: AxisDirection.left,
                      duration: const Duration(milliseconds: 300),
                    ),
                    (route) => false,
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
                  'Manage Profile',
                  style: TextStyle(
                    fontSize: 14.0,
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

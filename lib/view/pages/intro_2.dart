import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/intro_3.dart';
import 'package:flutter/material.dart';
import 'package:cally/model/custom_page_route.dart';

class SecondIntro extends StatefulWidget {
  @override
  _SecondIntroState createState() {
    return _SecondIntroState();
  }
}

class _SecondIntroState extends State<SecondIntro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/img/Group 476.png'),
            Column(
              children: const [
                Text(
                  'Hide The Identity',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: 'Poppins Regular',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Hide the identity of\nyour private contacts',
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
                      child: ThirdIntro(),
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
                  'Next',
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
    );
  }
}
